from __future__ import annotations

import argparse
import sys
from concurrent.futures import ThreadPoolExecutor
import os

from .build import build_notebooks
from .generate import health_markdown, notebook_metrics, sync_project, write_generated_typst
from .models import Part
from .parser import parse_source, slugify
from .project import discover_notebooks, project_root, select_notebooks
from .scaffold import create_notebook
from .toml_io import write_manifest
from .validate import validate, validation_markdown
from .migrate import migrate_legacy_layout
from .content_scope import ensure_content_scope


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="python -m cuadernos",
        description="Gestión editorial, validación y compilación automática del proyecto Cuadernos.",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_list = sub.add_parser("list", help="Listar los cuadernos detectados automáticamente")
    p_list.add_argument("selectors", nargs="*")

    p_build = sub.add_parser("build", help="Compilar cuadernos de forma incremental")
    p_build.add_argument("selectors", nargs="*")
    p_build.add_argument("--all", action="store_true", help="Seleccionar todos los cuadernos")
    p_build.add_argument("--force", action="store_true", help="Ignorar la caché")
    p_build.add_argument("--jobs", type=int, default=None)

    p_update = sub.add_parser(
        "update",
        help="Descubrir, sincronizar, validar, compilar y regenerar todo en un solo comando",
    )
    p_update.add_argument("selectors", nargs="*", help="IDs, slugs o áreas que se desean compilar")
    p_update.add_argument("--force", action="store_true", help="Ignorar la caché de compilación")
    p_update.add_argument("--jobs", type=int, default=None)
    p_update.add_argument("--no-build", action="store_true", help="Actualizar catálogo sin compilar PDF")
    p_update.add_argument("--force-previews", action="store_true")
    p_update.add_argument("--no-previews", action="store_true", help="No generar previews del README")
    p_update.add_argument(
        "--keep-going",
        action="store_true",
        help="Intentar compilar aunque existan errores de validación previos",
    )

    p_check = sub.add_parser("check", help="Validar metadatos, fuentes y bibliografía")
    p_check.add_argument("--write", action="store_true", help="Actualizar docs/VALIDATION.md")

    p_sync = sub.add_parser("sync", help="Regenerar manifiestos derivados, previews y catálogos")
    p_sync.add_argument("--force-previews", action="store_true")
    p_sync.add_argument("--no-previews", action="store_true", help="No generar previews del README")
    p_sync.add_argument(
        "--no-refresh-parts",
        action="store_true",
        help="No sincronizar las partes del manifiesto con content.typ",
    )

    p_stats = sub.add_parser("stats", help="Mostrar el panel de salud")
    p_stats.add_argument("--write", action="store_true", help="Actualizar docs/HEALTH.md")

    p_migrate = sub.add_parser(
        "migrate",
        help="Ejecutar manualmente la migración del formato antiguo",
    )

    p_new = sub.add_parser("new", help="Crear un cuaderno y registrarlo automáticamente")
    p_new.add_argument("--area", required=True, help="Área; puede ser nueva, por ejemplo Medicina")
    p_new.add_argument("--title", required=True)
    p_new.add_argument("--id", dest="notebook_id", default=None, help="Opcional; se asigna automáticamente")
    p_new.add_argument("--slug", default=None, help="Opcional; se deriva automáticamente del título")
    p_new.add_argument("--style", default="fullimage", choices=["solid", "fullimage", "wiley", "wiley2"])
    p_new.add_argument("--author", default=None)
    p_new.add_argument("--part", action="append", default=[])
    return parser


def refresh_parts(notebooks) -> None:
    """Hace que cuaderno.toml refleje siempre las partes activas de content.typ.

    Conserva el estado, resumen y referencias de una parte existente cuando su
    slug sigue siendo el mismo. Las partes nuevas se registran automáticamente.
    """
    for notebook in notebooks:
        if not notebook.main_file:
            continue
        stats = parse_source(notebook.content_path)
        previous = {part.slug: part for part in notebook.parts}
        parts: list[Part] = []
        for parsed in stats.parts:
            slug = slugify(parsed.title)
            old = previous.get(slug)
            parts.append(
                Part(
                    title=parsed.title,
                    slug=slug,
                    status=old.status if old else "outline",
                    references=old.references if old else [],
                    summary=old.summary if old else "",
                )
            )
        if parts != notebook.parts:
            write_manifest(notebook, parts=parts)


def prepare_project(notebooks, *, refresh: bool = True):
    workers = max(1, min(4, os.cpu_count() or 1, len(notebooks) or 1))

    # `content.typ` se evalúa como un módulo independiente al usar `include`.
    # Por tanto, debe importar explícitamente la API de la plantilla. El bloque
    # se inserta de forma idempotente también en cuadernos añadidos a mano.
    with ThreadPoolExecutor(max_workers=workers) as pool:
        list(pool.map(ensure_content_scope, notebooks))

    if refresh:
        refresh_parts(notebooks)
        notebooks = discover_notebooks(project_root())
        workers = max(1, min(4, os.cpu_count() or 1, len(notebooks) or 1))

    with ThreadPoolExecutor(max_workers=workers) as pool:
        list(pool.map(write_generated_typst, notebooks))
    return notebooks


def cmd_list(notebooks) -> int:
    if not notebooks:
        print("No se encontraron cuadernos.")
        return 1
    width = max(len(n.title) for n in notebooks)
    for n in notebooks:
        metrics = notebook_metrics(n)
        print(
            f"{n.id:8}  {n.title:<{width}}  {n.status_label:<13}  "
            f"{int(metrics['progress']):3}%  {int(metrics['chapters']):3} cap.  {n.relative_dir}"
        )
    return 0


def _print_build_results(results) -> tuple[int, int, int]:
    """Muestra la compilación y devuelve (correctos, omitidos, fallidos)."""

    succeeded = 0
    skipped = 0
    failed = 0
    for result in results:
        if result.skipped:
            skipped += 1
            print(f"[SKIP]  {result.notebook.id}  {result.notebook.title} — {result.message}")
        elif result.ok:
            succeeded += 1
            print(f"[OK]    {result.notebook.id}  {result.notebook.title}")
        else:
            failed += 1
            print(f"[ERROR] {result.notebook.id}  {result.notebook.title}")
            if result.message:
                print(result.message)
    return succeeded, skipped, failed


def cmd_build(notebooks, args) -> int:
    selected = notebooks if args.all else select_notebooks(notebooks, args.selectors)
    if not selected:
        print("Ningún cuaderno coincide con los selectores.", file=sys.stderr)
        return 2
    results = build_notebooks(selected, force=args.force, jobs=args.jobs)
    succeeded, skipped, failed = _print_build_results(results)
    print(f"Compilación: {succeeded} correctos, {skipped} omitidos y {failed} fallidos.")
    # El README y las portadas se regeneran con los PDF recién creados.
    sync_project(discover_notebooks(project_root()))
    return 1 if failed else 0


def cmd_update(notebooks, args) -> int:
    notebooks = prepare_project(notebooks, refresh=True)
    issues = validate(notebooks)
    errors = [issue for issue in issues if issue.severity == "error"]
    if errors:
        for issue in errors:
            location = f" ({issue.path.relative_to(project_root())})" if issue.path else ""
            print(f"[ERROR] {issue.code}: {issue.message}{location}")
        if not args.keep_going:
            print("Se detuvo la compilación. Corrige los errores o usa --keep-going.", file=sys.stderr)
            sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
            return 1

    build_succeeded = 0
    build_skipped = 0
    build_failed = 0
    if not args.no_build:
        selected = select_notebooks(notebooks, args.selectors)
        if not selected:
            print("Ningún cuaderno coincide con los selectores.", file=sys.stderr)
            return 2
        results = build_notebooks(selected, force=args.force, jobs=args.jobs)
        build_succeeded, build_skipped, build_failed = _print_build_results(results)

    notebooks = discover_notebooks(project_root())
    final_issues = sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
    final_errors = sum(issue.severity == "error" for issue in final_issues)
    final_warnings = sum(issue.severity == "warning" for issue in final_issues)

    print(f"Actualización completa: {len(notebooks)} cuadernos detectados.")
    if args.no_build:
        print("Compilación: omitida por --no-build.")
    else:
        print(
            f"Compilación: {build_succeeded} correctos, {build_skipped} omitidos "
            f"y {build_failed} fallidos."
        )
    print(
        f"Validación editorial: {final_errors} errores y "
        f"{final_warnings} advertencias."
    )
    return 1 if build_failed or final_errors else 0


def cmd_check(notebooks, args) -> int:
    notebooks = prepare_project(notebooks, refresh=False)
    issues = validate(notebooks)
    for issue in issues:
        location = f" ({issue.path.relative_to(project_root())})" if issue.path else ""
        print(f"[{issue.severity.upper():7}] {issue.code}: {issue.message}{location}")
    errors = sum(issue.severity == "error" for issue in issues)
    warnings = sum(issue.severity == "warning" for issue in issues)
    print(f"\nResultado: {errors} errores, {warnings} advertencias, {len(issues)} incidencias.")
    if args.write:
        path = project_root() / "docs" / "VALIDATION.md"
        path.parent.mkdir(exist_ok=True)
        path.write_text(validation_markdown(notebooks, issues), encoding="utf-8")
    return 1 if errors else 0


def cmd_sync(notebooks, args) -> int:
    notebooks = prepare_project(notebooks, refresh=not args.no_refresh_parts)
    issues = sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
    print(f"Sincronizados {len(notebooks)} cuadernos detectados automáticamente.")
    print(
        f"Validación: {sum(i.severity == 'error' for i in issues)} errores, "
        f"{sum(i.severity == 'warning' for i in issues)} advertencias."
    )
    return 1 if any(i.severity == "error" for i in issues) else 0


def cmd_stats(notebooks, args) -> int:
    issues = validate(notebooks)
    report = health_markdown(notebooks, issues)
    print(report)
    if args.write:
        path = project_root() / "docs" / "HEALTH.md"
        path.parent.mkdir(exist_ok=True)
        path.write_text(report, encoding="utf-8")
    return 0


def main(argv: list[str] | None = None) -> int:
    parser = make_parser()
    args = parser.parse_args(argv)
    root = project_root()

    # La actualización normal nunca renombra carpetas ni mueve PDF. La migración
    # del formato antiguo es una operación explícita porque puede modificar el
    # árbol del repositorio.
    if args.command == "migrate":
        migration_messages = migrate_legacy_layout(root)
        if not migration_messages:
            print("No hay cambios de migración pendientes.")
            return 0
        print(f"Migración: {len(migration_messages)} cambios aplicados.")
        for message in migration_messages:
            print(f"  - {message}")
        return 0

    notebooks = discover_notebooks(root)

    if args.command == "new":
        try:
            notebook = create_notebook(
                root,
                area=args.area,
                notebook_id=args.notebook_id,
                title=args.title,
                slug=args.slug,
                style=args.style,
                author=args.author,
                parts=args.part,
            )
        except FileExistsError as exc:
            print(str(exc), file=sys.stderr)
            return 1
        print(f"Creado {notebook.id}: {notebook.relative_dir}")
        # Aparece inmediatamente en README y catálogos, aun antes de compilarse.
        notebooks = discover_notebooks(root)
        prepare_project(notebooks, refresh=True)
        sync_project(discover_notebooks(root))
        print("Catálogo actualizado. Ejecuta `python -m cuadernos update` para compilarlo.")
        return 0
    if args.command == "list":
        return cmd_list(select_notebooks(notebooks, args.selectors))
    if args.command == "build":
        return cmd_build(notebooks, args)
    if args.command == "update":
        return cmd_update(notebooks, args)
    if args.command == "check":
        return cmd_check(notebooks, args)
    if args.command == "sync":
        return cmd_sync(notebooks, args)
    if args.command == "stats":
        return cmd_stats(notebooks, args)
    return 2

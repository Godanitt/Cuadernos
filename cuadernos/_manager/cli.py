from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

from .build import build_notebooks
from .generate import health_markdown, notebook_metrics, sync_project
from .migrate import normalize_notebook_names
from .project import discover_notebooks, project_root, select_notebooks
from .validate import validate, validation_markdown

_SOURCE_SUFFIXES = {".typ", ".bib", ".png", ".jpg", ".jpeg", ".webp", ".svg", ".csv", ".json"}


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="python -m cuadernos",
        description="Lee los mains Typst, compila y reconstruye el catálogo de Cuadernos.",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_list = sub.add_parser("list", help="Listar los mains detectados")
    p_list.add_argument("selectors", nargs="*")

    p_build = sub.add_parser("build", help="Compilar cuadernos de forma incremental")
    p_build.add_argument("selectors", nargs="*")
    p_build.add_argument("--all", action="store_true")
    p_build.add_argument("--force", action="store_true")
    p_build.add_argument("--jobs", type=int, default=None)
    p_build.add_argument("--rebuild-lock", action="store_true")

    p_update = sub.add_parser("update", help="Leer mains, validar, compilar y regenerar el catálogo")
    p_update.add_argument("selectors", nargs="*")
    p_update.add_argument("--force", action="store_true")
    p_update.add_argument("--jobs", type=int, default=None)
    p_update.add_argument("--rebuild-lock", action="store_true")
    p_update.add_argument("--no-build", action="store_true")
    p_update.add_argument("--force-previews", action="store_true")
    p_update.add_argument("--no-previews", action="store_true")
    p_update.add_argument("--keep-going", action="store_true")

    p_check = sub.add_parser("check", help="Validar mains, portadas y bibliografías")
    p_check.add_argument("--write", action="store_true")

    p_sync = sub.add_parser("sync", help="Regenerar README y catálogos sin compilar")
    p_sync.add_argument("--force-previews", action="store_true")
    p_sync.add_argument("--no-previews", action="store_true")

    p_stats = sub.add_parser("stats", help="Mostrar el panel de salud")
    p_stats.add_argument("--write", action="store_true")

    p_watch = sub.add_parser("watch", help="Vigilar mains, capítulos, imágenes, datos y bibliografías")
    p_watch.add_argument("--interval", type=float, default=1.0)
    p_watch.add_argument("--previews", action="store_true")
    return parser


def source_snapshot(root: Path) -> tuple[tuple[str, int, int], ...]:
    paths: list[Path] = [root / "cuadernos.toml"]
    base = root / "cuadernos"
    if base.exists():
        for path in base.rglob("*"):
            if path.is_file() and path.name != "README.md" and path.suffix.casefold() in _SOURCE_SUFFIXES:
                paths.append(path)
    signature = []
    for path in sorted(set(paths)):
        try:
            stat = path.stat()
        except OSError:
            continue
        signature.append((path.relative_to(root).as_posix(), stat.st_mtime_ns, stat.st_size))
    return tuple(signature)


def cmd_list(notebooks) -> int:
    if not notebooks:
        print("No se encontraron mains con bloque `notebook`.")
        return 1
    width = max(len(n.title) for n in notebooks)
    for notebook in notebooks:
        metrics = notebook_metrics(notebook)
        print(
            f"{notebook.id:8}  {notebook.title:<{width}}  {notebook.status_label:<13}  "
            f"{int(metrics['progress']):3}%  {int(metrics['chapters']):3} cap.  {notebook.relative_dir}"
        )
    return 0


def _print_build_results(results) -> int:
    failures = 0
    for result in results:
        if result.skipped:
            print(f"[SKIP]  {result.notebook.id}  {result.notebook.title} — {result.message}")
        elif result.ok:
            print(f"[OK]    {result.notebook.id}  {result.notebook.title}")
        else:
            failures += 1
            print(f"[ERROR] {result.notebook.id}  {result.notebook.title}")
            if result.message:
                print(result.message)
    return failures


def cmd_build(notebooks, args) -> int:
    selected = notebooks if args.all else select_notebooks(notebooks, args.selectors)
    if not selected:
        print("Ningún cuaderno coincide con los selectores.", file=sys.stderr)
        return 2
    build_failures = _print_build_results(
        build_notebooks(
            selected,
            all_notebooks=notebooks,
            force=args.force,
            jobs=args.jobs,
            rebuild_lock=args.rebuild_lock,
        )
    )
    sync_project(discover_notebooks(project_root()))
    return 1 if build_failures else 0


def _print_errors(issues) -> None:
    root = project_root()
    for issue in issues:
        if issue.severity != "error":
            continue
        location = f" ({issue.path.relative_to(root)})" if issue.path else ""
        print(f"[ERROR] {issue.code}: {issue.message}{location}")


def cmd_update(notebooks, args) -> int:
    issues = validate(notebooks)
    errors = [issue for issue in issues if issue.severity == "error"]
    if errors and not args.keep_going:
        _print_errors(errors)
        sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
        print("Se detuvo la compilación. Corrige el main o usa --keep-going.", file=sys.stderr)
        return 1

    build_failures = 0
    if not args.no_build:
        selected = select_notebooks(notebooks, args.selectors)
        if not selected:
            print("Ningún cuaderno coincide con los selectores.", file=sys.stderr)
            return 2
        build_failures = _print_build_results(
            build_notebooks(
                selected,
                all_notebooks=notebooks,
                force=args.force,
                jobs=args.jobs,
                rebuild_lock=args.rebuild_lock,
            )
        )

    notebooks = discover_notebooks(project_root())
    final = sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
    final_errors = sum(issue.severity == "error" for issue in final)
    final_warnings = sum(issue.severity == "warning" for issue in final)
    print(
        f"Actualización completa: {len(notebooks)} cuadernos; "
        f"{build_failures} fallos de compilación, "
        f"{final_errors} errores de validación y "
        f"{final_warnings} advertencias."
    )
    return 1 if build_failures or final_errors else 0


def cmd_check(notebooks, args) -> int:
    issues = validate(notebooks)
    root = project_root()
    for issue in issues:
        location = f" ({issue.path.relative_to(root)})" if issue.path else ""
        print(f"[{issue.severity.upper():7}] {issue.code}: {issue.message}{location}")
    errors = sum(issue.severity == "error" for issue in issues)
    warnings = sum(issue.severity == "warning" for issue in issues)
    print(f"\nResultado: {errors} errores, {warnings} advertencias, {len(issues)} incidencias.")
    if args.write:
        path = root / "docs" / "VALIDATION.md"
        path.parent.mkdir(exist_ok=True)
        path.write_text(validation_markdown(notebooks, issues), encoding="utf-8")
    return 1 if errors else 0


def cmd_sync(notebooks, args) -> int:
    issues = sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
    errors = sum(issue.severity == "error" for issue in issues)
    warnings = sum(issue.severity == "warning" for issue in issues)
    print(f"Sincronizados {len(notebooks)} cuadernos: {errors} errores y {warnings} advertencias.")
    return 1 if errors else 0


def cmd_stats(notebooks, args) -> int:
    report = health_markdown(notebooks, validate(notebooks))
    print(report)
    if args.write:
        path = project_root() / "docs" / "HEALTH.md"
        path.parent.mkdir(exist_ok=True)
        path.write_text(report, encoding="utf-8")
    return 0


def _watch_sync(root: Path, previews: bool) -> None:
    notebooks = discover_notebooks(root)
    issues = sync_project(notebooks, generate_previews=previews)
    print(
        f"Mains releídos: {len(notebooks)}; "
        f"{sum(i.severity == 'error' for i in issues)} errores y "
        f"{sum(i.severity == 'warning' for i in issues)} advertencias.",
        flush=True,
    )


def cmd_watch(root: Path, args) -> int:
    interval = max(0.25, float(args.interval))
    _watch_sync(root, args.previews)
    previous = source_snapshot(root)
    print("Vigilancia activa. Ctrl+C para detenerla.", flush=True)
    try:
        while True:
            time.sleep(interval)
            current = source_snapshot(root)
            if current == previous:
                continue
            time.sleep(min(0.5, interval))
            _watch_sync(root, args.previews)
            previous = source_snapshot(root)
    except KeyboardInterrupt:
        print("Vigilancia detenida.")
        return 0


def main(argv: list[str] | None = None) -> int:
    args = make_parser().parse_args(argv)
    root = project_root()
    migrated = normalize_notebook_names(root)
    if migrated:
        print(f"[MIGRATE] Nombres normalizados: {migrated} cambios (sin números y con prefijos legibles).")
    notebooks = discover_notebooks(root)
    if args.command == "watch":
        return cmd_watch(root, args)
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

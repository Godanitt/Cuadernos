from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

from .build import build_documents
from .generate import health_markdown, notebook_metrics, sync_project
from .migrate import normalize_notebook_names
from .paper import sync_paper_output
from .project import (
    discover_notebooks,
    discover_papers,
    project_root,
    select_notebooks,
    select_papers,
)
from .validate import validate, validate_papers, validation_markdown

_SOURCE_SUFFIXES = {".typ", ".bib", ".png", ".jpg", ".jpeg", ".webp", ".svg", ".csv", ".json"}
_TARGETS = ("all", "cuadernos", "paper")


def _target_arg(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--target", choices=_TARGETS, default="all", help=argparse.SUPPRESS)


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="python run_all.py",
        description="Compila incrementalmente cuadernos (pdf/) y papers (paper/).",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_list = sub.add_parser("list", help="Listar documentos detectados")
    p_list.add_argument("selectors", nargs="*")
    _target_arg(p_list)

    p_build = sub.add_parser("build", help="Compilar documentos de forma incremental")
    p_build.add_argument("selectors", nargs="*")
    p_build.add_argument("--all", action="store_true")
    p_build.add_argument("--force", action="store_true")
    p_build.add_argument("--jobs", type=int, default=None)
    p_build.add_argument("--rebuild-lock", action="store_true")
    _target_arg(p_build)

    p_update = sub.add_parser("update", help="Validar, compilar y sincronizar el proyecto")
    p_update.add_argument("selectors", nargs="*")
    p_update.add_argument("--force", action="store_true")
    p_update.add_argument("--jobs", type=int, default=None)
    p_update.add_argument("--rebuild-lock", action="store_true")
    p_update.add_argument("--no-build", action="store_true")
    p_update.add_argument("--force-previews", action="store_true")
    p_update.add_argument("--no-previews", action="store_true")
    p_update.add_argument("--keep-going", action="store_true")
    _target_arg(p_update)

    p_check = sub.add_parser("check", help="Validar cuadernos y papers")
    p_check.add_argument("--write", action="store_true")
    _target_arg(p_check)

    p_sync = sub.add_parser("sync", help="Regenerar README y catálogos sin compilar")
    p_sync.add_argument("--force-previews", action="store_true")
    p_sync.add_argument("--no-previews", action="store_true")

    p_stats = sub.add_parser("stats", help="Mostrar el panel de salud de los cuadernos")
    p_stats.add_argument("--write", action="store_true")

    p_watch = sub.add_parser("watch", help="Vigilar fuentes de cuadernos y papers")
    p_watch.add_argument("--interval", type=float, default=1.0)
    p_watch.add_argument("--previews", action="store_true")
    return parser


def source_snapshot(root: Path) -> tuple[tuple[str, int, int], ...]:
    paths: list[Path] = [root / "cuadernos.toml", root / "typst.toml"]
    template_dir = root / "plantilla"
    if template_dir.exists():
        paths.extend(path for path in template_dir.rglob("*.typ") if path.is_file())
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


def _select(notebooks, papers, target: str, selectors: list[str]):
    selected = []
    if target in {"all", "cuadernos"}:
        selected.extend(select_notebooks(notebooks, selectors))
    if target in {"all", "paper"}:
        selected.extend(select_papers(papers, selectors))
    return selected


def _all_documents(notebooks, papers):
    return [*notebooks, *papers]


def cmd_list(notebooks, papers, args) -> int:
    selected_notebooks = select_notebooks(notebooks, args.selectors) if args.target in {"all", "cuadernos"} else []
    selected_papers = select_papers(papers, args.selectors) if args.target in {"all", "paper"} else []

    if selected_notebooks:
        print("CUADERNOS")
        width = max(len(n.title) for n in selected_notebooks)
        for notebook in selected_notebooks:
            metrics = notebook_metrics(notebook)
            print(
                f"{notebook.id:24}  {notebook.title:<{width}}  {notebook.status_label:<13}  "
                f"{int(metrics['progress']):3}%  {int(metrics['chapters']):3} cap.  {notebook.relative_dir}"
            )
    if selected_papers:
        if selected_notebooks:
            print()
        print("PAPERS")
        width = max(len(p.title) for p in selected_papers)
        for paper in selected_papers:
            print(f"{paper.id:24}  {paper.title:<{width}}  {paper.style:<9}  {paper.relative_dir}")

    if not selected_notebooks and not selected_papers:
        if args.target == "paper" and not papers:
            print("No hay papers registrados todavía en cuadernos/paper/.")
            return 0
        print("No se encontraron documentos que coincidan con los selectores.")
        return 1
    return 0


def _print_build_results(results) -> int:
    failures = 0
    for result in results:
        document = result.document
        label = "PAPER" if document.kind == "paper" else "CUADERNO"
        if result.skipped:
            print(f"[SKIP]  [{label:8}] {document.id} — {result.message}")
        elif result.ok:
            print(f"[OK]    [{label:8}] {document.id} — {document.title}")
        else:
            failures += 1
            print(f"[ERROR] [{label:8}] {document.id} — {document.title}")
            if result.message:
                print(result.message)
    return failures


def _sync_outputs(root: Path, notebooks, papers, *, sync_notebooks: bool, force_previews: bool = False, no_previews: bool = False):
    notebook_issues = []
    if sync_notebooks:
        notebook_issues = sync_project(
            notebooks,
            force_previews=force_previews,
            generate_previews=not no_previews,
        )
    sync_paper_output(papers, root)
    return notebook_issues


def cmd_build(root: Path, notebooks, papers, args) -> int:
    selectors = [] if args.all else args.selectors
    selected = _select(notebooks, papers, args.target, selectors)
    if not selected:
        if args.target == "paper" and not papers:
            print("No hay papers registrados; no hay nada que compilar.")
            sync_paper_output(papers, root)
            return 0
        print("Ningún documento coincide con los selectores.", file=sys.stderr)
        return 2

    build_failures = _print_build_results(
        build_documents(
            selected,
            all_documents=_all_documents(notebooks, papers),
            force=args.force,
            jobs=args.jobs,
            rebuild_lock=args.rebuild_lock,
        )
    )
    notebooks = discover_notebooks(root)
    papers = discover_papers(root)
    _sync_outputs(root, notebooks, papers, sync_notebooks=args.target != "paper", no_previews=False)
    return 1 if build_failures else 0


def _issues_for_target(notebooks, papers, target: str):
    issues = []
    if target in {"all", "cuadernos"}:
        issues.extend(validate(notebooks))
    if target in {"all", "paper"}:
        issues.extend(validate_papers(papers))
    return issues


def _print_errors(issues) -> None:
    root = project_root()
    for issue in issues:
        if issue.severity != "error":
            continue
        location = f" ({issue.path.relative_to(root)})" if issue.path else ""
        print(f"[ERROR] {issue.code}: {issue.message}{location}")


def cmd_update(root: Path, notebooks, papers, args) -> int:
    issues = _issues_for_target(notebooks, papers, args.target)
    errors = [issue for issue in issues if issue.severity == "error"]
    if errors and not args.keep_going:
        _print_errors(errors)
        _sync_outputs(
            root, notebooks, papers,
            sync_notebooks=args.target != "paper",
            force_previews=args.force_previews,
            no_previews=args.no_previews,
        )
        print("Se detuvo la compilación. Corrige las fuentes o usa --keep-going.", file=sys.stderr)
        return 1

    build_failures = 0
    if not args.no_build:
        selected = _select(notebooks, papers, args.target, args.selectors)
        if not selected:
            if args.target == "paper" and not papers:
                print("No hay papers registrados; el target paper queda sin cambios.")
            else:
                print("Ningún documento coincide con los selectores.", file=sys.stderr)
                return 2
        else:
            build_failures = _print_build_results(
                build_documents(
                    selected,
                    all_documents=_all_documents(notebooks, papers),
                    force=args.force,
                    jobs=args.jobs,
                    rebuild_lock=args.rebuild_lock,
                )
            )

    notebooks = discover_notebooks(root)
    papers = discover_papers(root)
    notebook_issues = _sync_outputs(
        root, notebooks, papers,
        sync_notebooks=args.target != "paper",
        force_previews=args.force_previews,
        no_previews=args.no_previews,
    )
    final_issues = _issues_for_target(notebooks, papers, args.target)
    # sync_project ya valida cuadernos; final_issues se usa como resumen común.
    final_errors = sum(issue.severity == "error" for issue in final_issues)
    final_warnings = sum(issue.severity == "warning" for issue in final_issues)
    print(
        f"Actualización completa: {len(notebooks)} cuadernos, {len(papers)} papers; "
        f"{build_failures} fallos de compilación, "
        f"{final_errors} errores de validación y {final_warnings} advertencias."
    )
    return 1 if build_failures or final_errors else 0


def cmd_check(root: Path, notebooks, papers, args) -> int:
    issues = _issues_for_target(notebooks, papers, args.target)
    for issue in issues:
        location = f" ({issue.path.relative_to(root)})" if issue.path else ""
        print(f"[{issue.severity.upper():7}] {issue.code}: {issue.message}{location}")
    errors = sum(issue.severity == "error" for issue in issues)
    warnings = sum(issue.severity == "warning" for issue in issues)
    print(f"\nResultado: {errors} errores, {warnings} advertencias, {len(issues)} incidencias.")
    if args.write and args.target in {"all", "cuadernos"}:
        path = root / "docs" / "VALIDATION.md"
        path.parent.mkdir(exist_ok=True)
        notebook_issues = validate(notebooks)
        path.write_text(validation_markdown(notebooks, notebook_issues), encoding="utf-8")
    return 1 if errors else 0


def cmd_sync(root: Path, notebooks, papers, args) -> int:
    issues = sync_project(notebooks, force_previews=args.force_previews, generate_previews=not args.no_previews)
    sync_paper_output(papers, root)
    errors = sum(issue.severity == "error" for issue in issues)
    warnings = sum(issue.severity == "warning" for issue in issues)
    print(f"Sincronizados {len(notebooks)} cuadernos y {len(papers)} papers: {errors} errores y {warnings} advertencias.")
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
    papers = discover_papers(root)
    issues = sync_project(notebooks, generate_previews=previews)
    sync_paper_output(papers, root)
    print(
        f"Fuentes releídas: {len(notebooks)} cuadernos, {len(papers)} papers; "
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
        print(f"[MIGRATE] Nombres normalizados: {migrated} cambios.")

    notebooks = discover_notebooks(root)
    papers = discover_papers(root)

    if args.command == "watch":
        return cmd_watch(root, args)
    if args.command == "list":
        return cmd_list(notebooks, papers, args)
    if args.command == "build":
        return cmd_build(root, notebooks, papers, args)
    if args.command == "update":
        return cmd_update(root, notebooks, papers, args)
    if args.command == "check":
        return cmd_check(root, notebooks, papers, args)
    if args.command == "sync":
        return cmd_sync(root, notebooks, papers, args)
    if args.command == "stats":
        return cmd_stats(notebooks, args)
    return 2

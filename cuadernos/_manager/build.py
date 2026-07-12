from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path
import json
import os
import subprocess

from .models import Notebook
from .generate import write_generated_typst
from .tinymist import (
    compile_command,
    detect_tinymist,
    inspect_lock,
    notebook_main_key,
)


@dataclass(slots=True)
class BuildResult:
    notebook: Notebook
    ok: bool
    skipped: bool = False
    message: str = ""
    digest: str = ""
    lock_updated: bool = False


def _hash_file(hasher, path: Path, root: Path) -> None:
    hasher.update(str(path.relative_to(root)).encode("utf-8", errors="replace"))
    hasher.update(path.read_bytes())


def notebook_dependency_files(notebook: Notebook) -> list[Path]:
    root = notebook.root
    files: list[Path] = [notebook.manifest_path]
    if notebook.path.exists():
        files.extend(
            path
            for path in notebook.path.rglob("*")
            if path.is_file()
            and "generated" not in path.parts
            and path.suffix.lower() != ".pdf"
        )
    template_dir = root / "plantilla"
    if template_dir.exists():
        files.extend(path for path in template_dir.rglob("*.typ") if path.is_file())
    for project_file in (
        root / "typst.toml",
        root / "cuadernos.toml",
        root / ".vscode" / "settings.json",
    ):
        if project_file.exists():
            files.append(project_file)
    return sorted(set(files))


def notebook_digest(notebook: Notebook) -> str:
    hasher = sha256()
    for path in notebook_dependency_files(notebook):
        try:
            _hash_file(hasher, path, notebook.root)
        except OSError:
            continue
    return hasher.hexdigest()


def load_cache(root: Path) -> dict[str, dict[str, str]]:
    path = root / ".cuadernos-cache" / "build.json"
    if not path.exists():
        return {}
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {}


def save_cache(root: Path, cache: dict[str, dict[str, str]]) -> None:
    path = root / ".cuadernos-cache" / "build.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(cache, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def load_tinymist_state(root: Path) -> dict[str, object]:
    path = root / ".cuadernos-cache" / "tinymist.json"
    if not path.exists():
        return {}
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {}
    return value if isinstance(value, dict) else {}


def save_tinymist_state(root: Path, state: dict[str, object]) -> None:
    path = root / ".cuadernos-cache" / "tinymist.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(state, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def _routable(notebook: Notebook) -> bool:
    return bool(notebook.main_file and notebook.main_path and notebook.main_path.exists())


def _compile_one_tinymist(notebook: Notebook, *, force: bool, cache_entry: dict[str, str] | None, route_present: bool) -> BuildResult:
    if not notebook.main_file:
        return BuildResult(notebook, ok=True, skipped=True, message="sin fuente: planificado")

    write_generated_typst(notebook, recover_covers=False)
    main = notebook.main_path
    output = notebook.output_path
    if main is None or not main.exists():
        return BuildResult(notebook, ok=False, message=f"no existe {notebook.main_file}")
    if output is None:
        return BuildResult(notebook, ok=False, message="output_file vacío")

    digest = notebook_digest(notebook)
    if (
        not force
        and route_present
        and cache_entry
        and cache_entry.get("digest") == digest
        and output.exists()
    ):
        return BuildResult(notebook, ok=True, skipped=True, message="sin cambios", digest=digest)

    cli = detect_tinymist()
    if cli is None:
        return BuildResult(
            notebook,
            ok=False,
            message=(
                "Tinymist CLI no está disponible. Instálalo, añade `tinymist` al PATH "
                "o define TINYMIST_BIN. Se necesita para compilar y actualizar tinymist.lock."
            ),
            digest=digest,
        )

    write_generated_typst(notebook, recover_covers=True)
    output.parent.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ)
    env["TYPST_PROJECT_ROOT"] = str(notebook.root)
    proc = subprocess.run(
        compile_command(cli, root=notebook.root, main=main, output=output),
        cwd=notebook.root,
        env=env,
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        return BuildResult(
            notebook,
            ok=False,
            message=proc.stderr.strip() or proc.stdout.strip(),
            digest=digest,
        )
    return BuildResult(notebook, ok=True, digest=digest, lock_updated=True)


def build_notebooks(
    notebooks: list[Notebook],
    *,
    all_notebooks: list[Notebook] | None = None,
    force: bool = False,
    jobs: int | None = None,
    rebuild_lock: bool = False,
) -> list[BuildResult]:
    """Compila incrementalmente y mantiene un único `tinymist.lock`.

    Tinymist escribe una base compartida, por lo que las compilaciones se hacen
    deliberadamente en serie. `jobs` se conserva en la API para no romper los
    comandos antiguos, pero no se usa con este backend.
    """

    if not notebooks:
        return []
    root = notebooks[0].root
    all_notebooks = all_notebooks or notebooks
    cli = detect_tinymist()
    if cli is None:
        return [
            BuildResult(
                notebook,
                ok=False,
                message=(
                    "Tinymist CLI no está disponible. Instálalo, añade `tinymist` al PATH "
                    "o define TINYMIST_BIN para generar automáticamente tinymist.lock."
                ),
            )
            for notebook in notebooks
        ]

    routable = [notebook for notebook in all_notebooks if _routable(notebook)]
    by_main = {
        notebook_main_key(root, notebook.main_path): notebook
        for notebook in routable
        if notebook.main_path is not None
    }
    expected_mains = set(by_main)
    inspection = inspect_lock(root)
    previous = load_tinymist_state(root)
    previous_mains = {
        str(value) for value in previous.get("mains", [])
        if isinstance(value, str)
    }
    known_mains = set(inspection.mains) if inspection.valid else set()

    # Solo se eliminan automáticamente rutas que fueron gestionadas por esta CLI.
    # Un tinymist.lock puede contener además otros documentos Typst del usuario.
    removed_routes = previous_mains - expected_mains
    rebuild = rebuild_lock or not inspection.valid or bool(removed_routes)
    if rebuild:
        (root / "tinymist.lock").unlink(missing_ok=True)
        known_mains.clear()

    selected_ids = {notebook.id for notebook in notebooks}
    missing_mains = expected_mains - known_mains
    targets_by_id: dict[str, Notebook] = {notebook.id: notebook for notebook in notebooks}
    if rebuild:
        targets_by_id.update({notebook.id: notebook for notebook in routable})
    else:
        targets_by_id.update({by_main[main].id: by_main[main] for main in missing_mains})

    cache = load_cache(root)
    results: list[BuildResult] = []
    failed = False
    for notebook in sorted(targets_by_id.values(), key=lambda item: item.id):
        main_key = (
            notebook_main_key(root, notebook.main_path)
            if notebook.main_path is not None and notebook.main_path.exists()
            else ""
        )
        must_force = force and notebook.id in selected_ids
        result = _compile_one_tinymist(
            notebook,
            force=must_force,
            cache_entry=cache.get(notebook.id),
            route_present=main_key in known_mains and not rebuild,
        )
        results.append(result)
        if result.ok and result.digest:
            cache[notebook.id] = {
                "digest": result.digest,
                "output": notebook.output_file,
            }
        if result.ok and main_key and (result.lock_updated or result.skipped):
            known_mains.add(main_key)
        if not result.ok:
            failed = True

    save_cache(root, cache)

    final_inspection = inspect_lock(root)
    if not failed and final_inspection.valid and expected_mains.issubset(set(final_inspection.mains)):
        save_tinymist_state(
            root,
            {
                "version": cli.version,
                "mode": cli.lock_mode,
                "mains": sorted(expected_mains),
            },
        )
    elif not failed and not final_inspection.valid:
        # El esquema es experimental y puede cambiar. Conservamos el inventario
        # propio solo si todos los comandos terminaron correctamente.
        save_tinymist_state(
            root,
            {
                "version": cli.version,
                "mode": cli.lock_mode,
                "mains": sorted(expected_mains),
            },
        )

    return results

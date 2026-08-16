from __future__ import annotations

from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path
from typing import Any
import json
import os
import subprocess

from .tinymist import compile_command, detect_tinymist, inspect_lock, notebook_main_key


@dataclass(slots=True)
class BuildResult:
    document: Any
    ok: bool
    skipped: bool = False
    message: str = ""
    digest: str = ""
    lock_updated: bool = False


def _hash_file(hasher, path: Path, root: Path) -> None:
    hasher.update(str(path.relative_to(root)).encode("utf-8", errors="replace"))
    hasher.update(path.read_bytes())


def document_dependency_files(document) -> list[Path]:
    root = document.root
    files: list[Path] = [document.main_path]

    # Cada documento es autocontenido. En papers se recomienda una carpeta por
    # artículo bajo cuadernos/paper/, igual que los cuadernos por área.
    if document.path.exists():
        files.extend(
            path
            for path in document.path.rglob("*")
            if path.is_file() and path.suffix.lower() != ".pdf"
        )

    template_root = root / "plantilla"
    if document.kind == "paper":
        paper_templates = template_root / "paper"
        if paper_templates.exists():
            files.extend(path for path in paper_templates.rglob("*.typ") if path.is_file())
    elif template_root.exists():
        paper_templates = template_root / "paper"
        files.extend(
            path
            for path in template_root.rglob("*.typ")
            if path.is_file() and paper_templates not in path.parents
        )

    for project_file in (
        root / "typst.toml",
        root / "cuadernos.toml",
        root / ".vscode" / "settings.json",
    ):
        if project_file.exists():
            files.append(project_file)
    return sorted(set(files))


def document_digest(document) -> str:
    hasher = sha256()
    for path in document_dependency_files(document):
        try:
            _hash_file(hasher, path, document.root)
        except OSError:
            continue
    return hasher.hexdigest()


def load_cache(root: Path) -> dict[str, dict[str, str]]:
    path = root / ".cuadernos-cache" / "build.json"
    if not path.exists():
        return {}
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {}
    return value if isinstance(value, dict) else {}


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


def _routable(document) -> bool:
    return bool(document.main_file and document.main_path and document.main_path.exists())


def _cache_entry(cache: dict[str, dict[str, str]], document) -> dict[str, str] | None:
    entry = cache.get(document.cache_key)
    # Compatibilidad con la caché anterior, donde los cuadernos usaban el ID a secas.
    if entry is None and document.kind == "cuaderno":
        entry = cache.get(document.id)
    return entry


def _compile_one_tinymist(document, *, force: bool, cache_entry: dict[str, str] | None, route_present: bool) -> BuildResult:
    if not document.main_file:
        return BuildResult(document, ok=True, skipped=True, message="sin fuente: planificado")

    main = document.main_path
    output = document.output_path
    if main is None or not main.exists():
        return BuildResult(document, ok=False, message=f"no existe {document.main_file}")
    if output is None:
        return BuildResult(document, ok=False, message="output_file vacío")

    digest = document_digest(document)
    if (
        not force
        and route_present
        and cache_entry
        and cache_entry.get("digest") == digest
        and output.exists()
    ):
        return BuildResult(document, ok=True, skipped=True, message="sin cambios", digest=digest)

    cli = detect_tinymist()
    if cli is None:
        return BuildResult(
            document,
            ok=False,
            message=(
                "Tinymist CLI no está disponible. Instálalo, añade `tinymist` al PATH "
                "o define TINYMIST_BIN. Se necesita para compilar y actualizar tinymist.lock."
            ),
            digest=digest,
        )

    output.parent.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ)
    env["TYPST_PROJECT_ROOT"] = str(document.root)
    proc = subprocess.run(
        compile_command(cli, root=document.root, main=main, output=output),
        cwd=document.root,
        env=env,
        capture_output=True,
        text=True,
    )
    if proc.returncode != 0:
        return BuildResult(
            document,
            ok=False,
            message=proc.stderr.strip() or proc.stdout.strip(),
            digest=digest,
        )
    return BuildResult(document, ok=True, digest=digest, lock_updated=True)


def build_documents(
    documents: list,
    *,
    all_documents: list | None = None,
    force: bool = False,
    jobs: int | None = None,
    rebuild_lock: bool = False,
) -> list[BuildResult]:
    """Compila cuadernos y papers incrementalmente con un único tinymist.lock.

    `documents` es exactamente lo solicitado por el usuario. A diferencia del
    gestor anterior, añadir una ruta nueva al lock no provoca que se compilen
    documentos no seleccionados. `--rebuild-lock` sí recompila el inventario
    completo porque el lock se crea de cero.
    """
    if not documents:
        return []

    root = documents[0].root
    all_documents = all_documents or documents
    cli = detect_tinymist()
    if cli is None:
        return [
            BuildResult(
                document,
                ok=False,
                message=(
                    "Tinymist CLI no está disponible. Instálalo, añade `tinymist` al PATH "
                    "o define TINYMIST_BIN para generar automáticamente tinymist.lock."
                ),
            )
            for document in documents
        ]

    routable = [document for document in all_documents if _routable(document)]
    expected_mains = {
        notebook_main_key(root, document.main_path)
        for document in routable
        if document.main_path is not None
    }
    selected_keys = {document.cache_key for document in documents}
    all_keys = {document.cache_key for document in routable}
    full_selection = selected_keys == all_keys

    inspection = inspect_lock(root)
    known_mains = set(inspection.mains) if inspection.valid else set()
    previous = load_tinymist_state(root)
    previous_mains = {
        str(value) for value in previous.get("mains", []) if isinstance(value, str)
    }
    removed_routes = previous_mains - expected_mains

    rebuild = rebuild_lock or (full_selection and bool(removed_routes))
    targets = list(routable) if rebuild else list(documents)
    if rebuild:
        (root / "tinymist.lock").unlink(missing_ok=True)
        known_mains.clear()

    cache = load_cache(root)
    results: list[BuildResult] = []
    failed = False
    selected_keys = {document.cache_key for document in documents}

    for document in sorted(targets, key=lambda item: (item.kind, item.id.casefold())):
        main_key = (
            notebook_main_key(root, document.main_path)
            if document.main_path is not None and document.main_path.exists()
            else ""
        )
        must_force = rebuild or (force and document.cache_key in selected_keys)
        result = _compile_one_tinymist(
            document,
            force=must_force,
            cache_entry=_cache_entry(cache, document),
            route_present=main_key in known_mains and not rebuild,
        )
        results.append(result)
        if result.ok and result.digest:
            cache[document.cache_key] = {
                "digest": result.digest,
                "output": document.output_file,
                "kind": document.kind,
            }
            if document.kind == "cuaderno":
                cache.pop(document.id, None)
        if result.ok and main_key and (result.lock_updated or result.skipped):
            known_mains.add(main_key)
        if not result.ok:
            failed = True

    save_cache(root, cache)

    # Solo una ejecución sobre todo el inventario certifica el estado global.
    if not failed and (full_selection or rebuild):
        final_inspection = inspect_lock(root)
        if (not final_inspection.valid) or expected_mains.issubset(set(final_inspection.mains)):
            save_tinymist_state(
                root,
                {
                    "version": cli.version,
                    "mode": cli.lock_mode,
                    "mains": sorted(expected_mains),
                },
            )

    return results


# Compatibilidad con imports anteriores.
def build_notebooks(notebooks: list, **kwargs) -> list[BuildResult]:
    all_notebooks = kwargs.pop("all_notebooks", None)
    return build_documents(notebooks, all_documents=all_notebooks, **kwargs)

from __future__ import annotations

from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path
import json
import os
import shutil
import subprocess

from .models import Notebook
from .generate import write_generated_typst


@dataclass(slots=True)
class BuildResult:
    notebook: Notebook
    ok: bool
    skipped: bool = False
    message: str = ""
    digest: str = ""


def _hash_file(hasher: "sha256", path: Path, root: Path) -> None:
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
            and path.suffix.lower() not in {".pdf"}
        )
    template_dir = root / "plantilla"
    if template_dir.exists():
        files.extend(path for path in template_dir.rglob("*.typ") if path.is_file())
    for project_file in (root / "typst.toml", root / "cuadernos.toml"):
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


def compile_one(notebook: Notebook, force: bool, cache_entry: dict[str, str] | None) -> BuildResult:
    if not notebook.main_file:
        return BuildResult(notebook, ok=True, skipped=True, message="sin fuente: planificado")

    # Generación rápida: no intenta recuperar imágenes desde PDF si el volumen
    # finalmente puede omitirse por caché.
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
        and cache_entry
        and cache_entry.get("digest") == digest
        and output.exists()
    ):
        return BuildResult(notebook, ok=True, skipped=True, message="sin cambios", digest=digest)

    typst = shutil.which("typst")
    if typst is None:
        return BuildResult(
            notebook,
            ok=False,
            message="Typst no está instalado o no está disponible en PATH",
            digest=digest,
        )

    # Solo los cuadernos que realmente van a compilarse intentan recuperar un
    # fondo de portada incrustado en un PDF antiguo.
    write_generated_typst(notebook, recover_covers=True)
    output.parent.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ)
    env["TYPST_PROJECT_ROOT"] = str(notebook.root)
    cmd = [
        typst,
        "compile",
        str(main.relative_to(notebook.root)),
        str(output.relative_to(notebook.root)),
        "--root",
        str(notebook.root),
    ]
    proc = subprocess.run(
        cmd,
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
    return BuildResult(notebook, ok=True, digest=digest)


def build_notebooks(notebooks: list[Notebook], force: bool = False, jobs: int | None = None) -> list[BuildResult]:
    if not notebooks:
        return []
    root = notebooks[0].root
    cache = load_cache(root)
    default_jobs = min(4, os.cpu_count() or 1)
    jobs = max(1, min(jobs or default_jobs, len(notebooks)))
    results: list[BuildResult] = []
    with ThreadPoolExecutor(max_workers=jobs) as pool:
        futures = {
            pool.submit(compile_one, notebook, force, cache.get(notebook.id)): notebook
            for notebook in notebooks
        }
        for future in as_completed(futures):
            results.append(future.result())
    for result in results:
        if result.ok and result.digest:
            cache[result.notebook.id] = {
                "digest": result.digest,
                "output": result.notebook.output_file,
            }
    save_cache(root, cache)
    return sorted(results, key=lambda result: result.notebook.id)

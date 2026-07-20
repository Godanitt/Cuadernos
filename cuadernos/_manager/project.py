from __future__ import annotations

from pathlib import Path

from .metadata import METADATA_START, MetadataError
from .models import Notebook, load_notebook


def project_root() -> Path:
    return Path(__file__).resolve().parents[2]


def _main_candidates(root: Path):
    base = root / "cuadernos"
    if not base.exists():
        return
    for area in sorted(path for path in base.iterdir() if path.is_dir() and not path.name.startswith("_")):
        for notebook_dir in sorted(path for path in area.iterdir() if path.is_dir()):
            for candidate in sorted(notebook_dir.glob("*.typ")):
                try:
                    head = candidate.read_text(encoding="utf-8", errors="replace")[:16000]
                except OSError:
                    continue
                if METADATA_START in head:
                    yield candidate


def discover_notebooks(root: Path | None = None) -> list[Notebook]:
    root = (root or project_root()).resolve()
    notebooks: list[Notebook] = []
    for path in _main_candidates(root) or ():
        try:
            notebooks.append(load_notebook(path, root))
        except (OSError, KeyError, TypeError, ValueError, MetadataError):
            # La validación informa con más detalle sobre mains mal formados. Aquí
            # solo evitamos que un archivo incompleto bloquee todo el catálogo.
            continue
    return sorted(
        notebooks,
        key=lambda n: (n.area_order, n.area_label.casefold(), n.id.casefold(), n.title.casefold()),
    )


def select_notebooks(notebooks: list[Notebook], selectors: list[str]) -> list[Notebook]:
    if not selectors:
        return notebooks
    normalized = {s.casefold() for s in selectors}
    selected: list[Notebook] = []
    for notebook in notebooks:
        candidates = {
            notebook.id.casefold(),
            notebook.slug.casefold(),
            notebook.area.casefold(),
            notebook.area_label.casefold(),
            notebook.title.casefold(),
            str(notebook.relative_dir).casefold(),
            notebook.main_file.casefold(),
        }
        if candidates & normalized or any(tag.casefold() in normalized for tag in notebook.tags):
            selected.append(notebook)
    return selected

from __future__ import annotations

from pathlib import Path
from .models import Notebook, load_notebook


def project_root() -> Path:
    return Path(__file__).resolve().parents[2]


def discover_notebooks(root: Path | None = None) -> list[Notebook]:
    root = (root or project_root()).resolve()
    manifests = (root / "cuadernos").rglob("cuaderno.toml")
    notebooks = [load_notebook(path, root) for path in manifests]
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
        }
        if candidates & normalized or any(tag.casefold() in normalized for tag in notebook.tags):
            selected.append(notebook)
    return selected

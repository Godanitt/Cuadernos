from __future__ import annotations

from pathlib import Path

from .metadata import METADATA_START, PAPER_METADATA_START, MetadataError
from .models import Notebook, load_notebook
from .paper import Paper, load_paper


def project_root() -> Path:
    return Path(__file__).resolve().parents[2]


def _main_candidates(root: Path):
    base = root / "cuadernos"
    if not base.exists():
        return
    for area in sorted(path for path in base.iterdir() if path.is_dir() and not path.name.startswith("_")):
        if area.name.casefold() == "paper":
            continue
        for notebook_dir in sorted(path for path in area.iterdir() if path.is_dir()):
            for candidate in sorted(notebook_dir.glob("*.typ")):
                try:
                    head = candidate.read_text(encoding="utf-8", errors="replace")[:16000]
                except OSError:
                    continue
                if METADATA_START in head:
                    yield candidate


def _paper_candidates(root: Path):
    base = root / "cuadernos" / "paper"
    if not base.exists():
        return
    for candidate in sorted(base.rglob("*.typ")):
        try:
            head = candidate.read_text(encoding="utf-8", errors="replace")[:16000]
        except OSError:
            continue
        if PAPER_METADATA_START in head:
            yield candidate


def discover_notebooks(root: Path | None = None) -> list[Notebook]:
    root = (root or project_root()).resolve()
    notebooks: list[Notebook] = []
    for path in _main_candidates(root) or ():
        try:
            notebooks.append(load_notebook(path, root))
        except (OSError, KeyError, TypeError, ValueError, MetadataError):
            continue
    return sorted(
        notebooks,
        key=lambda n: (n.area_order, n.area_label.casefold(), n.id.casefold(), n.title.casefold()),
    )


def discover_papers(root: Path | None = None) -> list[Paper]:
    root = (root or project_root()).resolve()
    papers: list[Paper] = []
    for path in _paper_candidates(root) or ():
        try:
            papers.append(load_paper(path, root))
        except (OSError, KeyError, TypeError, ValueError, MetadataError):
            continue
    return sorted(papers, key=lambda p: (p.id.casefold(), p.title.casefold()))


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


def select_papers(papers: list[Paper], selectors: list[str]) -> list[Paper]:
    if not selectors:
        return papers
    normalized = {s.casefold() for s in selectors}
    selected: list[Paper] = []
    for paper in papers:
        candidates = {
            paper.id.casefold(),
            paper.slug.casefold(),
            paper.title.casefold(),
            paper.style.casefold(),
            str(paper.relative_dir).casefold(),
            paper.main_file.casefold(),
        }
        if candidates & normalized or any(tag.casefold() in normalized for tag in paper.tags):
            selected.append(paper)
    return selected

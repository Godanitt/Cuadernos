from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any

from .metadata import read_paper_metadata
from .settings import load_project_settings

ALLOWED_PAPER_STYLES = {"ieee", "elsevier", "mdpi"}


def _list(value: Any, default: list[str] | None = None) -> list[str]:
    if value is None:
        return list(default or [])
    if isinstance(value, (list, tuple)):
        return [str(item) for item in value]
    return [str(value)]


@dataclass(slots=True)
class Paper:
    root: Path
    path: Path
    metadata_path: Path
    id: str
    slug: str
    title: str
    style: str
    authors: list[str]
    main_file: str
    output_file: str
    bibliography_file: str
    bibliography_enabled: bool
    abstract: str
    keywords: list[str]
    tags: list[str]

    @property
    def kind(self) -> str:
        return "paper"

    @property
    def cache_key(self) -> str:
        return f"paper:{self.id}"

    @property
    def relative_dir(self) -> Path:
        return self.path.relative_to(self.root)

    @property
    def main_path(self) -> Path:
        return self.metadata_path

    @property
    def content_path(self) -> Path:
        return self.metadata_path

    @property
    def output_path(self) -> Path:
        return self.root / "paper" / self.output_file

    @property
    def bibliography_path(self) -> Path:
        return self.path / self.bibliography_file


def load_paper(main_path: Path, root: Path) -> Paper:
    data = read_paper_metadata(main_path)
    settings = load_project_settings(root)
    title = str(data.get("title") or main_path.stem.replace("_", " "))
    slug = str(data.get("slug") or title.casefold().replace(" ", "-"))
    output = str(data.get("output") or f"{main_path.stem}.pdf")
    bibliography = str(data.get("bibliography") or "referencias.bib")
    return Paper(
        root=root,
        path=main_path.parent,
        metadata_path=main_path,
        id=str(data.get("id") or main_path.stem),
        slug=slug,
        title=title,
        style=str(data.get("style") or "elsevier").casefold(),
        authors=_list(data.get("authors"), [settings.default_author]),
        main_file=main_path.name,
        output_file=output,
        bibliography_file=bibliography,
        bibliography_enabled=bool(data.get("bibliography_enabled", False)),
        abstract=str(data.get("abstract") or ""),
        keywords=_list(data.get("keywords")),
        tags=_list(data.get("tags")),
    )


def paper_output_readme(papers: list[Paper]) -> str:
    lines = [
        "# Papers compilados",
        "",
        "Esta carpeta contiene exclusivamente los PDFs generados desde `cuadernos/paper/`.",
        "",
    ]
    if not papers:
        lines += ["Todavía no hay papers registrados.", ""]
        return "\n".join(lines)
    lines += ["| Paper | Estilo | PDF | Fuente |", "|---|---|---|---|"]
    for paper in papers:
        pdf = f"[{paper.output_file}]({paper.output_file})" if paper.output_path.exists() else "pendiente"
        source = f"[fuente](../{paper.relative_dir.as_posix()}/{paper.main_file})"
        lines.append(f"| {paper.title} | `{paper.style}` | {pdf} | {source} |")
    lines.append("")
    return "\n".join(lines)


def sync_paper_output(papers: list[Paper], root: Path) -> None:
    output_dir = root / "paper"
    output_dir.mkdir(exist_ok=True)
    (output_dir / "README.md").write_text(paper_output_readme(papers), encoding="utf-8")

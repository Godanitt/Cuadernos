from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any

from .metadata import read_metadata
from .settings import load_project_settings

STATUS_LABELS = {
    "planned": "Planificado",
    "skeleton": "Esqueleto",
    "development": "En desarrollo",
    "usable": "Utilizable",
    "stable": "Estable",
    "paused": "Pausado",
}

STATUS_ICONS = {
    "planned": "⚪",
    "skeleton": "🟤",
    "development": "🟡",
    "usable": "🔵",
    "stable": "🟢",
    "paused": "⏸️",
}


@dataclass(slots=True)
class Progress:
    mode: str = "auto"
    text: int = 0
    figures: int = 0
    exercises: int = 0
    bibliography: int = 0
    review: int = 0
    target_words_per_chapter: int = 1500
    target_figures_per_chapter: float = 1.0
    target_exercises_per_chapter: float = 2.0
    target_references_per_part: float = 4.0

    @property
    def overall(self) -> int:
        value = (
            0.45 * self.text
            + 0.15 * self.figures
            + 0.15 * self.exercises
            + 0.10 * self.bibliography
            + 0.15 * self.review
        )
        return max(0, min(100, round(value)))


@dataclass(slots=True)
class Notebook:
    root: Path
    path: Path
    metadata_path: Path
    id: str
    slug: str
    title: str
    subtitle: str
    area: str
    status: str
    language: str
    authors: list[str]
    main_file: str
    output_file: str
    bibliography_file: str
    bibliography_enabled: bool
    summary: str
    scope: str
    out_of_scope: str
    tags: list[str]
    progress: Progress
    cover: dict[str, Any]
    typst: dict[str, Any]

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
        return self.root / "pdf" / self.output_file

    @property
    def bibliography_path(self) -> Path:
        return self.path / self.bibliography_file

    @property
    def preview_path(self) -> Path:
        return self.root / "docs" / "assets" / "previews" / f"{self.id}.png"

    @property
    def area_settings(self):
        return load_project_settings(self.root).area(self.area)

    @property
    def area_label(self) -> str:
        return self.area_settings.label

    @property
    def area_order(self) -> int:
        return self.area_settings.order

    @property
    def status_label(self) -> str:
        return STATUS_LABELS.get(self.status, self.status)

    @property
    def status_icon(self) -> str:
        return STATUS_ICONS.get(self.status, "•")


def _list(value: Any, default: list[str] | None = None) -> list[str]:
    if value is None:
        return list(default or [])
    if isinstance(value, (list, tuple)):
        return [str(item) for item in value]
    return [str(value)]


def load_notebook(main_path: Path, root: Path) -> Notebook:
    data = read_metadata(main_path)
    settings = load_project_settings(root)
    progress_data = data.get("progress", {}) or {}
    progress = Progress(
        mode=str(progress_data.get("mode", "auto")),
        text=int(progress_data.get("text", 0)),
        figures=int(progress_data.get("figures", 0)),
        exercises=int(progress_data.get("exercises", 0)),
        bibliography=int(progress_data.get("bibliography", 0)),
        review=int(progress_data.get("review", 0)),
        target_words_per_chapter=int(progress_data.get("target_words_per_chapter", 1500)),
        target_figures_per_chapter=float(progress_data.get("target_figures_per_chapter", 1.0)),
        target_exercises_per_chapter=float(progress_data.get("target_exercises_per_chapter", 2.0)),
        target_references_per_part=float(progress_data.get("target_references_per_part", 4.0)),
    )

    area = str(data.get("area") or main_path.parent.parent.name)
    title = str(data.get("title") or main_path.parent.name.replace("_", " "))
    slug = str(data.get("slug") or title.casefold().replace(" ", "-"))
    output = str(data.get("output") or f"{main_path.stem}.pdf")
    bibliography = str(data.get("bibliography") or "referencias.bib")
    return Notebook(
        root=root,
        path=main_path.parent,
        metadata_path=main_path,
        id=str(data.get("id", "")),
        slug=slug,
        title=title,
        subtitle=str(data.get("subtitle", "")),
        area=area,
        status=str(data.get("status", "planned")),
        language=str(data.get("language", "es")),
        authors=_list(data.get("authors"), [settings.default_author]),
        main_file=main_path.name,
        output_file=output,
        bibliography_file=bibliography,
        bibliography_enabled=bool(data.get("bibliography_enabled", False)),
        summary=str(data.get("summary", "")),
        scope=str(data.get("scope", "")),
        out_of_scope=str(data.get("out_of_scope", "")),
        tags=_list(data.get("tags")),
        progress=progress,
        cover=dict(data.get("cover", {}) or {}),
        typst=dict(data.get("style", {}) or {}),
    )

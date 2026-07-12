from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any
import tomllib

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
class Part:
    title: str
    slug: str
    status: str = "outline"
    references: list[str] = field(default_factory=list)
    summary: str = ""


@dataclass(slots=True)
class Notebook:
    root: Path
    path: Path
    manifest_path: Path
    id: str
    slug: str
    title: str
    subtitle: str
    area: str
    status: str
    language: str
    authors: list[str]
    main_file: str
    content_file: str
    output_file: str
    bibliography_file: str
    summary: str
    scope: str
    out_of_scope: str
    tags: list[str]
    progress: Progress
    cover: dict[str, Any]
    typst: dict[str, Any]
    parts: list[Part]

    @property
    def relative_dir(self) -> Path:
        return self.path.relative_to(self.root)

    @property
    def main_path(self) -> Path | None:
        return self.path / self.main_file if self.main_file else None

    @property
    def content_path(self) -> Path | None:
        return self.path / self.content_file if self.content_file else None

    @property
    def output_path(self) -> Path | None:
        return self.root / "pdf" / self.output_file if self.output_file else None

    @property
    def bibliography_path(self) -> Path | None:
        return self.path / self.bibliography_file if self.bibliography_file else None

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
    def area_series(self) -> str:
        return self.area_settings.series

    @property
    def area_prefix(self) -> str:
        return self.area_settings.prefix

    @property
    def status_label(self) -> str:
        return STATUS_LABELS.get(self.status, self.status)

    @property
    def status_icon(self) -> str:
        return STATUS_ICONS.get(self.status, "•")


def load_notebook(manifest_path: Path, root: Path) -> Notebook:
    with manifest_path.open("rb") as fh:
        data = tomllib.load(fh)

    p = data.get("progress", {})
    progress = Progress(
        mode=str(p.get("mode", "auto")),
        text=int(p.get("text", 0)),
        figures=int(p.get("figures", 0)),
        exercises=int(p.get("exercises", 0)),
        bibliography=int(p.get("bibliography", 0)),
        review=int(p.get("review", 0)),
        target_words_per_chapter=int(p.get("target_words_per_chapter", 1500)),
        target_figures_per_chapter=float(p.get("target_figures_per_chapter", 1.0)),
        target_exercises_per_chapter=float(p.get("target_exercises_per_chapter", 2.0)),
        target_references_per_part=float(p.get("target_references_per_part", 4.0)),
    )
    parts = [
        Part(
            title=str(item["title"]),
            slug=str(item["slug"]),
            status=str(item.get("status", "outline")),
            references=[str(x) for x in item.get("references", [])],
            summary=str(item.get("summary", "")),
        )
        for item in data.get("parts", [])
    ]
    settings = load_project_settings(root)
    area = str(data["area"])
    return Notebook(
        root=root,
        path=manifest_path.parent,
        manifest_path=manifest_path,
        id=str(data["id"]),
        slug=str(data["slug"]),
        title=str(data["title"]),
        subtitle=str(data.get("subtitle", "")),
        area=area,
        status=str(data.get("status", "planned")),
        language=str(data.get("language", "es")),
        authors=[str(x) for x in data.get("authors", [settings.default_author])],
        main_file=str(data.get("main_file", "")),
        content_file=str(data.get("content_file", "content.typ")),
        output_file=str(data.get("output_file", "")),
        bibliography_file=str(data.get("bibliography_file", "Bibliografia/referencias.bib")),
        summary=str(data.get("summary", "")),
        scope=str(data.get("scope", "")),
        out_of_scope=str(data.get("out_of_scope", "")),
        tags=[str(x) for x in data.get("tags", [])],
        progress=progress,
        cover=dict(data.get("cover", {})),
        typst=dict(data.get("typst", {})),
        parts=parts,
    )

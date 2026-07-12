from __future__ import annotations

from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path
import re
import tomllib
import unicodedata


DEFAULT_AREAS: dict[str, dict[str, object]] = {
    "Fisica": {"label": "Física", "order": 10, "prefix": "F", "series": "Series Ciencias Físicas"},
    "Matematicas": {"label": "Matemáticas", "order": 20, "prefix": "M", "series": "Series Matemáticas"},
    "Ingenieria": {"label": "Ingeniería", "order": 30, "prefix": "I", "series": "Series Ingenierías"},
    "Quimica": {"label": "Química", "order": 40, "prefix": "Q", "series": "Series Ciencias Químicas"},
    "Medicina": {"label": "Medicina y ciencias de la salud", "order": 50, "prefix": "MED", "series": "Series Medicina"},
    "Economia": {"label": "Economía", "order": 60, "prefix": "E", "series": "Series Economía"},
    "Filosofia": {"label": "Filosofía", "order": 70, "prefix": "FIL", "series": "Series Filosofía"},
    "Sociales": {"label": "Ciencias sociales", "order": 80, "prefix": "SOC", "series": "Series Ciencias Sociales"},
    "Historia": {"label": "Historia", "order": 90, "prefix": "H", "series": "Series Historia"},
    "Literatura": {"label": "Literatura", "order": 100, "prefix": "L", "series": "Series Literatura"},
    "Programacion": {"label": "Programación", "order": 110, "prefix": "PR", "series": "Series Computación"},
    "Politica": {"label": "Ensayos políticos", "order": 120, "prefix": "P", "series": "Series Ensayos Políticos"},
}


@dataclass(frozen=True, slots=True)
class AreaSettings:
    key: str
    label: str
    order: int
    prefix: str
    series: str


@dataclass(frozen=True, slots=True)
class ProjectSettings:
    title: str
    description: str
    default_author: str
    github_url: str
    areas: dict[str, AreaSettings]

    def area(self, key: str) -> AreaSettings:
        if key in self.areas:
            return self.areas[key]
        label = key.replace("_", " ").strip() or "Otros"
        prefix = _default_prefix(key)
        return AreaSettings(key=key, label=label, order=999, prefix=prefix, series=f"Series {label}")


def _default_prefix(value: str) -> str:
    normalized = unicodedata.normalize("NFKD", value).encode("ascii", "ignore").decode("ascii")
    letters = re.sub(r"[^A-Za-z]", "", normalized).upper()
    return (letters[:3] or "CUA")


def _default_settings() -> ProjectSettings:
    areas = {
        key: AreaSettings(
            key=key,
            label=str(value["label"]),
            order=int(value["order"]),
            prefix=str(value["prefix"]),
            series=str(value["series"]),
        )
        for key, value in DEFAULT_AREAS.items()
    }
    return ProjectSettings(
        title="Cuadernos",
        description="Biblioteca abierta de cuadernos extensos desarrollados en Typst.",
        default_author="Daniel Vázquez Lago",
        github_url="https://github.com/Godanitt/Cuadernos",
        areas=areas,
    )


@lru_cache(maxsize=8)
def load_project_settings(root: Path) -> ProjectSettings:
    root = root.resolve()
    defaults = _default_settings()
    path = root / "cuadernos.toml"
    if not path.exists():
        return defaults
    with path.open("rb") as fh:
        data = tomllib.load(fh)

    project = data.get("project", {})
    raw_areas = data.get("areas", {})
    areas = dict(defaults.areas)
    for key, raw in raw_areas.items():
        fallback = defaults.area(key)
        areas[key] = AreaSettings(
            key=key,
            label=str(raw.get("label", fallback.label)),
            order=int(raw.get("order", fallback.order)),
            prefix=str(raw.get("prefix", fallback.prefix)),
            series=str(raw.get("series", fallback.series)),
        )
    return ProjectSettings(
        title=str(project.get("title", defaults.title)),
        description=str(project.get("description", defaults.description)),
        default_author=str(project.get("default_author", defaults.default_author)),
        github_url=str(project.get("github_url", defaults.github_url)),
        areas=areas,
    )

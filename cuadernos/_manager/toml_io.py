from __future__ import annotations

from pathlib import Path
from typing import Any
import json

from .models import Notebook, Part


def q(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)


def scalar(value: Any) -> str:
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        return str(value)
    return q(str(value))


def array(values: list[Any]) -> str:
    return "[" + ", ".join(scalar(value) for value in values) + "]"


def write_manifest(notebook: Notebook, parts: list[Part] | None = None) -> None:
    parts = notebook.parts if parts is None else parts
    lines = [
        "schema = 1",
        f"id = {q(notebook.id)}",
        f"slug = {q(notebook.slug)}",
        f"title = {q(notebook.title)}",
        f"subtitle = {q(notebook.subtitle)}",
        f"area = {q(notebook.area)}",
        f"status = {q(notebook.status)}",
        f"language = {q(notebook.language)}",
        f"authors = {array(notebook.authors)}",
        f"main_file = {q(notebook.main_file)}",
        f"content_file = {q(notebook.content_file)}",
        f"output_file = {q(notebook.output_file)}",
        f"bibliography_file = {q(notebook.bibliography_file)}",
        f"summary = {q(notebook.summary)}",
        f"scope = {q(notebook.scope)}",
        f"out_of_scope = {q(notebook.out_of_scope)}",
        f"tags = {array(notebook.tags)}",
        "",
        "[progress]",
        f"mode = {q(notebook.progress.mode)}",
        f"text = {notebook.progress.text}",
        f"figures = {notebook.progress.figures}",
        f"exercises = {notebook.progress.exercises}",
        f"bibliography = {notebook.progress.bibliography}",
        f"review = {notebook.progress.review}",
        f"target_words_per_chapter = {notebook.progress.target_words_per_chapter}",
        f"target_figures_per_chapter = {notebook.progress.target_figures_per_chapter}",
        f"target_exercises_per_chapter = {notebook.progress.target_exercises_per_chapter}",
        f"target_references_per_part = {notebook.progress.target_references_per_part}",
        "",
        "[cover]",
    ]
    for key in ("style", "image", "theme", "zoom", "dx_cm", "dy_cm", "text_color"):
        if key in notebook.cover:
            lines.append(f"{key} = {scalar(notebook.cover[key])}")
    lines += ["", "[typst]"]
    for key in (
        "series",
        "date",
        "font_size_pt",
        "main_color",
        "secondary_color",
        "tertiary_color",
        "typography",
        "math_typography",
        "part_style",
        "github_url",
        "lowercase_references",
        "heading_style_compact",
        "first_line_indent",
    ):
        if key in notebook.typst:
            lines.append(f"{key} = {scalar(notebook.typst[key])}")
    for part in parts:
        lines += [
            "",
            "[[parts]]",
            f"title = {q(part.title)}",
            f"slug = {q(part.slug)}",
            f"status = {q(part.status)}",
            f"summary = {q(part.summary)}",
            f"references = {array(part.references)}",
        ]
    notebook.manifest_path.write_text("\n".join(lines) + "\n", encoding="utf-8")

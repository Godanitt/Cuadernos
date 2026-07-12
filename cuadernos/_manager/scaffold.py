from __future__ import annotations

from pathlib import Path
import re

from .models import Notebook, Part, Progress
from .parser import slugify
from .settings import load_project_settings
from .toml_io import write_manifest
from .generate import write_generated_typst


def next_notebook_id(root: Path, area: str) -> str:
    from .project import discover_notebooks

    prefix = load_project_settings(root).area(area).prefix
    pattern = re.compile(rf"^{re.escape(prefix)}-(\d+)$", re.IGNORECASE)
    numbers = []
    for notebook in discover_notebooks(root):
        match = pattern.match(notebook.id)
        if match:
            numbers.append(int(match.group(1)))
    return f"{prefix}-{max(numbers, default=0) + 1:02d}"


def create_notebook(
    root: Path,
    *,
    area: str,
    title: str,
    notebook_id: str | None = None,
    slug: str | None = None,
    style: str = "fullimage",
    author: str | None = None,
    parts: list[str] | None = None,
) -> Notebook:
    settings = load_project_settings(root)
    area_settings = settings.area(area)
    slug = slugify(slug or title)
    notebook_id = notebook_id or next_notebook_id(root, area)
    author = author or settings.default_author

    folder_name = "_".join(word.capitalize() for word in slug.split("-"))
    path = root / "cuadernos" / area / folder_name
    if path.exists() and any(path.iterdir()):
        raise FileExistsError(f"La carpeta ya existe y no está vacía: {path}")
    path.mkdir(parents=True, exist_ok=True)
    for dirname in ("Partes", "Capitulos", "Ejercicios", "Soluciones", "Imagenes", "Bibliografia", "generated"):
        (path / dirname).mkdir(exist_ok=True)

    main_file = "main.typ"
    content_file = "content.typ"
    output_file = f"{notebook_id}-{slug}.pdf"
    part_items = [
        Part(title=name, slug=slugify(name), status="outline")
        for name in (parts or ["Fundamentos"])
    ]
    notebook = Notebook(
        root=root,
        path=path,
        manifest_path=path / "cuaderno.toml",
        id=notebook_id,
        slug=slug,
        title=title,
        subtitle="",
        area=area,
        status="skeleton",
        language="es",
        authors=[author],
        main_file=main_file,
        content_file=content_file,
        output_file=output_file,
        bibliography_file="Bibliografia/referencias.bib",
        summary="",
        scope="",
        out_of_scope="",
        tags=[slug],
        progress=Progress(mode="auto"),
        cover={
            "style": style,
            "image": "",
            "theme": "dark",
            "zoom": 1.0,
            "dx_cm": 0.0,
            "dy_cm": 0.0,
            "text_color": "auto",
        },
        typst={
            "series": area_settings.series,
            "date": "today",
            "font_size_pt": 11,
            "main_color": "#0d2871",
            "secondary_color": "#3c4f82",
            "tertiary_color": "#60709b",
            "part_style": 0,
            "github_url": settings.github_url,
            "lowercase_references": False,
            "heading_style_compact": True,
            "first_line_indent": False,
        },
        parts=part_items,
    )
    write_manifest(notebook)
    write_generated_typst(notebook)
    (path / main_file).write_text(
        '#import "../../../plantilla/plantilla.typ": *\n'
        '#import "generated/config.typ": notebook-config, bibliography-file, bibliography-enabled\n\n'
        '#show: book.with(..notebook-config)\n\n'
        '#include "content.typ"\n\n'
        '#if bibliography-enabled {\n'
        '  my-bibliography(\n'
        '    bibliography(bibliography-file, title: "Bibliografía", full: true)\n'
        '  )\n'
        '}\n',
        encoding="utf-8",
    )
    content_lines = [
        '#import "generated/part_references.typ": part-reading-list',
        "",
        "#set par(justify: true, leading: 0.65em, spacing: 1.5em)",
        "",
    ]
    for part in part_items:
        content_lines += [
            f'#part("{part.title}")',
            "",
            '#chapter("Introducción")',
            "",
            "Esquema inicial de la parte.",
            "",
            f'#part-reading-list("{part.slug}")',
            "",
        ]
    (path / content_file).write_text("\n".join(content_lines), encoding="utf-8")
    (path / "Bibliografia" / "referencias.bib").write_text(
        "% Bibliografía general del cuaderno. Se imprime completa al final del PDF.\n"
        "% Asigna claves concretas a cada parte mediante references = [...] en cuaderno.toml.\n",
        encoding="utf-8",
    )
    return notebook

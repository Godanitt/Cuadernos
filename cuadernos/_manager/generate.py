from __future__ import annotations

from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
import os
from pathlib import Path
from typing import Iterable
import html
import json
import re
import shutil
import subprocess

from .models import Notebook, Progress
from .assets import ensure_cover_asset
from .parser import ParsedPart, bibliography_entries, bibtex_records, parse_source, pdf_page_count, slugify
from .validate import Issue, validate, validation_markdown

_METRICS_CACHE: dict[tuple[object, ...], dict[str, object]] = {}


def typst_string(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)


def typst_project_path(root: Path, path: Path) -> str:
    """Ruta absoluta de proyecto Typst (empieza por `/`)."""

    root = root.resolve()
    resolved = path.resolve()
    relative = resolved.relative_to(root)
    return "/" + relative.as_posix()


def typst_color(value: str, fallback: str) -> str:
    value = value.strip() or fallback
    if value.startswith("#"):
        return f'rgb("{value}")'
    if value.startswith("rgb(") or value in {"black", "white", "gray", "blue", "red", "green"}:
        return value
    return f'rgb("{fallback}")'


def typst_length_cm(value: object, default: float = 0.0) -> str:
    try:
        number = float(value)
    except (TypeError, ValueError):
        number = default
    return f"{number:g}cm"


def generate_config(notebook: Notebook, *, recover_covers: bool = False) -> str:
    t = notebook.typst
    c = notebook.cover
    authors = ", ".join(typst_string(author) for author in notebook.authors)
    if len(notebook.authors) == 1:
        authors += ","
    date_mode = str(t.get("date", "today"))
    date_expr = "datetime.today" if date_mode == "today" else typst_string(date_mode)
    cover_text = str(c.get("text_color", "auto"))
    if cover_text == "auto":
        cover_text_expr = typst_string("auto")
    elif cover_text.startswith("#"):
        cover_text_expr = typst_color(cover_text, "#ffffff")
    else:
        cover_text_expr = cover_text
    optional: list[str] = []
    if t.get("typography"):
        optional.append(f'  typography: {typst_string(str(t["typography"]))},')
    if t.get("math_typography"):
        optional.append(f'  math-typography: {typst_string(str(t["math_typography"]))},')
    bibliography_enabled = bool(bibtex_records(notebook.bibliography_path))
    resolved_cover = ensure_cover_asset(notebook, recover_from_pdf=recover_covers)
    lines = [
        "// Archivo generado automáticamente desde ../cuaderno.toml.",
        "// No editar a mano: ejecuta `python -m cuadernos update`.",
        "",
        "#let notebook-config = (",
        f"  title: {typst_string(notebook.title)},",
        f"  subtitle: {typst_string(notebook.subtitle)},",
        f"  series: {typst_string(str(t.get('series', notebook.area_series)))},",
        f"  volume: {typst_string(notebook.id)},",
        f"  date: {date_expr},",
        f"  author: ({authors}),",
        *optional,
        f"  main-color: {typst_color(str(t.get('main_color', '#0d2871')), '#0d2871')},",
        f"  seccond-color: {typst_color(str(t.get('secondary_color', '#3c4f82')), '#3c4f82')},",
        f"  third-color: {typst_color(str(t.get('tertiary_color', '#60709b')), '#60709b')},",
        f"  lang: {typst_string(notebook.language)},",
        f"  cover: {typst_string(resolved_cover)}," if resolved_cover else "  cover: none,",
        f"  format: {typst_string(str(c.get('style', 'solid')))},",
        f"  cover-theme: {typst_string(str(c.get('theme', 'dark')))},",
        f"  cover-zoom: {float(c.get('zoom', 1.0)):g},",
        f"  cover-dx: {typst_length_cm(c.get('dx_cm', 0.0))},",
        f"  cover-dy: {typst_length_cm(c.get('dy_cm', 0.0))},",
        f"  cover-text-color: {cover_text_expr},",
        "  image-index: none,",
        '  list-of-figure-title: "Lista de figuras",',
        '  list-of-table-title: "Lista de tablas",',
        '  supplement-chapter: "Capítulo",',
        '  supplement-part: "Parte",',
        f"  font-size: {int(t.get('font_size_pt', 11))}pt,",
        f"  part-style: {int(t.get('part_style', 0))},",
        f"  github-url: {typst_string(str(t.get('github_url', 'https://github.com/Godanitt/Cuadernos')))},",
        "  copyright: [],",
        f"  lowercase-references: {str(bool(t.get('lowercase_references', False))).lower()},",
        f"  heading-style-compact: {str(bool(t.get('heading_style_compact', True))).lower()},",
        f"  first-line-indent: {str(bool(t.get('first_line_indent', False))).lower()},",
        ")",
        "",
        f"#let bibliography-file = {typst_string(typst_project_path(notebook.root, notebook.bibliography_path))}",
        f"#let bibliography-enabled = {str(bibliography_enabled).lower()}",
        "",
    ]
    return "\n".join(lines)

def _escape_typst_text(value: str) -> str:
    return value.replace("\\", "\\\\").replace('"', '\\"').replace("#", "\\#")


def generate_part_references(notebook: Notebook) -> str:
    records = {record.key: record for record in bibtex_records(notebook.bibliography_path)}
    lines = [
        "// Generado desde cuaderno.toml y Bibliografia/referencias.bib.",
        "#let part-references = (",
    ]
    for part in notebook.parts:
        rendered_items: list[str] = []
        for key in part.references:
            record = records.get(key)
            label = record.label if record else f"Referencia no definida: {key}"
            fields = record.fields if record else {}
            rendered_items.append(
                "("
                f"key: {typst_string(key)}, "
                f"label: {typst_string(label)}, "
                f"doi: {typst_string(str(fields.get('doi', '')))}, "
                f"url: {typst_string(str(fields.get('url', '')))}"
                ")"
            )
        rendered = ", ".join(rendered_items)
        if len(rendered_items) == 1:
            rendered += ","
        lines.append(f'  {typst_string(part.slug)}: ({rendered}),')
    lines += [")", ""]
    return "\n".join(lines)

def write_generated_typst(notebook: Notebook, *, recover_covers: bool = False) -> None:
    if not notebook.main_file:
        return
    generated = notebook.path / "generated"
    generated.mkdir(parents=True, exist_ok=True)
    (generated / "config.typ").write_text(generate_config(notebook, recover_covers=recover_covers), encoding="utf-8")
    (generated / "part_references.typ").write_text(generate_part_references(notebook), encoding="utf-8")


def _preview_candidates(notebook: Notebook) -> tuple[Path, Path]:
    base = notebook.root / "docs" / "assets" / "previews" / notebook.id
    return base.with_suffix(".png"), base.with_suffix(".svg")


def _write_placeholder_svg(notebook: Notebook, target: Path) -> None:
    target.parent.mkdir(parents=True, exist_ok=True)
    title = html.escape(notebook.title)
    area = html.escape(notebook.area_label)
    code = html.escape(notebook.id)
    target.write_text(
        f'''<svg xmlns="http://www.w3.org/2000/svg" width="420" height="594" viewBox="0 0 420 594">
<defs><linearGradient id="g" x1="0" y1="0" x2="1" y2="1"><stop stop-color="#10172f"/><stop offset="1" stop-color="#40558d"/></linearGradient></defs>
<rect width="420" height="594" fill="url(#g)"/>
<rect x="28" y="28" width="364" height="538" rx="6" fill="none" stroke="#ffffff" stroke-opacity=".34"/>
<text x="42" y="78" fill="#dce5ff" font-family="serif" font-size="18">{area}</text>
<text x="378" y="78" fill="#dce5ff" font-family="sans-serif" font-size="16" text-anchor="end">{code}</text>
<foreignObject x="42" y="180" width="336" height="250"><div xmlns="http://www.w3.org/1999/xhtml" style="font:700 34px/1.12 Georgia,serif;color:white">{title}</div></foreignObject>
<text x="42" y="525" fill="#dce5ff" font-family="sans-serif" font-size="15">Proyecto Cuadernos</text>
</svg>''',
        encoding="utf-8",
    )


def generate_preview(notebook: Notebook, force: bool = False) -> Path:
    png, svg = _preview_candidates(notebook)
    if not force and png.exists() and notebook.output_path and notebook.output_path.exists():
        if png.stat().st_mtime >= notebook.output_path.stat().st_mtime:
            return png
    if notebook.output_path and notebook.output_path.exists() and shutil.which("pdftoppm"):
        png.parent.mkdir(parents=True, exist_ok=True)
        prefix = png.with_suffix("")
        try:
            proc = subprocess.run(
                [
                    "pdftoppm",
                    "-f",
                    "1",
                    "-l",
                    "1",
                    "-singlefile",
                    "-png",
                    "-scale-to-x",
                    "420",
                    "-scale-to-y",
                    "-1",
                    str(notebook.output_path),
                    str(prefix),
                ],
                capture_output=True,
                text=True,
                timeout=15,
            )
        except subprocess.TimeoutExpired:
            proc = None
        if proc is not None and proc.returncode == 0 and png.exists():
            svg.unlink(missing_ok=True)
            return png
    _write_placeholder_svg(notebook, svg)
    return svg


def progress_bar(value: int, cells: int = 10) -> str:
    filled = round(value / 100 * cells)
    return "█" * filled + "░" * (cells - filled)


def _bounded_percentage(value: float) -> int:
    return max(0, min(100, round(value)))


def effective_progress(notebook: Notebook, stats, bibliography_count: int) -> Progress:
    if notebook.progress.mode == "manual":
        return notebook.progress

    units = max(stats.chapters, len(stats.parts), len(notebook.parts), 1)
    part_count = max(len(stats.parts), len(notebook.parts), 1)
    p = notebook.progress
    text = _bounded_percentage(100 * stats.words / max(1, units * p.target_words_per_chapter))
    figures = _bounded_percentage(100 * stats.figures / max(1.0, units * p.target_figures_per_chapter))
    exercises = _bounded_percentage(100 * stats.exercises / max(1.0, units * p.target_exercises_per_chapter))
    bibliography = _bounded_percentage(
        100 * bibliography_count / max(1.0, part_count * p.target_references_per_part)
    )
    review = {
        "planned": 0,
        "skeleton": 5,
        "development": 30,
        "usable": 70,
        "stable": 100,
        "paused": 20,
    }.get(notebook.status, 0)
    return Progress(
        mode="auto",
        text=text,
        figures=figures,
        exercises=exercises,
        bibliography=bibliography,
        review=review,
        target_words_per_chapter=p.target_words_per_chapter,
        target_figures_per_chapter=p.target_figures_per_chapter,
        target_exercises_per_chapter=p.target_exercises_per_chapter,
        target_references_per_part=p.target_references_per_part,
    )


def notebook_metrics(notebook: Notebook) -> dict[str, object]:
    source_files = [notebook.manifest_path]
    if notebook.path.exists():
        source_files.extend(
            path for path in notebook.path.rglob("*")
            if path.is_file() and path.suffix.lower() in {".typ", ".toml", ".bib"}
            and "generated" not in path.parts
        )
    newest_source = max((path.stat().st_mtime for path in source_files), default=0.0)
    source_size = sum((path.stat().st_size for path in source_files), 0)
    output_mtime = notebook.output_path.stat().st_mtime if notebook.output_path and notebook.output_path.exists() else 0.0
    key = (notebook.id, newest_source, source_size, output_mtime)
    cached = _METRICS_CACHE.get(key)
    if cached is not None:
        return cached

    stats = parse_source(notebook.content_path)
    parts = stats.parts or [ParsedPart(title=part.title, chapters=[]) for part in notebook.parts]
    pages = pdf_page_count(notebook.output_path)
    compiled = bool(notebook.output_path and notebook.output_path.exists())
    stale = bool(notebook.main_file and compiled and notebook.output_path and newest_source > output_mtime)
    bibliography_count = len(bibtex_records(notebook.bibliography_path))
    progress = effective_progress(notebook, stats, bibliography_count)
    result = {
        "parts": parts,
        "chapters": stats.chapters,
        "words": stats.words,
        "figures": stats.figures,
        "exercises": stats.exercises,
        "references": bibliography_count,
        "pages": pages,
        "compiled": compiled,
        "stale": stale,
        "progress": progress.overall,
        "progress_mode": progress.mode,
        "progress_details": progress,
    }
    _METRICS_CACHE[key] = result
    return result

def preview_relative(notebook: Notebook, from_dir: Path) -> str:
    png, svg = _preview_candidates(notebook)
    path = png if png.exists() else svg
    return Path(shutil.os.path.relpath(path, from_dir)).as_posix()


def _parts_html(metrics: dict[str, object]) -> str:
    parts = metrics["parts"]
    if not parts:
        return "—"
    chunks = []
    for part in parts:
        count = len(part.chapters)
        chunks.append(f"<strong>{html.escape(part.title)}</strong> <sub>({count} cap.)</sub>")
    return "<br>".join(chunks)


def _pdf_link(notebook: Notebook, from_dir: Path, stale: bool = False) -> str:
    if notebook.output_path and notebook.output_path.exists():
        rel = Path(shutil.os.path.relpath(notebook.output_path, from_dir)).as_posix()
        label = "PDF desactualizado" if stale else "PDF"
        return f"[{label}]({rel})"
    return "PDF pendiente"


def count_label(value: int, singular: str, plural: str | None = None) -> str:
    return f"{value} {singular if value == 1 else (plural or singular + 's')}"


def _source_link(notebook: Notebook, from_dir: Path) -> str:
    rel = Path(shutil.os.path.relpath(notebook.path, from_dir)).as_posix()
    return f"[Fuente]({rel}/)"


def root_readme(notebooks: list[Notebook]) -> str:
    root = notebooks[0].root
    metrics = {n.id: notebook_metrics(n) for n in notebooks}
    total_pages = sum(int(m["pages"]) for m in metrics.values())
    total_chapters = sum(int(m["chapters"]) for m in metrics.values())
    compiled = sum(bool(m["compiled"]) for m in metrics.values())
    current_pdfs = sum(bool(m["compiled"]) and not bool(m["stale"]) for m in metrics.values())
    active = sum(n.status not in {"planned", "paused"} for n in notebooks)
    overall = round(sum(int(metrics[n.id]["progress"]) for n in notebooks) / max(1, len(notebooks)))

    lines = [
        "# Cuadernos",
        "",
        "> Biblioteca abierta de cuadernos extensos de ciencias, ingeniería, humanidades y ciencias sociales, desarrollados en Typst y organizados como volúmenes conectados.",
        "",
        "[![Typst](https://img.shields.io/badge/Typst-documentos-239DAD)](https://typst.app/)",
        "![Catálogo](https://img.shields.io/badge/cuadernos-%d-40558d)" % len(notebooks),
        "![PDF](https://img.shields.io/badge/PDF_compilados-%d-2f855a)" % compiled,
        "![PDF actualizados](https://img.shields.io/badge/PDF_actualizados-%d-2463a8)" % current_pdfs,
        "![Estado](https://img.shields.io/badge/progreso_global-%d%%25-c58a19)" % overall,
        "",
        "## Estado general",
        "",
        "| Cuadernos | Activos | PDF disponibles | PDF actualizados | Capítulos | Páginas compiladas | Progreso editorial |",
        "|---:|---:|---:|---:|---:|---:|---:|",
        f"| **{len(notebooks)}** | **{active}** | **{compiled}** | **{current_pdfs}** | **{total_chapters}** | **{total_pages}** | **{overall}%** |",
        "",
        "El porcentaje editorial se calcula automáticamente a partir del contenido Typst, figuras, ejercicios, referencias y estado de revisión. Puede cambiarse a modo manual en el `cuaderno.toml` de un volumen concreto.",
        "",
        "## Inicio rápido",
        "",
        "### Requisitos",
        "",
        "- Python 3.11 o posterior.",
        "- [Typst](https://typst.app/open-source/) disponible en `PATH`.",
        "- Poppler (`pdfinfo` y `pdftoppm`) para contabilizar páginas y generar previsualizaciones.",
        "",
        "### Un único comando",
        "",
        "```bash",
        "python -m cuadernos update",
        "```",
        "",
        "Este comando descubre todos los `cuaderno.toml`, sincroniza las partes, genera la configuración Typst, valida el proyecto, compila únicamente lo modificado, extrae automáticamente las portadas de la primera página de cada PDF y reconstruye el README y los catálogos.",
        "",
        "También puede limitarse la compilación:",
        "",
        "```bash",
        "python -m cuadernos update F-08",
        "python -m cuadernos update Medicina",
        "python -m cuadernos update --force",
        "```",
        "",
        "Para actualizar el catálogo sin compilar:",
        "",
        "```bash",
        "python -m cuadernos update --no-build",
        "```",
        "",
        "## Catálogo",
        "",
        "**Estados:** ⚪ Planificado · 🟤 Esqueleto · 🟡 En desarrollo · 🔵 Utilizable · 🟢 Estable · ⏸️ Pausado.",
        "",
    ]

    grouped: dict[str, list[Notebook]] = defaultdict(list)
    for notebook in notebooks:
        grouped[notebook.area].append(notebook)
    for area in sorted(grouped, key=lambda x: (grouped[x][0].area_order, grouped[x][0].area_label.casefold())):
        lines += [f"### {grouped[area][0].area_label}", ""]
        lines += [
            "| Portada | Cuaderno | Estado y métricas | Partes |",
            "|:---:|---|---|---|",
        ]
        for notebook in grouped[area]:
            m = metrics[notebook.id]
            preview = preview_relative(notebook, root)
            title_link = Path(shutil.os.path.relpath(notebook.path, root)).as_posix()
            links = f"{_pdf_link(notebook, root, bool(m['stale']))} · {_source_link(notebook, root)}"
            metric_text = (
                f"{notebook.status_icon} **{notebook.status_label}**<br>"
                f"`{progress_bar(int(m['progress']))}` **{m['progress']} %**<br>"
                f"{count_label(int(m['chapters']), 'capítulo')} · {count_label(int(m['pages']), 'página')}<br>{links}"
            )
            lines.append(
                "| "
                f'<img src="{preview}" width="105" alt="Portada de {html.escape(notebook.title)}">'
                " | "
                f"**[{notebook.id} · {notebook.title}]({title_link}/)**<br>"
                f"{html.escape(notebook.summary or notebook.scope or 'Cuaderno en preparación.')}"
                " | "
                f"{metric_text}"
                " | "
                f"{_parts_html(m)}"
                " |"
            )
        lines.append("")

    lines += [
        "## Arquitectura editorial",
        "",
        "Cada cuaderno separa explícitamente configuración, contenido y archivos generados:",
        "",
        "```text",
        "cuadernos/<Area>/<Cuaderno>/",
        "├── cuaderno.toml                 # fuente única de metadatos",
        "├── <principal>.typ               # entrada mínima de compilación",
        "├── content.typ                   # estructura y contenido",
        "├── Partes/                       # partes extensas opcionales",
        "├── Capitulos/                    # capítulos modulares",
        "├── Ejercicios/                   # problemas y soluciones",
        "├── Bibliografia/referencias.bib  # bibliografía común",
        "├── Imagenes/",
        "└── generated/",
        "    ├── config.typ                # configuración Typst generada",
        "    └── part_references.typ       # lecturas por parte",
        "```",
        "",
        "Las referencias recomendadas de cada parte se declaran mediante claves BibTeX en `cuaderno.toml`. En el contenido pueden mostrarse con:",
        "",
        "```typst",
        '#part-reading-list("fundamentos")',
        "```",
        "",
        "## Gestión del proyecto",
        "",
        "| Comando | Función |",
        "|---|---|",
        "| `python -m cuadernos update` | Flujo completo: descubrir, sincronizar, validar, compilar y publicar el catálogo. |",
        "| `python -m cuadernos list` | Lista automáticamente todos los manifiestos encontrados. |",
        "| `python -m cuadernos build [selector]` | Compilación incremental por hash. |",
        "| `python -m cuadernos check` | Valida IDs, rutas, portadas, partes y bibliografía. |",
        "| `python -m cuadernos update --no-build` | Regenera configuración, referencias, previews y README sin compilar. |",
        "| `python -m cuadernos new ...` | Crea un cuaderno, asigna ID y slug y lo añade al catálogo. |",
        "| `python -m cuadernos stats` | Muestra y actualiza el panel de salud. |",
        "",
        "Ejemplo de creación:",
        "",
        "```bash",
        'python -m cuadernos new --area Medicina --title "Fundamentos biomédicos de la medicina" --part "Anatomía y fisiología" --part "Patología general"',
        "```",
        "",
        "El ID (`MED-01`, `MED-02`, …), el slug, la carpeta, el manifiesto, el esqueleto Typst y la entrada del README se crean automáticamente. También puedes añadir manualmente una carpeta con `cuaderno.toml`: aparecerá tras ejecutar `python -m cuadernos update`.",
        "",
        "## Fuentes de verdad",
        "",
        "- `cuadernos.toml`: configuración global de áreas, orden, prefijos y series.",
        "- `cuaderno.toml`: título, estado, alcance, portada y bibliografía por parte.",
        "- `content.typ` y sus inclusiones: partes, capítulos y contenido efectivo.",
        "- `pdf/`: publicaciones compiladas; nunca se mezclan con las fuentes.",
        "- `docs/catalog.json`: catálogo legible por otras aplicaciones.",
        "- `bibliografia/catalogo.bib`: catálogo bibliográfico global con claves namespaced.",
        "- `docs/HEALTH.md`: informe de salud y cobertura del proyecto.",
        "",
        "## Convenciones",
        "",
        "- Los nombres de carpetas y archivos usan ASCII portable; los títulos visibles conservan sus acentos.",
        "- Los IDs son únicos y estables, aunque cambie el título del cuaderno.",
        "- Las portadas admitidas son `solid`, `fullimage`, `wiley` y `wiley2`.",
        "- Un concepto debe tener un cuaderno canónico; los demás lo resumen y enlazan para minimizar duplicaciones.",
        "",
        "## Licencia y autoría",
        "",
        "La autoría y las condiciones de uso de cada volumen se indican en su manifiesto y en el propio documento. Las imágenes y referencias externas deben conservar su atribución correspondiente.",
        "",
        "---",
        "",
        "Este README se genera automáticamente. Añade o modifica cuadernos y ejecuta `python -m cuadernos update`.",
        "",
    ]
    return "\n".join(lines)


def individual_readme(notebook: Notebook) -> str:
    root = notebook.root
    metrics = notebook_metrics(notebook)
    from_dir = notebook.path
    preview = preview_relative(notebook, from_dir)
    lines = [
        f"# {notebook.title}",
        "",
        f'<img src="{preview}" width="210" alt="Portada de {html.escape(notebook.title)}">',
        "",
        f"**Código:** `{notebook.id}` · **Estado:** {notebook.status_icon} {notebook.status_label} · **Progreso:** {metrics['progress']} %",
        "",
    ]
    if notebook.summary:
        lines += [notebook.summary, ""]
    lines += [
        "## Alcance",
        "",
        notebook.scope or "Pendiente de definir.",
        "",
        "## Fuera de alcance",
        "",
        notebook.out_of_scope or "Pendiente de definir.",
        "",
        "## Estructura",
        "",
    ]
    for index, part in enumerate(metrics["parts"], start=1):
        lines.append(f"### Parte {index}. {part.title}")
        lines.append("")
        if part.chapters:
            lines.extend(f"- {chapter}" for chapter in part.chapters)
        else:
            lines.append("- Sin capítulos activos todavía.")
        meta = next((p for p in notebook.parts if p.title == part.title), None)
        if meta and meta.references:
            lines += ["", "**Lecturas recomendadas:** " + ", ".join(f"`{key}`" for key in meta.references)]
        lines.append("")
    lines += [
        "## Estado editorial",
        "",
        "| Dimensión | Progreso |",
        "|---|---:|",
        f"| Texto | {metrics['progress_details'].text} % |",
        f"| Figuras | {metrics['progress_details'].figures} % |",
        f"| Ejercicios | {metrics['progress_details'].exercises} % |",
        f"| Bibliografía | {metrics['progress_details'].bibliography} % |",
        f"| Revisión | {metrics['progress_details'].review} % |",
        f"| **Global ponderado** | **{metrics['progress']} %** |",
        "",
        f"Capítulos activos: **{metrics['chapters']}** · Páginas compiladas: **{metrics['pages']}** · PDF: **{'desactualizado' if metrics['stale'] else 'actualizado' if metrics['compiled'] else 'pendiente'}**.",
        "",
        "## Compilación",
        "",
        "Desde la raíz del repositorio:",
        "",
        "```bash",
        f"python -m cuadernos update {notebook.id}",
        "```",
        "",
        "Para regenerar todo el proyecto sin compilar:",
        "",
        "```bash",
        "python -m cuadernos update --no-build",
        "```",
        "",
        "## Archivos principales",
        "",
        f"- Manifiesto: `cuaderno.toml`",
        f"- Entrada Typst: `{notebook.main_file or 'pendiente'}`",
        f"- Contenido: `{notebook.content_file}`",
        f"- Bibliografía: `{notebook.bibliography_file}`",
        f"- PDF: `{notebook.output_file or 'pendiente'}`",
        "",
        "> Este README se genera automáticamente a partir del manifiesto y del contenido Typst.",
        "",
    ]
    return "\n".join(lines)


def area_readme(area: str, notebooks: list[Notebook]) -> str:
    area_dir = notebooks[0].root / "cuadernos" / area
    lines = [
        f"# {notebooks[0].area_label}",
        "",
        f"Colección de {len(notebooks)} cuadernos del área de {notebooks[0].area_label.lower()}.",
        "",
        "| Código | Cuaderno | Estado | Progreso | Capítulos | PDF |",
        "|---|---|---|---:|---:|---|",
    ]
    for n in notebooks:
        m = notebook_metrics(n)
        rel = Path(shutil.os.path.relpath(n.path, area_dir)).as_posix()
        lines.append(
            f"| `{n.id}` | [{n.title}]({rel}/) | {n.status_icon} {n.status_label} | {m['progress']} % | {m['chapters']} | {_pdf_link(n, area_dir, bool(m['stale']))} |"
        )
    lines += ["", "Generado mediante `python -m cuadernos update --no-build`.", ""]
    return "\n".join(lines)



def pdf_readme(notebooks: list[Notebook]) -> str:
    lines = [
        "# PDF compilados",
        "",
        "Esta carpeta contiene exclusivamente las publicaciones generadas. Los fuentes viven en `../cuadernos/`.",
        "",
        "| Código | Cuaderno | Páginas | Estado del PDF | Archivo |",
        "|---|---|---:|---|---|",
    ]
    for notebook in notebooks:
        metrics = notebook_metrics(notebook)
        if metrics["compiled"]:
            state = "Desactualizado respecto a las fuentes" if metrics["stale"] else "Actualizado"
            lines.append(
                f"| `{notebook.id}` | {notebook.title} | {metrics['pages']} | {state} | "
                f"[`{notebook.output_file}`]({notebook.output_file}) |"
            )
    lines += [
        "",
        "Para compilar los cambios pendientes:",
        "",
        "```bash",
        "python -m cuadernos build",
        "```",
        "",
        "> Este índice se genera mediante `python -m cuadernos update --no-build`.",
        "",
    ]
    return "\n".join(lines)

def health_markdown(notebooks: list[Notebook], issues: list[Issue] | None = None) -> str:
    issues = issues if issues is not None else validate(notebooks)
    metrics = {n.id: notebook_metrics(n) for n in notebooks}
    by_status: dict[str, int] = defaultdict(int)
    by_area: dict[str, list[Notebook]] = defaultdict(list)
    for n in notebooks:
        by_status[n.status] += 1
        by_area[n.area].append(n)
    lines = [
        "# Salud del proyecto",
        "",
        "Informe generado automáticamente por `python -m cuadernos stats --write`.",
        "",
        "## Resumen",
        "",
        f"- Cuadernos registrados: **{len(notebooks)}**",
        f"- PDF compilados: **{sum(bool(m['compiled']) for m in metrics.values())}**",
        f"- PDF actualizados: **{sum(bool(m['compiled']) and not bool(m['stale']) for m in metrics.values())}**",
        f"- Páginas compiladas: **{sum(int(m['pages']) for m in metrics.values())}**",
        f"- Capítulos activos: **{sum(int(m['chapters']) for m in metrics.values())}**",
        f"- Errores de validación: **{sum(i.severity == 'error' for i in issues)}**",
        f"- Advertencias: **{sum(i.severity == 'warning' for i in issues)}**",
        "",
        "## Estado por área",
        "",
        "| Área | Cuadernos | Capítulos | Páginas | Progreso medio |",
        "|---|---:|---:|---:|---:|",
    ]
    for area in sorted(by_area, key=lambda x: (by_area[x][0].area_order, by_area[x][0].area_label.casefold())):
        group = by_area[area]
        lines.append(
            f"| {group[0].area_label} | {len(group)} | "
            f"{sum(int(metrics[n.id]['chapters']) for n in group)} | "
            f"{sum(int(metrics[n.id]['pages']) for n in group)} | "
            f"{round(sum(int(metrics[n.id]['progress']) for n in group) / len(group))} % |"
        )
    lines += ["", "## Estado editorial", ""]
    for status, count in sorted(by_status.items()):
        lines.append(f"- **{status}**: {count}")
    lines += ["", "## Validación", "", validation_markdown(notebooks, issues).replace("# Validación del proyecto\n\n", "")]
    return "\n".join(lines)



def generate_central_bibliography(notebooks: list[Notebook]) -> None:
    if not notebooks:
        return
    root = notebooks[0].root
    bibliography_dir = root / "bibliografia"
    bibliography_dir.mkdir(exist_ok=True)
    bib_lines = [
        "% Catálogo bibliográfico global generado automáticamente.",
        "% Las claves se prefijan con el ID del cuaderno para evitar colisiones.",
        "",
    ]
    json_rows: list[dict[str, object]] = []
    readme_rows: list[str] = []
    total = 0
    for notebook in notebooks:
        records = bibtex_records(notebook.bibliography_path)
        total += len(records)
        for record in records:
            safe_id = re.sub(r"[^A-Za-z0-9]+", "-", notebook.id).strip("-")
            global_key = f"{safe_id}__{record.key}"
            rewritten = re.sub(
                r"(@[A-Za-z]+\s*\{\s*)[^,\s]+",
                lambda match: match.group(1) + global_key,
                record.raw,
                count=1,
                flags=re.IGNORECASE,
            )
            bib_lines += [
                f"% Fuente: {notebook.id} — {notebook.title}",
                rewritten,
                "",
            ]
            json_rows.append(
                {
                    "global_key": global_key,
                    "local_key": record.key,
                    "notebook_id": notebook.id,
                    "notebook": notebook.title,
                    "area": notebook.area,
                    "label": record.label,
                    "fields": record.fields,
                }
            )
        source_rel = notebook.bibliography_path.relative_to(root).as_posix() if notebook.bibliography_path else ""
        readme_rows.append(
            f"| `{notebook.id}` | {notebook.title} | {len(records)} | "
            f"[`{source_rel}`](../{source_rel}) |"
        )
    (bibliography_dir / "catalogo.bib").write_text("\n".join(bib_lines), encoding="utf-8")
    (root / "docs" / "bibliography.json").write_text(
        json.dumps(json_rows, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    readme = [
        "# Catálogo bibliográfico",
        "",
        "Índice central de las bibliografías locales de todos los cuadernos.",
        "",
        f"Referencias registradas: **{total}**.",
        "",
        "## Organización",
        "",
        "- Cada cuaderno mantiene su archivo `Bibliografia/referencias.bib` para poder compilarse de forma autónoma.",
        "- `catalogo.bib` agrega todas las entradas y prefija sus claves con el ID del cuaderno.",
        "- `docs/bibliography.json` ofrece los mismos datos para buscadores o una futura web.",
        "- Las lecturas recomendadas por parte se declaran en `cuaderno.toml` mediante claves locales.",
        "",
        "## Bibliografías por cuaderno",
        "",
        "| Código | Cuaderno | Referencias | Archivo local |",
        "|---|---|---:|---|",
        *readme_rows,
        "",
        "> Archivo generado mediante `python -m cuadernos update --no-build`.",
        "",
    ]
    (bibliography_dir / "README.md").write_text("\n".join(readme), encoding="utf-8")

def write_catalog_json(notebooks: list[Notebook]) -> None:
    payload = []
    for n in notebooks:
        m = notebook_metrics(n)
        payload.append(
            {
                "id": n.id,
                "slug": n.slug,
                "title": n.title,
                "area": n.area,
                "area_label": n.area_label,
                "status": n.status,
                "progress": m["progress"],
                "chapters": m["chapters"],
                "parts": [
                    {"title": part.title, "chapters": part.chapters}
                    for part in m["parts"]
                ],
                "pages": m["pages"],
                "pdf": f"pdf/{n.output_file}" if m["compiled"] else None,
                "source": n.relative_dir.as_posix(),
            }
        )
    docs = notebooks[0].root / "docs"
    docs.mkdir(exist_ok=True)
    (docs / "catalog.json").write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def sync_project(
    notebooks: list[Notebook],
    force_previews: bool = False,
    generate_previews: bool = True,
) -> list[Issue]:
    if not notebooks:
        return []
    root = notebooks[0].root
    preview_dir = root / "docs" / "assets" / "previews"
    preview_dir.mkdir(parents=True, exist_ok=True)
    valid_ids = {notebook.id for notebook in notebooks}
    for old_preview in preview_dir.iterdir():
        if old_preview.is_file() and old_preview.suffix.lower() in {".png", ".svg"}:
            if old_preview.stem not in valid_ids:
                old_preview.unlink(missing_ok=True)

    workers = max(1, min(4, os.cpu_count() or 1, len(notebooks)))
    with ThreadPoolExecutor(max_workers=workers) as pool:
        list(pool.map(write_generated_typst, notebooks))
        if generate_previews:
            list(pool.map(lambda notebook: generate_preview(notebook, force=force_previews), notebooks))

    for notebook in notebooks:
        (notebook.path / "README.md").write_text(individual_readme(notebook), encoding="utf-8")

    grouped: dict[str, list[Notebook]] = defaultdict(list)
    for notebook in notebooks:
        grouped[notebook.area].append(notebook)
    for area, group in grouped.items():
        area_dir = root / "cuadernos" / area
        area_dir.mkdir(parents=True, exist_ok=True)
        (area_dir / "README.md").write_text(area_readme(area, group), encoding="utf-8")

    issues = validate(notebooks)
    (root / "README.md").write_text(root_readme(notebooks), encoding="utf-8")
    pdf_dir = root / "pdf"
    pdf_dir.mkdir(exist_ok=True)
    (pdf_dir / "README.md").write_text(pdf_readme(notebooks), encoding="utf-8")
    docs = root / "docs"
    docs.mkdir(exist_ok=True)
    (docs / "HEALTH.md").write_text(health_markdown(notebooks, issues), encoding="utf-8")
    (docs / "VALIDATION.md").write_text(validation_markdown(notebooks, issues), encoding="utf-8")
    generate_central_bibliography(notebooks)
    write_catalog_json(notebooks)
    return issues

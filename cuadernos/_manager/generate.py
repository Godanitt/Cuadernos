from __future__ import annotations

from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
import os
from pathlib import Path
import html
import json
import re
import shutil
import subprocess

from .models import Notebook, Progress
from .parser import bibtex_records, parse_source, pdf_page_count
from .validate import Issue, validate, validation_markdown

_METRICS_CACHE: dict[tuple[object, ...], dict[str, object]] = {}


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

    units = max(stats.chapters, len(stats.parts), 1)
    part_count = max(len(stats.parts), 1)
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
    source_files = [notebook.main_path]
    if notebook.path.exists():
        source_files.extend(
            path for path in notebook.path.rglob("*")
            if path.is_file() and path.suffix.lower() in {".typ", ".bib", ".png", ".jpg", ".jpeg", ".webp", ".svg", ".csv", ".json"}
        )
    newest_source = max((path.stat().st_mtime for path in source_files), default=0.0)
    source_size = sum((path.stat().st_size for path in source_files), 0)
    output_mtime = notebook.output_path.stat().st_mtime if notebook.output_path and notebook.output_path.exists() else 0.0
    key = (notebook.id, newest_source, source_size, output_mtime)
    cached = _METRICS_CACHE.get(key)
    if cached is not None:
        return cached

    stats = parse_source(notebook.content_path)
    parts = stats.parts
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
        "El porcentaje editorial se calcula automáticamente a partir del contenido Typst, figuras, ejercicios, referencias y estado de revisión. Puede cambiarse a modo manual dentro del bloque `notebook` del archivo principal Typst.",
        "",
        "## Inicio rápido",
        "",
        "### Requisitos",
        "",
        "- Python 3.11 o posterior.",
        "- Tinymist CLI disponible en `PATH`, en `TINYMIST_BIN` o dentro de una instalación habitual de la extensión de VS Code.",
        "- Poppler (`pdfinfo` y `pdftoppm`) para contabilizar páginas y generar previsualizaciones.",
        "",
        "### Un único comando",
        "",
        "```bash",
        "python run_all.py",
        "```",
        "",
        "Este comando descubre los archivos principales Typst, lee su bloque `notebook`, valida el proyecto, compila únicamente lo modificado con Tinymist, actualiza `tinymist.lock` y reconstruye el README y los catálogos.",
        "",
        "También puede limitarse la compilación:",
        "",
        "```bash",
        "python -m cuadernos update Fis-Electrodinamica",
        "python -m cuadernos update Medicina",
        "python -m cuadernos update --force",
        "python -m cuadernos update --rebuild-lock  # reparar o reconstruir todas las rutas",
        "```",
        "",
        "Para actualizar el catálogo sin compilar:",
        "",
        "```bash",
        "python -m cuadernos update --no-build",
        "```",
        "",
        "Para añadir un cuaderno basta con copiar una carpeta existente, renombrar su archivo principal y editar el bloque `notebook` situado al comienzo. No hay manifiestos ni comandos de alta.",
        "",
        "Mientras editas, puedes ejecutar `python -m cuadernos watch` para releer automáticamente los mains y actualizar el catálogo al guardar.",
        "",
        "La configuración `.vscode/settings.json` activa `lockDatabase`. Al abrir cualquier capítulo, Tinymist usa el documento principal registrado en `tinymist.lock`, evitando falsos avisos de etiquetas inexistentes.",
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
        "Cada cuaderno es autocontenido: el archivo principal contiene sus metadatos, la configuración de portada y el orden de lectura.",
        "",
        "```text",
        "cuadernos/<Area>/<Cuaderno>/",
        "├── <principal>.typ     # metadatos + configuración + estructura del libro",
        "├── referencias.bib     # bibliografía del cuaderno",
        "├── Capitulos/          # texto modular; los ejercicios cierran cada capítulo",
        "├── Imagenes/           # portada y figuras",
        "└── data/               # datos, tablas o material auxiliar",
        "```",
        "",
        "No existen `cuaderno.toml`, `content.typ` ni `generated/`. La portada se usa directamente desde `Imagenes/`, sin copias intermedias.",
        "",
        "## Gestión del proyecto",
        "",
        "| Comando | Función |",
        "|---|---|",
        "| `python run_all.py` | Lee los mains, valida, compila lo modificado y reconstruye README y catálogos. |",
        "| `python -m cuadernos update --no-build` | Relee los mains y regenera los metadatos públicos sin compilar. |",
        "| `python -m cuadernos update Fis-Electrodinamica` | Actualiza o compila únicamente un cuaderno. |",
        "| `python -m cuadernos watch` | Vigila los mains, capítulos, imágenes, datos y bibliografías. |",
        "| `python -m cuadernos check` | Valida IDs, rutas, portadas y bibliografía. |",
        "",
        "Para crear un cuaderno nuevo, copia una carpeta existente, renombra el main y edita el bloque `notebook` del principio. Esa es la única alta necesaria.",
        "",
        "## Fuentes de verdad",
        "",
        "- `cuadernos.toml`: áreas, orden, prefijos y series globales.",
        "- El bloque `notebook` de cada main: título, ID, estado, salida, portada, colores y bibliografía.",
        "- El propio main y `Capitulos/`: partes, capítulos y contenido efectivo.",
        "- `referencias.bib`: bibliografía local del volumen.",
        "- `pdf/`: publicaciones compiladas.",
        "- `docs/catalog.json`: catálogo derivado para otras aplicaciones.",
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
        "La autoría y las condiciones de uso de cada volumen se indican en el bloque `notebook` de su archivo principal y en el propio documento. Las imágenes y referencias externas deben conservar su atribución correspondiente.",
        "",
        "---",
        "",
        "Este README se genera automáticamente. Con `python -m cuadernos watch` —iniciado también por la tarea de VS Code— los cambios se reflejan al guardar.",
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
        "- Cada cuaderno mantiene su archivo `referencias.bib` para poder compilarse de forma autónoma.",
        "- `catalogo.bib` agrega todas las entradas y prefija sus claves con el ID del cuaderno.",
        "- `docs/bibliography.json` ofrece los mismos datos para buscadores o una futura web.",
        "- La ruta y activación de la bibliografía se declaran en el bloque `notebook` del main.",
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
        if generate_previews:
            list(pool.map(lambda notebook: generate_preview(notebook, force=force_previews), notebooks))


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

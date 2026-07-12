from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import re

from .models import Notebook, STATUS_LABELS
from .parser import bibliography_keys, parse_source

ALLOWED_COVER_STYLES = {"solid", "fullimage", "wiley", "wiley2"}
ALLOWED_PART_STATUS = {"planned", "outline", "draft", "review", "stable"}
ALLOWED_PROGRESS_MODES = {"auto", "manual"}


@dataclass(slots=True)
class Issue:
    severity: str
    code: str
    message: str
    path: Path | None = None

    def line(self, root: Path) -> str:
        location = f" — `{self.path.relative_to(root)}`" if self.path else ""
        return f"- **{self.severity.upper()} {self.code}**: {self.message}{location}"


def validate(notebooks: list[Notebook]) -> list[Issue]:
    issues: list[Issue] = []
    if not notebooks:
        return [Issue("error", "CAT001", "No se encontraron manifiestos cuaderno.toml")]
    root = notebooks[0].root

    def duplicates(values: list[str]) -> set[str]:
        return {value for value in values if values.count(value) > 1}

    for value in sorted(duplicates([n.id for n in notebooks])):
        issues.append(Issue("error", "ID001", f"ID duplicado: {value}"))
    for value in sorted(duplicates([n.slug for n in notebooks])):
        issues.append(Issue("error", "ID002", f"slug duplicado: {value}"))
    for value in sorted(duplicates([n.output_file for n in notebooks if n.output_file])):
        issues.append(Issue("error", "OUT001", f"output_file duplicado: {value}"))

    malformed = re.compile(r"#U[0-9A-Fa-f]{4}|[\\:*?\"<>|]")
    for path in (root / "cuadernos").rglob("*"):
        if malformed.search(path.name):
            issues.append(Issue("error", "PATH001", "Nombre de archivo o carpeta no portable", path))

    for pdf in (root / "cuadernos").rglob("*.pdf"):
        issues.append(Issue("warning", "PDF001", "PDF mezclado con las fuentes", pdf))

    for notebook in notebooks:
        if notebook.status not in STATUS_LABELS:
            issues.append(Issue("error", "META001", f"Estado desconocido: {notebook.status}", notebook.manifest_path))
        if not notebook.title.strip():
            issues.append(Issue("error", "META002", "Título vacío", notebook.manifest_path))
        if not notebook.authors:
            issues.append(Issue("warning", "META003", "No hay autores declarados", notebook.manifest_path))
        if notebook.progress.mode not in ALLOWED_PROGRESS_MODES:
            issues.append(Issue("error", "META004", f"Modo de progreso desconocido: {notebook.progress.mode}", notebook.manifest_path))
        if notebook.main_file:
            if notebook.main_path is None or not notebook.main_path.exists():
                issues.append(Issue("error", "SRC001", f"No existe main_file={notebook.main_file}", notebook.manifest_path))
            if notebook.content_path is None or not notebook.content_path.exists():
                issues.append(Issue("error", "SRC002", f"No existe content_file={notebook.content_file}", notebook.manifest_path))
            generated = notebook.path / "generated" / "config.typ"
            if not generated.exists():
                issues.append(Issue("error", "GEN001", "Falta generated/config.typ", notebook.manifest_path))
            generated_refs = notebook.path / "generated" / "part_references.typ"
            if not generated_refs.exists():
                issues.append(Issue("error", "GEN002", "Falta generated/part_references.typ", notebook.manifest_path))
        elif notebook.status != "planned":
            issues.append(Issue("warning", "SRC003", "Cuaderno sin fuente que no está marcado como planificado", notebook.manifest_path))

        style = str(notebook.cover.get("style", "solid"))
        if style not in ALLOWED_COVER_STYLES:
            issues.append(Issue("error", "COV001", f"Portada no permitida: {style}", notebook.manifest_path))
        cover_image = str(notebook.cover.get("image", ""))
        if cover_image and not (notebook.path / cover_image).exists():
            generated_cover = any(
                (notebook.path / "generated" / name).exists()
                for name in ("cover-extracted.png", "cover-placeholder.svg")
            )
            if not generated_cover:
                issues.append(Issue("warning", "COV002", f"No existe la imagen de portada {cover_image}", notebook.manifest_path))

        source_stats = parse_source(notebook.content_path)
        manifest_titles = [part.title for part in notebook.parts]
        source_titles = [part.title for part in source_stats.parts]
        if notebook.main_file and manifest_titles != source_titles:
            issues.append(
                Issue(
                    "warning",
                    "PART001",
                    "Las partes del manifiesto no coinciden con las partes activas del contenido; ejecuta `python -m cuadernos sync --refresh-parts`",
                    notebook.manifest_path,
                )
            )
        for part in notebook.parts:
            if part.status not in ALLOWED_PART_STATUS:
                issues.append(Issue("warning", "PART002", f"Estado de parte desconocido: {part.status}", notebook.manifest_path))

        keys = bibliography_keys(notebook.bibliography_path)
        referenced = {key for part in notebook.parts for key in part.references}
        for key in sorted(referenced - keys):
            issues.append(Issue("error", "BIB001", f"Clave bibliográfica no definida: {key}", notebook.manifest_path))
        if notebook.main_file and (notebook.bibliography_path is None or not notebook.bibliography_path.exists()):
            issues.append(Issue("warning", "BIB002", "No existe el archivo de bibliografía", notebook.manifest_path))

        if notebook.output_file and notebook.output_path and not notebook.output_path.exists():
            issues.append(Issue("info", "OUT002", "Todavía no hay PDF compilado", notebook.manifest_path))

    return issues


def validation_markdown(notebooks: list[Notebook], issues: list[Issue]) -> str:
    root = notebooks[0].root if notebooks else Path.cwd()
    counts = {level: sum(1 for i in issues if i.severity == level) for level in ("error", "warning", "info")}
    lines = [
        "# Validación del proyecto",
        "",
        f"- Errores: **{counts['error']}**",
        f"- Advertencias: **{counts['warning']}**",
        f"- Información: **{counts['info']}**",
        "",
    ]
    for severity, title in (("error", "Errores"), ("warning", "Advertencias"), ("info", "Información")):
        group = [i for i in issues if i.severity == severity]
        if group:
            lines += [f"## {title}", ""] + [i.line(root) for i in group] + [""]
    if not issues:
        lines += ["No se detectaron incidencias.", ""]
    return "\n".join(lines)

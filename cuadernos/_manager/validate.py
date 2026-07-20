from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import json
import re

from .metadata import METADATA_START
from .models import Notebook, STATUS_LABELS
from .parser import bibliography_keys, parse_source

ALLOWED_COVER_STYLES = {"solid", "fullimage", "wiley", "wiley2", "cover1", "cover3", "cover4", "cover5", "cover6", "cover7", "fullimage2", "wiley2.1", "wiley2.2"}
ALLOWED_PROGRESS_MODES = {"auto", "manual"}
OBSOLETE_NAMES = {"cuaderno.toml", "content.typ", "generated", "Partes", "Ejercicios", "Soluciones", "Bibliografia"}


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
        return [Issue("error", "CAT001", "No se encontraron archivos principales Typst con un bloque `notebook`")]
    root = notebooks[0].root

    def duplicates(values: list[str]) -> set[str]:
        return {value for value in values if value and values.count(value) > 1}

    for value in sorted(duplicates([n.id for n in notebooks])):
        issues.append(Issue("error", "ID001", f"ID duplicado: {value}"))
    for value in sorted(duplicates([n.slug for n in notebooks])):
        issues.append(Issue("error", "ID002", f"slug duplicado: {value}"))
    for value in sorted(duplicates([n.output_file for n in notebooks])):
        issues.append(Issue("error", "OUT001", f"archivo PDF de salida duplicado: {value}"))

    malformed = re.compile(r"#U[0-9A-Fa-f]{4}|[\\:*?\"<>|]")
    for path in (root / "cuadernos").rglob("*"):
        if malformed.search(path.name):
            issues.append(Issue("error", "PATH001", "Nombre de archivo o carpeta no portable", path))
    for pdf in (root / "cuadernos").rglob("*.pdf"):
        issues.append(Issue("warning", "PDF001", "PDF mezclado con las fuentes", pdf))

    settings_path = root / ".vscode" / "settings.json"
    try:
        editor_settings = json.loads(settings_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        editor_settings = {}
    template_path = root / "plantilla" / "plantilla.typ"
    try:
        template_text = template_path.read_text(encoding="utf-8")
    except OSError:
        template_text = ""
    expected_signature = "#let cuaderno(meta: (:), cover-source: none, bibliography-source: none, body)"
    if expected_signature not in template_text:
        issues.append(Issue(
            "error",
            "TPL001",
            "La plantilla `cuaderno` debe declarar `meta` como argumento nombrado para que `cuaderno.with(meta: notebook, ...)` deje libre únicamente el cuerpo del documento",
            template_path,
        ))

    expected_editor_settings = {
        "tinymist.rootPath": "${workspaceFolder}",
        "tinymist.projectResolution": "lockDatabase",
        "tinymist.exportPdf": "never",
    }
    for key, expected in expected_editor_settings.items():
        if editor_settings.get(key) != expected:
            issues.append(Issue("warning", "TIN001", f"Configura {key}={expected!r}", settings_path))

    for notebook in notebooks:
        main = notebook.main_path
        if notebook.status not in STATUS_LABELS:
            issues.append(Issue("error", "META001", f"Estado desconocido: {notebook.status}", main))
        if not notebook.id.strip():
            issues.append(Issue("error", "META000", "ID vacío", main))
        expected_prefix = f"{notebook.area_settings.prefix}-"
        expected_id = main.stem
        expected_output = f"{expected_id}.pdf"
        if notebook.id and not notebook.id.startswith(expected_prefix):
            issues.append(Issue(
                "error",
                "META006",
                f"El ID debe comenzar exactamente por {expected_prefix!r} para el área {notebook.area_label}",
                main,
            ))
        if notebook.main_file and not notebook.main_file.startswith(expected_prefix):
            issues.append(Issue(
                "error",
                "SRC005",
                f"El main debe comenzar exactamente por {expected_prefix!r}",
                main,
            ))
        if notebook.id != expected_id:
            issues.append(Issue(
                "error",
                "META007",
                f"El ID debe coincidir con el nombre del main: {expected_id!r}",
                main,
            ))
        if notebook.output_file != expected_output:
            issues.append(Issue(
                "error",
                "OUT003",
                f"El PDF de salida debe llamarse {expected_output!r}",
                main,
            ))
        if re.match(rf"^{re.escape(notebook.area_settings.prefix)}-\d+(?:-|$)", notebook.id):
            issues.append(Issue(
                "error",
                "META008",
                "El ID no debe contener un número de catálogo; usa Area-Nombre",
                main,
            ))
        if not notebook.title.strip():
            issues.append(Issue("error", "META002", "Título vacío", main))
        if not notebook.authors:
            issues.append(Issue("warning", "META003", "No hay autores declarados", main))
        if notebook.progress.mode not in ALLOWED_PROGRESS_MODES:
            issues.append(Issue("error", "META004", f"Modo de progreso desconocido: {notebook.progress.mode}", main))
        if not main.exists():
            issues.append(Issue("error", "SRC001", f"No existe {notebook.main_file}", main))
            continue

        main_text = main.read_text(encoding="utf-8", errors="replace")
        if METADATA_START not in main_text:
            issues.append(Issue("error", "META005", "Falta el bloque `notebook` en el main", main))
        if "#show: cuaderno.with(" not in main_text or "meta: notebook" not in main_text:
            issues.append(Issue("error", "SRC002", "El main no aplica la plantilla autocontenida `cuaderno`", main))
        if "cover-source: cover-source" not in main_text:
            issues.append(Issue("error", "SRC003", "La portada local no se pasa desde el main a la plantilla", main))
        if "bibliography-source: bibliography-source" not in main_text:
            issues.append(Issue("error", "SRC004", "La bibliografía local no se pasa desde el main a la plantilla", main))

        for obsolete in OBSOLETE_NAMES:
            candidate = notebook.path / obsolete
            if candidate.exists():
                issues.append(Issue("warning", "LAY001", f"Elemento antiguo innecesario: {obsolete}", candidate))
        for dirname in ("Capitulos", "Imagenes", "data"):
            candidate = notebook.path / dirname
            if not candidate.is_dir():
                issues.append(Issue("warning", "LAY002", f"Falta la carpeta {dirname}/", candidate))

        style = str(notebook.cover.get("style", "solid"))
        if style not in ALLOWED_COVER_STYLES:
            issues.append(Issue("error", "COV001", f"Portada no permitida: {style}", main))
        cover_image = str(notebook.cover.get("image", ""))
        if cover_image:
            cover_path = notebook.path / cover_image
            if not cover_path.exists():
                issues.append(Issue("error", "COV002", f"No existe la imagen de portada {cover_image}", main))
            elif cover_path.parent.name != "Imagenes":
                issues.append(Issue("warning", "COV003", "La portada debería vivir en Imagenes/", cover_path))
        elif style not in {"solid", "default"}:
            issues.append(Issue("warning", "COV004", "La portada de imagen no tiene archivo; usa `solid` o añade una imagen", main))

        stats = parse_source(main)
        if not stats.parts:
            issues.append(Issue("warning", "PART001", "El main no contiene ninguna parte activa", main))
        bib = notebook.bibliography_path
        if not bib.exists():
            issues.append(Issue("warning", "BIB002", f"No existe {notebook.bibliography_file}", main))
        keys = bibliography_keys(bib)
        if notebook.bibliography_enabled and not keys:
            issues.append(Issue("warning", "BIB003", "bibliography_enabled es true pero el BibTeX no contiene entradas", main))
        if keys and not notebook.bibliography_enabled:
            issues.append(Issue("warning", "BIB004", "Hay referencias, pero bibliography_enabled es false", main))

        if not notebook.output_path.exists():
            issues.append(Issue("info", "OUT002", "Todavía no hay PDF compilado", main))

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

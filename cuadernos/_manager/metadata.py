from __future__ import annotations

import json
from pathlib import Path
import re
from typing import Any

METADATA_START = "// <cuadernos:metadata>"
METADATA_END = "// </cuadernos:metadata>"
_METADATA_RE = re.compile(
    rf"{re.escape(METADATA_START)}\s*#let\s+notebook\s*=\s*(?P<value>.*?)\s*{re.escape(METADATA_END)}",
    re.DOTALL,
)


class MetadataError(ValueError):
    pass


class _Parser:
    def __init__(self, text: str):
        self.text = text
        self.pos = 0

    def parse(self) -> Any:
        value = self.value()
        self.ws()
        if self.pos != len(self.text):
            raise MetadataError(f"Contenido inesperado en metadatos: {self.text[self.pos:self.pos+40]!r}")
        return value

    def ws(self) -> None:
        while self.pos < len(self.text):
            if self.text[self.pos].isspace():
                self.pos += 1
                continue
            if self.text.startswith("//", self.pos):
                end = self.text.find("\n", self.pos)
                self.pos = len(self.text) if end < 0 else end + 1
                continue
            break

    def peek(self, value: str) -> bool:
        self.ws()
        return self.text.startswith(value, self.pos)

    def take(self, value: str) -> None:
        self.ws()
        if not self.text.startswith(value, self.pos):
            raise MetadataError(f"Se esperaba {value!r} en posición {self.pos}")
        self.pos += len(value)

    def string(self) -> str:
        self.ws()
        start = self.pos
        if self.pos >= len(self.text) or self.text[self.pos] != '"':
            raise MetadataError(f"Se esperaba una cadena en posición {self.pos}")
        self.pos += 1
        escaped = False
        while self.pos < len(self.text):
            char = self.text[self.pos]
            self.pos += 1
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                try:
                    return json.loads(self.text[start:self.pos])
                except json.JSONDecodeError as exc:
                    raise MetadataError(str(exc)) from exc
        raise MetadataError("Cadena sin cerrar")

    def identifier(self) -> str:
        self.ws()
        match = re.match(r"[A-Za-z_][A-Za-z0-9_-]*", self.text[self.pos:])
        if not match:
            raise MetadataError(f"Se esperaba un identificador en posición {self.pos}")
        self.pos += len(match.group(0))
        return match.group(0)

    def number(self) -> int | float:
        self.ws()
        match = re.match(r"[-+]?(?:\d+\.\d*|\.\d+|\d+)(?:[eE][-+]?\d+)?", self.text[self.pos:])
        if not match:
            raise MetadataError(f"Se esperaba un número en posición {self.pos}")
        raw = match.group(0)
        self.pos += len(raw)
        return float(raw) if any(ch in raw for ch in ".eE") else int(raw)

    def value(self) -> Any:
        self.ws()
        if self.pos >= len(self.text):
            raise MetadataError("Metadatos incompletos")
        char = self.text[self.pos]
        if char == '"':
            return self.string()
        if char == "(":
            return self.collection()
        if char.isdigit() or char in "+-.":
            return self.number()
        ident = self.identifier()
        if ident == "true":
            return True
        if ident == "false":
            return False
        if ident == "none":
            return None
        # El bloque de metadatos solo admite literales. Mantener un error claro
        # evita que el lector Python tenga que evaluar código Typst arbitrario.
        raise MetadataError(f"Valor no literal no permitido: {ident}")

    def collection(self) -> Any:
        self.take("(")
        self.ws()
        if self.peek(")"):
            self.take(")")
            return []

        entries: list[Any] = []
        mapping: dict[str, Any] = {}
        is_mapping: bool | None = None
        while True:
            self.ws()
            save = self.pos
            key: str | None = None
            if self.pos < len(self.text) and self.text[self.pos] == '"':
                possible = self.string()
                self.ws()
                if self.peek(":"):
                    key = possible
                else:
                    self.pos = save
            else:
                try:
                    possible = self.identifier()
                    self.ws()
                    if self.peek(":"):
                        key = possible
                    else:
                        self.pos = save
                except MetadataError:
                    self.pos = save

            if key is not None:
                if is_mapping is False:
                    raise MetadataError("No se pueden mezclar campos y valores en una colección")
                is_mapping = True
                self.take(":")
                mapping[key] = self.value()
            else:
                if is_mapping is True:
                    raise MetadataError("No se pueden mezclar campos y valores en una colección")
                is_mapping = False
                entries.append(self.value())

            self.ws()
            if self.peek(","):
                self.take(",")
                self.ws()
                if self.peek(")"):
                    self.take(")")
                    break
                continue
            self.take(")")
            break
        return mapping if is_mapping else entries


def extract_metadata_text(source: str) -> str:
    match = _METADATA_RE.search(source)
    if not match:
        raise MetadataError(
            f"El archivo principal no contiene el bloque {METADATA_START} … {METADATA_END}"
        )
    return match.group("value").strip()


def parse_metadata_source(source: str) -> dict[str, Any]:
    value = _Parser(extract_metadata_text(source)).parse()
    if not isinstance(value, dict):
        raise MetadataError("`notebook` debe ser un diccionario Typst `(clave: valor, ...)`")
    return value


def read_metadata(path: Path) -> dict[str, Any]:
    return parse_metadata_source(path.read_text(encoding="utf-8", errors="replace"))

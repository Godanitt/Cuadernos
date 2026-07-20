#!/usr/bin/env python3
"""Compila los cuadernos y reconstruye todos los metadatos derivados."""
from __future__ import annotations

from cuadernos._manager.cli import main

if __name__ == "__main__":
    raise SystemExit(main(["update"]))

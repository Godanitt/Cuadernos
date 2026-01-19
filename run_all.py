import subprocess
import os
from pathlib import Path
from multiprocessing import Pool, cpu_count
import re

# =====================================================
# ROOT REAL DEL PROYECTO
# =====================================================
PROJECT_ROOT = Path(__file__).resolve().parent

# ===== CARPETAS RAÍZ =====
carpetas_raiz = [
    "Base",
    "Fisica",
    "Ingenieria",
    "Matematicas",
    "Programacion",
    "Quimica",
    #"Trabajos",
]
# ========================

# Regex: cualquier número de ../ antes de plantilla.typ
IMPORT_RE = re.compile(
    r'#import\s+"(?:\.\./)+plantilla\.typ"\s*:\s*\*'
)

REPLACEMENT = '#import "/plantilla.typ": *'


def collect_top_level_typs(roots):
    files = []
    for root in roots:
        root_path = PROJECT_ROOT / root
        if not root_path.is_dir():
            continue
        for subdir in root_path.iterdir():
            if subdir.is_dir():
                files.extend(subdir.glob("*.typ"))
    return files


def patch_imports(files):
    """Reemplaza imports y devuelve un dict con los originales"""
    originals = {}

    for f in files:
        text = f.read_text(encoding="utf-8")
        if IMPORT_RE.search(text):
            originals[f] = text
            patched = IMPORT_RE.sub(REPLACEMENT, text)
            f.write_text(patched, encoding="utf-8")

    return originals


def restore_imports(originals):
    for f, text in originals.items():
        f.write_text(text, encoding="utf-8")

def compile_typ(typ_file: Path):
    typ_file = typ_file.resolve()
    rel_path = typ_file.relative_to(PROJECT_ROOT)

    env = dict(os.environ)
    env["TYPST_PROJECT_ROOT"] = str(PROJECT_ROOT)

    proc = subprocess.run(
        [
            "typst",
            "compile",
            str(rel_path),
            "--root",
            str(PROJECT_ROOT),
        ],
        cwd=PROJECT_ROOT,
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )

    if proc.returncode != 0:
        print("\n[ERROR]", rel_path)
        print(proc.stderr)
        return False

    return True



if __name__ == "__main__":
    print("PROJECT ROOT =", PROJECT_ROOT)

    typ_files = collect_top_level_typs(carpetas_raiz)

    if not typ_files:
        print("No se encontraron .typ")
        exit(0)

    print(f"Parchando imports en {len(typ_files)} archivos…")

    originals = patch_imports(typ_files)

    try:
        print("Compilando…")
        with Pool(cpu_count()) as pool:
            pool.map(compile_typ, typ_files)

    finally:
        print("Restaurando imports originales…")
        restore_imports(originals)

    print("DONE.")

import subprocess
from pathlib import Path
from multiprocessing import Pool, cpu_count

# ===== CARPETAS RAÍZ =====
carpetas_raiz = [
    "Base",
    "Fisica",
    "Ingenieria",
    "Matematicas",
    "Programacion",
    "Quimica",
    "Trabajos",
]
# ========================
PROJECT_ROOT = Path.cwd()   # ejecutas el script desde la raíz

def compile_typ(typ_file: Path):
    try:
        print(f"Compilando: {typ_file}")
        subprocess.run(
            [
                "typst",
                "compile",
                typ_file.name,
                "--root",
                str(PROJECT_ROOT),
            ],
            cwd=typ_file.parent,
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True,
        )
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] {typ_file}")
        print(e.stderr)

def collect_top_level_typs(roots):
    files = []

    for root in roots:
        root_path = Path(root)
        if not root_path.is_dir():
            continue

        # Solo una capa: Fisica/Electrodinamica/*.typ
        for subdir in root_path.iterdir():
            if not subdir.is_dir():
                continue

            files.extend(subdir.glob("*.typ"))

    return files

if __name__ == "__main__":
    typ_files = collect_top_level_typs(carpetas_raiz)

    if not typ_files:
        print("No se encontraron .typ de primer nivel")
        exit(0)

    n_cores = cpu_count()
    print(f"Compilando {len(typ_files)} archivos usando {n_cores} núcleos")

    with Pool(n_cores) as pool:
        pool.map(compile_typ, typ_files)

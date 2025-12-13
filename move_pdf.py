import shutil
from pathlib import Path

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

destino = Path(".pdf")
destino.mkdir(exist_ok=True)

def move_top_level_pdfs(roots, destination):
    for root in roots:
        root_path = Path(root)
        if not root_path.is_dir():
            continue

        # Solo una capa: Fisica/Electrodinamica/*.pdf
        for subdir in root_path.iterdir():
            if not subdir.is_dir():
                continue

            for pdf in subdir.glob("*.pdf"):
                target = destination / pdf.name

                # BORRAR si existe
                if target.exists():
                    target.unlink()

                print(f"Moviendo: {pdf} → {target}")
                shutil.move(str(pdf), str(target))

if __name__ == "__main__":
    move_top_level_pdfs(carpetas_raiz, destino)

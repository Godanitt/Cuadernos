# Patch cover3: bleed lateral mínimo

Corrige el hilo/margen blanco que se veía a la izquierda en la imagen del estilo `wiley-2` / `cover3`.

La caja de imagen sigue ocupando exactamente el ancho A4, pero el PNG se dibuja con un pequeño bleed lateral y se recorta dentro de la caja.

## Aplicación

```bash
cd ~/GitHub/Cuadernos
unzip cuadernos_cover3_left_bleed_patch.zip
bash apply_cover3_left_bleed.sh
python3 plantilla/scripts/run_all.py
```

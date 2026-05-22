# Plantilla

Aquí vive todo lo común a los cuadernos:

- `plantilla.typ`: archivo principal de estilos, entornos, colores, portada, bibliografía y macros.
- `Plantilla_Cuaderno/`: módulos auxiliares de índice, portada, teoremas, comandos y títulos.
- `scripts/`: automatización para compilar y recoger PDFs.

## Imports desde los cuadernos

Los cuadernos importan la plantilla mediante una ruta relativa hacia:

```typst
#import "../../../plantilla/plantilla.typ": *
```

en los `.typ` principales, o una ruta con un `../` adicional desde `Capitulos/` y `Ejercicios/`.

## Scripts

```bash
python plantilla/scripts/run_all.py
python plantilla/scripts/move_pdf.py
```

`run_all.py` es el flujo recomendado: compila todo y escribe directamente en `pdf/`.

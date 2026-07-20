# Cuadernos fuente

Los cuadernos están agrupados por área. Cada volumen es autocontenido:

```text
<Area>/<Cuaderno>/
├── <principal>.typ
├── referencias.bib
├── Capitulos/
├── Imagenes/
└── data/
```

El main contiene el bloque `notebook` con título, ID, autores, portada, colores, bibliografía y nombre del PDF. Después del bloque aparecen las partes, capítulos e inclusiones.

## Añadir un cuaderno

Copia una carpeta existente, renombra su main y modifica el bloque `notebook`. El siguiente `run_all` lo detectará directamente:

```bash
python run_all.py
```

No existe `cuaderno.toml`, no hay comando de alta y no se generan copias de las portadas dentro de cada volumen.

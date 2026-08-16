# Plantilla Typst compartida

Infraestructura común de maquetación para todos los cuadernos.

- `cuaderno.typ`: punto de entrada de la plantilla.
- `componentes/`: índices, títulos, teoremas, comandos y bibliografía local.
- `portadas/`: diseños de portada reutilizables.

Los cuadernos importan la plantilla con una ruta relativa como:

```typst
#import "../../../plantilla/cuaderno.typ": *
```

## Portadas disponibles

- `solid`
- `fullimage` / `cover4` → `portadas/full-image.typ`
- `fullimage2` / `cover5` → `portadas/full-image-2.typ`
- `wiley` / `wiley1` / `cover1` → `portadas/wiley-1.typ`
- `wiley2` / `cover3` → `portadas/wiley-2.typ`
- `wiley2.1` / `cover6` → `portadas/wiley-2-1.typ`
- `wiley2.2` / `cover7` → `portadas/wiley-2-2.typ`
- `cover2` → `portadas/cover-2.typ`

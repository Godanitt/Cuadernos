# Papers

Esta carpeta contiene exclusivamente las fuentes de artículos científicos.
Todo main Typst bajo `cuadernos/paper/` que contenga un bloque `paper` se
compila hacia `paper/` y nunca hacia `pdf/`.

## Organización

```text
cuadernos/paper/
└── Mi_Articulo/
    ├── P-MiArticulo.typ
    ├── referencias.bib        # opcional
    ├── Imagenes/              # opcional
    └── data/                  # opcional
```

## Estilo editorial

**Elsevier es el estilo por defecto.** Los valores disponibles son:

- `elsevier`
- `ieee`
- `mdpi`

Todos los papers deberían importar el dispatcher común:

```typst
#import "../../../plantilla/paper/paper.typ": paper-template
```

Para cambiar de formato editorial basta con cambiar una línea del bloque de
metadatos:

```typst
style: "elsevier",
```

por:

```typst
style: "ieee",
```

ó:

```typst
style: "mdpi",
```

Si se omite `style`, se usa `elsevier`.

## Compilación

```bash
python run_all.py                  # cuadernos + papers
python run_all.py cuadernos       # solo cuadernos -> pdf/
python run_all.py paper           # solo papers -> paper/
python run_all.py paper P-MiArticulo
python run_all.py paper --force
```

La compilación es incremental.

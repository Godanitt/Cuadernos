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

## Un solo formato de metadatos

Los tres estilos usan **exactamente el mismo bloque `paper`**. Las diferencias
entre las APIs externas de Elsevier, IEEE y MDPI se resuelven exclusivamente en
`plantilla/paper/`.

```typst
#import "../../../plantilla/paper/paper.typ": paper-template

// <paper:metadata>
#let paper = (
  id: "P-MiArticulo",
  slug: "mi-articulo",
  title: "Mi artículo",
  style: "elsevier",
  authors: (
    (
      name: "Daniel Vázquez Lago",
      department: "Department of Particle Physics",
      institution: "University",
      city: "Santiago de Compostela",
      country: "Spain",
      email: "daniel@example.com",
      corresponding: true,
    ),
  ),
  date: (year: 2026, month: "September", day: 6),
  doi: "",
  output: "P-MiArticulo.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  abstract: "Abstract...",
  keywords: ("keyword 1", "keyword 2"),
  tags: ("tag",),
)
// </paper:metadata>

#show: paper-template.with(meta: paper)
```

El formato abreviado `authors: ("Daniel Vázquez Lago",)` también funciona.

## Estilo editorial

**Elsevier es el estilo por defecto y siempre se renderiza a dos columnas.**
Los valores disponibles son:

- `elsevier`
- `ieee`
- `mdpi`

Para cambiar de formato solo cambia:

```typst
style: "elsevier",
```

por `"ieee"` o `"mdpi"`. No hay que cambiar autores, fecha, afiliación,
abstract, keywords ni ningún otro bloque.

## Compilación

```bash
python run_all.py                  # cuadernos + papers
python run_all.py cuadernos       # solo cuadernos -> pdf/
python run_all.py paper           # solo papers -> paper/
python run_all.py paper P-MiArticulo
python run_all.py paper --force
```

La compilación es incremental.

# Metadatos dentro del main Typst

Ya no existe `cuaderno.toml`. Todos los datos editables están al comienzo del archivo principal:

```typst
#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Mat-03",
  slug: "analisis-complejo",
  title: "Análisis Complejo",
  subtitle: "",
  area: "Matematicas",
  status: "development",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Mat-03-analisis-complejo.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,

  cover: (
    style: "fullimage",
    image: "Imagenes/complex_analysis.png",
    theme: "light",
    zoom: 1.0,
    dx_cm: 0.0,
    dy_cm: 0.0,
    text_color: "auto",
  ),

  style: (
    series: "Series Matemáticas",
    date: "today",
    font_size_pt: 11,
    main_color: "#0d2871",
    secondary_color: "#3c4f82",
    tertiary_color: "#60709b",
    part_style: 0,
  ),

  progress: (
    mode: "auto",
    target_words_per_chapter: 1500,
    target_figures_per_chapter: 1.0,
    target_exercises_per_chapter: 2.0,
    target_references_per_part: 4.0,
  ),
)
// </cuadernos:metadata>

#let cover-source = if notebook.cover.image == "" {
  none
} else {
  read(notebook.cover.image, encoding: none)
}
#let bibliography-source = if notebook.bibliography_enabled {
  read(notebook.bibliography, encoding: none)
} else {
  none
}
#show: cuaderno.with(
  meta: notebook,
  cover-source: cover-source,
  bibliography-source: bibliography-source,
)
```

Las dos variables anteriores cargan la portada y la bibliografía desde la carpeta del propio cuaderno. Después del `#show` se escribe directamente la estructura del volumen:

```typst
#part("Fundamentos")

#chapter("Introducción")
#include "Capitulos/Introduccion.typ"
```

## Portada

La imagen se modifica únicamente en `Imagenes/` y la ruta se indica en `notebook.cover.image`. No existe ninguna copia en `generated/` ni en la plantilla.

Estilos admitidos: `solid`, `fullimage`, `wiley` y `wiley2`, además de los nombres internos de las variantes de portada.

## Bibliografía

`referencias.bib` vive junto al main. Activa su impresión al final con:

```typst
bibliography_enabled: true,
```

## Estado editorial

Valores admitidos:

- `planned`
- `skeleton`
- `development`
- `usable`
- `stable`
- `paused`

El progreso se calcula automáticamente a partir del main y de los capítulos. Para fijarlo manualmente, usa `progress.mode: "manual"` y completa los porcentajes del bloque.

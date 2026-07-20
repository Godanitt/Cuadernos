#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Mat-Teoria_Grupos",
  slug: "teoria-de-grupos",
  title: "Teoría de Grupos",
  subtitle: " ",
  area: "Matematicas",
  status: "development",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Mat-Teoria_Grupos.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Cuaderno organizado en 3 partes y 7 capítulos activos.",
  scope: "Incluye Introducción y Grupos Discretos, Grupos Continuos, Teoría de Grupos aplicada a la física.",
  out_of_scope: "",
  tags: ("teoria-de-grupos",),
  cover: (
      style: "fullimage",
      image: "Imagenes/group_theory_2.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
    ),
  style: (
      series: "Series Matemáticas",
      date: "today",
      font_size_pt: 12,
      main_color: "#dc681a",
      secondary_color: "#c06d35",
      tertiary_color: "#d28b5b",
      typography: "Libertinus Serif",
      math_typography: "Libertinus Math",
      part_style: 0,
      github_url: "https://github.com/Godanitt/Cuadernos",
      lowercase_references: false,
      heading_style_compact: true,
      first_line_indent: false,
    ),
  progress: (
      text: 54,
      figures: 0,
      exercises: 75,
      bibliography: 16,
      review: 5,
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

//==================================================//

#part("Introducción y Grupos Discretos")

#chapter("Introducción a la Teoría de Grupos")
#include "Capitulos/Introduccion.typ"

#chapter("Homomorfismos y Reducibilidad")
#include "Capitulos/Homomorfismos.typ"
#chapter("Grupos finitos")
#include "Capitulos/GruposFinitos.typ"

//===============================================//

#part("Grupos Continuos")
#chapter("Grupos de Lie")
#include "Capitulos/GruposLie.typ"

//==============================================//

#part("Teoría de Grupos aplicada a la física")

#chapter("Rotaciones")
== Grupo $O(3)$
== Grupo $ S U (2)$

#chapter("Ecuacón de Dirac")

== Hamiton, Clifford y Dirac
== Álgebra de Dirac

#chapter("Campos de Yang-Milles")

== Teorema de Noeteher para Simetrías Internas
== El Nucleón de Yangs-Milles

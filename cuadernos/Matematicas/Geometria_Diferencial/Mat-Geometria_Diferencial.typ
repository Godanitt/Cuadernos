#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Mat-Geometria_Diferencial",
  slug: "geometria-diferencial",
  title: "Geometría Diferencial",
  subtitle: "",
  area: "Matematicas",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Mat-Geometria_Diferencial.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Cuaderno organizado en 4 partes y 24 capítulos activos.",
  scope: "Incluye Variedades Diferenciales, Geometría de Riemann, Relatividad General, Teorías de Gauge.",
  out_of_scope: "",
  tags: ("geometria-diferencial",),
  cover: (
      style: "fullimage",
      image: "Imagenes/differencial_geometry.png",
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
      text: 9,
      figures: 0,
      exercises: 0,
      bibliography: 32,
      review: 0,
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

//==========================================//
// -- VARIEDADES --------------------------
//==========================================//
#part("Variedades Diferenciales")

#chapter("Variedades Diferenciales")
#include "Capitulos/Variedades.typ"
#chapter("Formas Diferenciables")
#chapter("Tensores y Formas Exteriores")
#chapter("Álgebra Exeterior")
#chapter("Integrales en Variedades")
#chapter("Derivada de Lie")
#chapter("Lema de Poincaré")

//==========================================//
// -- GEOMETRÍA DE RIEMANN ----------------
//==========================================//
#part("Geometría de Riemann")

#chapter("Métrica de Riemann")
#chapter("Conexiones")
#chapter("Conexiones de Levi-Civita")
#chapter("Geodésicas y Distancias")
#chapter("Curvatura")

/*
//==========================================//
// -- RELATIVIDAD GENERAL ---------.-------
//==========================================//
#part("Relatividad General")

#chapter("Principio de equivalencia")
#chapter("Espaciotiempo y métrica lorentziana")
#chapter("Conexión y derivada covariante en Relatividad General")
#chapter("Geodésicas relativistas")
#chapter("Curvatura del espaciotiempo")
#chapter("Tensor energía-momento")
#chapter("Ecuaciones de Einstein")

//==========================================//
// -- TEORIAS GAUGE  ----------------------
//==========================================//
#part("Teorías de Gauge")

#chapter("Simetrías y principios de gauge")
#chapter("Fibrados principales y asociados")
#chapter("Conexiones en fibrados")
#chapter("Teoría gauge abeliana: electromagnetismo")
#chapter("Teorías gauge no abelianas")
*/

//==========================================//
// -- BIBLIOGRAFIA -------------------------
//==========================================//

#nocite(<FrankelGeometryPhysics>)
#nocite(<gross2023manifolds>)
#nocite(<NakaharaGeometryTopologyPhysics>)
#nocite(<Szekeres_2004>)

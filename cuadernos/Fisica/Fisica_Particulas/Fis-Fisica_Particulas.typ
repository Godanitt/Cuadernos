#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Fisica_Particulas",
  slug: "fisica-de-particulas",
  title: "Física de Partículas",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Fisica_Particulas.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 8 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos y simetrías, Mecánica cuántica relativista, Campos clásicos, Teoría cuántica de campos, Teorías gauge y modelo estándar, Fenomenología de partículas, Más allá del modelo estándar, Astropartículas y cosmología de partículas.",
  out_of_scope: "",
  tags: ("fisica-de-particulas",),
  cover: (
      style: "fullimage",
      image: "Imagenes/particle_physics.png",
      theme: "dark",
      zoom: 1.1,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Ciencias Físicas",
      date: "today",
      font_size_pt: 11,
      main_color: "#0d2871",
      secondary_color: "#3c4f82",
      tertiary_color: "#60709b",
      part_style: 0,
      github_url: "https://github.com/Godanitt/Cuadernos",
      lowercase_references: false,
      heading_style_compact: true,
      first_line_indent: false,
    ),
  progress: (
      text: 3,
      figures: 0,
      exercises: 0,
      bibliography: 16,
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

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos y simetrías")

#chapter("Partículas relativistas")

#chapter("Grupos de Lorentz y Poincaré")

#chapter("Simetrías internas")

#chapter("Teorema de Noether")
#part("Mecánica cuántica relativista")

#chapter("Ecuación de Klein-Gordon")

#chapter("Ecuación de Dirac")

#chapter("Espinores y antipartículas")

#chapter("Campos libres")
#part("Campos clásicos")

#chapter("Campos escalares")

#chapter("Campos fermiónicos")

#chapter("Campos gauge")

#chapter("Ruptura espontánea de simetría")
#part("Teoría cuántica de campos")

#chapter("Cuantización canónica")

#chapter("Integral de camino")

#chapter("Diagramas de Feynman")

#chapter("Renormalización")
#part("Teorías gauge y modelo estándar")

#chapter("Electrodinámica cuántica")

#chapter("Interacción electrodébil")

#chapter("Cromodinámica cuántica")

#chapter("Mecanismo de Higgs")
#part("Fenomenología de partículas")

#chapter("Desintegraciones y dispersión")

#chapter("Quarks y hadrones")

#chapter("Neutrinos")

#chapter("Física de sabor")
#part("Más allá del modelo estándar")

#chapter("Supersimetría y dimensiones extra")

#chapter("Materia oscura")

#chapter("Gran unificación")

#chapter("Física de neutrinos avanzada")
#part("Astropartículas y cosmología de partículas")

#chapter("Universo temprano")

#chapter("Bariogénesis")

#chapter("Rayos cósmicos")

#chapter("Ondas gravitacionales y partículas")

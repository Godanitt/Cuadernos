#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Q-Quimica_Analitica",
  slug: "quimica-analitica",
  title: "Química Analítica",
  subtitle: "",
  area: "Quimica",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Q-Quimica_Analitica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 6 partes previstas.",
  scope: "Incluirá Fundamentos del análisis químico, Equilibrios y análisis volumétrico, Métodos electroanalíticos, Espectroscopía analítica, Separaciones y cromatografía y Quimiometría, muestreo y control de calidad.",
  out_of_scope: "",
  tags: ("quimica-analitica",),
  cover: (
      style: "solid",
      image: "",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Ciencias Químicas",
      date: "today",
      font_size_pt: 11,
      main_color: "#134e4a",
      secondary_color: "#115e59",
      tertiary_color: "#0f766e",
      part_style: 0,
      github_url: "https://github.com/Godanitt/Cuadernos",
      lowercase_references: false,
      heading_style_compact: true,
      first_line_indent: false,
    ),
  progress: (
      mode: "auto",
      text: 0,
      figures: 0,
      exercises: 0,
      bibliography: 0,
      review: 0,
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

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos del análisis químico")

#chapter("Introducción")


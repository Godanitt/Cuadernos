#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fil-Ciencia",
  slug: "filosofia-de-la-ciencia",
  title: "Filosofía de la Ciencia",
  subtitle: "",
  area: "Filosofia",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fil-Ciencia.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 6 partes previstas.",
  scope: "Incluirá Conocimiento y método científico, Explicación, leyes y modelos, Confirmación y falsación, Realismo y antirrealismo, Revoluciones científicas y sociología de la ciencia y Filosofías de las ciencias particulares.",
  out_of_scope: "",
  tags: ("filosofia-de-la-ciencia",),
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
      series: "Series Filosofía",
      date: "today",
      font_size_pt: 11,
      main_color: "#312e81",
      secondary_color: "#3730a3",
      tertiary_color: "#4338ca",
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

#part("Conocimiento y método científico")

#chapter("Introducción")


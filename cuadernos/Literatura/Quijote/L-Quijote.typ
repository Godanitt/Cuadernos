#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "L-Quijote",
  slug: "don-quijote-de-la-mancha",
  title: "Don Quijote de la Mancha",
  subtitle: "",
  area: "Literatura",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "L-Quijote.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 6 partes previstas.",
  scope: "Incluirá Cervantes y su tiempo, Composición y estructura, Personajes y voces narrativas, Parodia, ficción y realidad, Recepción e interpretaciones y Legado y reescrituras.",
  out_of_scope: "",
  tags: ("don-quijote-de-la-mancha",),
  cover: (
      style: "fullimage",
      image: "Imagenes/quijote.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "white",
    ),
  style: (
      series: "Series Literatura",
      date: "today",
      font_size_pt: 11,
      main_color: "#701a75",
      secondary_color: "#86198f",
      tertiary_color: "#a21caf",
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

#part("Cervantes y su tiempo")

#chapter("Introducción")


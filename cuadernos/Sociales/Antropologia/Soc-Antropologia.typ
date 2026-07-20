#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Soc-Antropologia",
  slug: "antropologia",
  title: "Antropología",
  subtitle: "",
  area: "Sociales",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Soc-Antropologia.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 6 partes previstas.",
  scope: "Incluirá Fundamentos de la antropología, Cultura y organización social, Parentesco, economía y política, Religión, simbolismo y conocimiento, Antropología biológica y evolución humana y Métodos etnográficos y antropología contemporánea.",
  out_of_scope: "",
  tags: ("antropologia",),
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
      series: "Series Ciencias Sociales",
      date: "today",
      font_size_pt: 11,
      main_color: "#3f3f46",
      secondary_color: "#52525b",
      tertiary_color: "#71717a",
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

#part("Fundamentos de la antropología")

#chapter("Introducción")


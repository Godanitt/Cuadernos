#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Med-Neurologia",
  slug: "neurologia",
  title: "Neurología",
  subtitle: "",
  area: "Medicina",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Med-Neurologia.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 6 partes previstas.",
  scope: "Incluirá Exploración neurológica, Enfermedad cerebrovascular, Epilepsia y trastornos del movimiento, Enfermedades neurodegenerativas, Neuropatías y enfermedades neuromusculares y Neuroimagen, diagnóstico y tratamiento.",
  out_of_scope: "",
  tags: ("neurologia",),
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
      series: "Series Medicina",
      date: "today",
      font_size_pt: 11,
      main_color: "#7f1d1d",
      secondary_color: "#991b1b",
      tertiary_color: "#b91c1c",
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

#part("Exploración neurológica")

#chapter("Introducción")


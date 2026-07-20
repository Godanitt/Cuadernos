#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Pr-Aprendizaje_Automatico",
  slug: "aprendizaje-automatico",
  title: "Aprendizaje Automático",
  subtitle: "",
  area: "Programacion",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Pr-Aprendizaje_Automatico.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 7 partes previstas.",
  scope: "Incluirá Fundamentos matemáticos, Aprendizaje supervisado, Aprendizaje no supervisado, Redes neuronales, Modelos generativos, Evaluación y despliegue, Interpretabilidad, ética y seguridad.",
  out_of_scope: "",
  tags: ("aprendizaje-automatico",),
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
      series: "Series Computación",
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
      text: 0,
      figures: 0,
      exercises: 0,
      bibliography: 0,
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

#part("Fundamentos")

#chapter("Introducción")


#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "H-Espana",
  slug: "historia-de-espana",
  title: "Historia de España",
  subtitle: "",
  area: "Historia",
  status: "planned",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "H-Espana.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Cuaderno planificado con 6 partes previstas.",
  scope: "Incluirá Hispania antigua, Edad Media peninsular, Monarquía Hispánica, Reformas, revoluciones y Estado liberal, España contemporánea y Sociedad, economía y culturas históricas.",
  out_of_scope: "",
  tags: ("historia-de-espana",),
  cover: (
      style: "fullimage",
      image: "Imagenes/spain.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "white",
    ),
  style: (
      series: "Series Historia",
      date: "today",
      font_size_pt: 11,
      main_color: "#78350f",
      secondary_color: "#92400e",
      tertiary_color: "#b45309",
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

#part("Hispania antigua")

#chapter("Introducción")


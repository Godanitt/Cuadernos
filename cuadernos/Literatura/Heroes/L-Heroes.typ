#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "L-Heroes",
  slug: "heroes-en-la-literatura",
  title: "Héroes en la Literatura",
  subtitle: "",
  area: "Literatura",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "L-Heroes.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye El héroe mítico, Épica antigua, Héroe medieval, Modernidad y novela, Antihéroe y crisis del sujeto, Héroes contemporáneos.",
  out_of_scope: "",
  tags: ("heroes-en-la-literatura",),
  cover: (
      style: "fullimage",
      image: "Imagenes/heroes.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Estudios Literatura",
      date: "today",
      font_size_pt: 11,
      main_color: "#199b72",
      secondary_color: "#2d8668",
      tertiary_color: "#558d7b",
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

#part("El héroe mítico")

#chapter("Arquetipos")

#chapter("Viaje del héroe")

#chapter("Mito y ritual")

#chapter("Héroes trágicos")
#part("Épica antigua")

#chapter("Gilgamesh")

#chapter("Homero")

#chapter("Virgilio")

#chapter("Épicas comparadas")
#part("Héroe medieval")

#chapter("Cantar de gesta")

#chapter("Caballería")

#chapter("Héroes religiosos")

#chapter("Materia artúrica")
#part("Modernidad y novela")

#chapter("Héroe renacentista")

#chapter("Individuo moderno")

#chapter("Héroe romántico")

#chapter("Realismo")
#part("Antihéroe y crisis del sujeto")

#chapter("Picaresca")

#chapter("Héroe absurdo")

#chapter("Modernismo")

#chapter("Distopía")
#part("Héroes contemporáneos")

#chapter("Cómic y superhéroe")

#chapter("Cine y televisión")

#chapter("Fantasía y ciencia ficción")

#chapter("Relecturas poscoloniales y feministas")

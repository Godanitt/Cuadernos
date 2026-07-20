#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Fluidos",
  slug: "fisica-de-fluidos",
  title: "Física de Fluidos",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Fluidos.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de medios continuos, Fluidos ideales, Fluidos viscosos, Capas límite y aerodinámica, Turbulencia, Flujos compresibles, Fluidos multifásicos y geofísicos.",
  out_of_scope: "",
  tags: ("fisica-de-fluidos",),
  cover: (
      style: "fullimage",
      image: "Imagenes/fluid_mechanics.png",
      theme: "dark",
      zoom: 1.1,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
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

#part("Fundamentos de medios continuos")

#chapter("Cinemática de fluidos")

#chapter("Conservación de masa")

#chapter("Conservación de momento")

#chapter("Conservación de energía")
#part("Fluidos ideales")

#chapter("Ecuaciones de Euler")

#chapter("Bernoulli")

#chapter("Flujo potencial")

#chapter("Vorticidad")
#part("Fluidos viscosos")

#chapter("Navier-Stokes")

#chapter("Flujo de Poiseuille")

#chapter("Número de Reynolds")

#chapter("Disipación")
#part("Capas límite y aerodinámica")

#chapter("Teoría de capa límite")

#chapter("Separación")

#chapter("Sustentación y resistencia")

#chapter("Flujo alrededor de cuerpos")
#part("Turbulencia")

#chapter("Transición")

#chapter("Cascada de energía")

#chapter("Modelos estadísticos")

#chapter("Simulación de turbulencia")
#part("Flujos compresibles")

#chapter("Ondas de choque")

#chapter("Flujo supersónico")

#chapter("Toberas")

#chapter("Combustión")
#part("Fluidos multifásicos y geofísicos")

#chapter("Tensión superficial")

#chapter("Burbujas y gotas")

#chapter("Fluidos estratificados")

#chapter("Atmósfera y océanos")

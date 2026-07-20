#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Cuantica",
  slug: "fisica-cuantica",
  title: "Física Cuántica",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Cuantica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de la teoría cuántica, Dinámica cuántica, Sistemas elementales, Métodos de aproximación, Sistemas compuestos y partículas idénticas, Sistemas abiertos e información cuántica, Tecnologías cuánticas.",
  out_of_scope: "",
  tags: ("fisica-cuantica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/quantum_mechanics.png",
      theme: "dark",
      zoom: 1.1,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "white",
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

#part("Fundamentos de la teoría cuántica")

#chapter("Experimentos fundacionales")

#chapter("Estados y observables")

#chapter("Postulados")

#chapter("Medición e interpretación")
#part("Dinámica cuántica")

#chapter("Ecuación de Schrödinger")

#chapter("Representaciones de Schrödinger y Heisenberg")

#chapter("Propagadores")

#chapter("Límite clásico")
#part("Sistemas elementales")

#chapter("Pozos y barreras")

#chapter("Oscilador armónico")

#chapter("Momento angular")

#chapter("Spin")
#part("Métodos de aproximación")

#chapter("Teoría de perturbaciones")

#chapter("Método variacional")

#chapter("Aproximación WKB")

#chapter("Perturbaciones dependientes del tiempo")
#part("Sistemas compuestos y partículas idénticas")

#chapter("Producto tensorial y entrelazamiento")

#chapter("Bosones y fermiones")

#chapter("Segunda cuantización")

#chapter("Muchos cuerpos")
#part("Sistemas abiertos e información cuántica")

#chapter("Matrices densidad")

#chapter("Decoherencia")

#chapter("Canales cuánticos")

#chapter("Computación y comunicación cuánticas")
#part("Tecnologías cuánticas")

#chapter("Control cuántico")

#chapter("Metrología")

#chapter("Sensores")

#chapter("Simulación cuántica")

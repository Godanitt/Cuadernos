#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Electronica",
  slug: "ingenieria-electronica",
  title: "Ingeniería Electrónica",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Electronica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Dispositivos electrónicos, Electrónica analógica, Electrónica digital, Sistemas embebidos, Electrónica de potencia, Diseño y fabricación.",
  out_of_scope: "",
  tags: ("ingenieria-electronica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/electronic_enginering.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Ingenierías",
      date: "today",
      font_size_pt: 11,
      main_color: "#0c8608",
      secondary_color: "#51974e",
      tertiary_color: "#4a9b47",
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

#part("Dispositivos electrónicos")

#chapter("Semiconductores")

#chapter("Diodos")

#chapter("Transistores")

#chapter("Tecnologías integradas")
#part("Electrónica analógica")

#chapter("Amplificadores")

#chapter("Realimentación")

#chapter("Filtros")

#chapter("Conversión de datos")
#part("Electrónica digital")

#chapter("Lógica combinacional")

#chapter("Lógica secuencial")

#chapter("Arquitecturas digitales")

#chapter("FPGA")
#part("Sistemas embebidos")

#chapter("Microcontroladores")

#chapter("Interfaces")

#chapter("Tiempo real")

#chapter("Sistemas operativos embebidos")
#part("Electrónica de potencia")

#chapter("Convertidores")

#chapter("Control de potencia")

#chapter("Fuentes")

#chapter("Gestión térmica")
#part("Diseño y fabricación")

#chapter("PCB")

#chapter("Compatibilidad electromagnética")

#chapter("Verificación")

#chapter("Test y fiabilidad")

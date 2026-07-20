#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Minas",
  slug: "ingenieria-de-minas",
  title: "Ingeniería de Minas",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Minas.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Geología y exploración, Explotación minera, Mecánica de rocas, Ventilación y servicios, Procesamiento de minerales, Seguridad y medio ambiente, Economía y gestión.",
  out_of_scope: "",
  tags: ("ingenieria-de-minas",),
  cover: (
      style: "fullimage",
      image: "Imagenes/mines.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
    ),
  style: (
      series: "Series Ingenierías",
      date: "today",
      font_size_pt: 11,
      main_color: "#0c8608",
      secondary_color: "#51974e",
      tertiary_color: "#376335",
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

#part("Geología y exploración")

#chapter("Mineralogía")

#chapter("Yacimientos")

#chapter("Prospección")

#chapter("Estimación de recursos")
#part("Explotación minera")

#chapter("Minería a cielo abierto")

#chapter("Minería subterránea")

#chapter("Perforación y voladura")

#chapter("Planificación")
#part("Mecánica de rocas")

#chapter("Caracterización")

#chapter("Estabilidad")

#chapter("Sostenimiento")

#chapter("Geotecnia")
#part("Ventilación y servicios")

#chapter("Ventilación")

#chapter("Drenaje")

#chapter("Transporte")

#chapter("Energía y comunicaciones")
#part("Procesamiento de minerales")

#chapter("Conminución")

#chapter("Concentración")

#chapter("Hidrometalurgia")

#chapter("Pirometalurgia")
#part("Seguridad y medio ambiente")

#chapter("Riesgos")

#chapter("Residuos")

#chapter("Restauración")

#chapter("Agua y emisiones")
#part("Economía y gestión")

#chapter("Evaluación de proyectos")

#chapter("Costes")

#chapter("Legislación")

#chapter("Cierre de mina")

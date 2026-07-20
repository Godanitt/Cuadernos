#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Laser",
  slug: "laser",
  title: "Láser",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Laser.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Interacción luz-materia, Resonadores ópticos, Dinámica del láser, Tipos de láser, Pulsos ultracortos, Aplicaciones.",
  out_of_scope: "",
  tags: ("laser",),
  cover: (
      style: "fullimage",
      image: "Imagenes/laser.png",
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

#part("Interacción luz-materia")

#chapter("Emisión espontánea y estimulada")

#chapter("Inversión de población")

#chapter("Ensanchamiento de líneas")

#chapter("Ecuaciones de tasa")
#part("Resonadores ópticos")

#chapter("Modos de cavidad")

#chapter("Estabilidad")

#chapter("Pérdidas y calidad")

#chapter("Selección modal")
#part("Dinámica del láser")

#chapter("Umbral y ganancia")

#chapter("Ecuaciones de Maxwell-Bloch")

#chapter("Estabilidad y ruido")

#chapter("Bloqueo de modos")
#part("Tipos de láser")

#chapter("Láseres de gas")

#chapter("Láseres de estado sólido")

#chapter("Láseres semiconductores")

#chapter("Láseres de fibra")
#part("Pulsos ultracortos")

#chapter("Generación de pulsos")

#chapter("Dispersión y chirp")

#chapter("Amplificación CPA")

#chapter("Peines de frecuencia")
#part("Aplicaciones")

#chapter("Procesado de materiales")

#chapter("Medicina")

#chapter("Metrología")

#chapter("Comunicaciones y sensores")

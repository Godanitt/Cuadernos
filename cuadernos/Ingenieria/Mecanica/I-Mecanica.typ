#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Mecanica",
  slug: "ingenieria-mecanica",
  title: "Ingeniería Mecánica",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Mecanica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Mecánica y materiales, Diseño mecánico, Máquinas y vibraciones, Sistemas térmicos y fluidos, Fabricación, Mecatrónica y control, Fiabilidad y proyecto.",
  out_of_scope: "",
  tags: ("ingenieria-mecanica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/mechanical.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "white",
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

#part("Mecánica y materiales")

#chapter("Estática")

#chapter("Dinámica")

#chapter("Resistencia de materiales")

#chapter("Selección de materiales")
#part("Diseño mecánico")

#chapter("Elementos de máquinas")

#chapter("Fatiga")

#chapter("Tribología")

#chapter("Diseño asistido por ordenador")
#part("Máquinas y vibraciones")

#chapter("Mecanismos")

#chapter("Dinámica de máquinas")

#chapter("Vibraciones")

#chapter("Mantenimiento")
#part("Sistemas térmicos y fluidos")

#chapter("Termodinámica aplicada")

#chapter("Transferencia de calor")

#chapter("Mecánica de fluidos")

#chapter("Máquinas térmicas")
#part("Fabricación")

#chapter("Procesos de mecanizado")

#chapter("Conformado")

#chapter("Fabricación aditiva")

#chapter("Metrología y calidad")
#part("Mecatrónica y control")

#chapter("Actuadores")

#chapter("Sensores")

#chapter("Control")

#chapter("Robótica")
#part("Fiabilidad y proyecto")

#chapter("Fiabilidad")

#chapter("Seguridad")

#chapter("Gestión del ciclo de vida")

#chapter("Proyecto mecánico")

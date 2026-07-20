#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Sensores",
  slug: "sensores-e-instrumentacion",
  title: "Sensores e Instrumentación",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Sensores.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Ciencia de la medida, Sensores físicos, Sensores químicos y biológicos, Acondicionamiento de señal, Adquisición e instrumentación, Integración y aplicaciones.",
  out_of_scope: "",
  tags: ("sensores-e-instrumentacion",),
  cover: (
      style: "fullimage",
      image: "Imagenes/sensores.png",
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

#part("Ciencia de la medida")

#chapter("Magnitudes y unidades")

#chapter("Trazabilidad")

#chapter("Incertidumbre")

#chapter("Calibración")
#part("Sensores físicos")

#chapter("Temperatura")

#chapter("Presión y fuerza")

#chapter("Posición y movimiento")

#chapter("Ópticos y radiación")
#part("Sensores químicos y biológicos")

#chapter("Electroquímicos")

#chapter("Gases")

#chapter("Biosensores")

#chapter("Microfluídica")
#part("Acondicionamiento de señal")

#chapter("Puentes y amplificación")

#chapter("Filtrado")

#chapter("Ruido")

#chapter("Conversión A/D")
#part("Adquisición e instrumentación")

#chapter("DAQ")

#chapter("Instrumentación virtual")

#chapter("Sincronización")

#chapter("Sistemas distribuidos")
#part("Integración y aplicaciones")

#chapter("Sensores inteligentes")

#chapter("IoT industrial")

#chapter("Instrumentación científica")

#chapter("Diagnóstico y mantenimiento")

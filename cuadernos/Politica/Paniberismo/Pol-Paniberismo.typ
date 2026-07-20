#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Pol-Paniberismo",
  slug: "paniberismo",
  title: "Paniberismo",
  subtitle: "",
  area: "Politica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Pol-Paniberismo.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos del paniberismo, Historia compartida, Lenguas y culturas, Instituciones y ciudadanía, Economía e infraestructuras, Geopolítica y relaciones internacionales, Escenarios y hoja de ruta.",
  out_of_scope: "",
  tags: ("paniberismo",),
  cover: (
      style: "fullimage",
      image: "Imagenes/paniberismo.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
    ),
  style: (
      series: "Series Ciencias Políticas",
      date: "today",
      font_size_pt: 11,
      main_color: "#6226c2",
      secondary_color: "#8152ce",
      tertiary_color: "#8764c0",
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

#part("Fundamentos del paniberismo")

#chapter("Conceptos y alcance")

#chapter("Iberismo e hispanidad")

#chapter("Lusofonía")

#chapter("Paniberismo contemporáneo")
#part("Historia compartida")

#chapter("Península Ibérica")

#chapter("Expansión ultramarina")

#chapter("Independencias")

#chapter("Cooperación contemporánea")
#part("Lenguas y culturas")

#chapter("Español y portugués")

#chapter("Lenguas cooficiales")

#chapter("Cultura y educación")

#chapter("Patrimonio")
#part("Instituciones y ciudadanía")

#chapter("Modelos de integración")

#chapter("Derecho y movilidad")

#chapter("Representación")

#chapter("Cooperación territorial")
#part("Economía e infraestructuras")

#chapter("Comercio")

#chapter("Energía")

#chapter("Transportes")

#chapter("Ciencia y tecnología")
#part("Geopolítica y relaciones internacionales")

#chapter("Atlántico")

#chapter("Europa")

#chapter("América Latina")

#chapter("África y Asia")
#part("Escenarios y hoja de ruta")

#chapter("Integración gradual")

#chapter("Riesgos y críticas")

#chapter("Políticas públicas")

#chapter("Indicadores de seguimiento")

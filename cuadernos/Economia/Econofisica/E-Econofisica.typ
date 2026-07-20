#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "E-Econofisica",
  slug: "econofisica",
  title: "Econofísica",
  subtitle: "",
  area: "Economia",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "E-Econofisica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de econofísica, Mercados y series temporales, Modelos basados en agentes, Redes económicas y riesgo sistémico, Macroeconomía compleja, Métodos computacionales.",
  out_of_scope: "",
  tags: ("econofisica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/econophysics.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Economía Política ",
      date: "today",
      font_size_pt: 11,
      main_color: "#4e4623",
      secondary_color: "#4e482f",
      tertiary_color: "#6f6848",
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

#part("Fundamentos de econofísica")

#chapter("Sistemas complejos en economía")

#chapter("Escalas y distribuciones")

#chapter("Datos financieros")

#chapter("Hipótesis y límites")
#part("Mercados y series temporales")

#chapter("Retornos y volatilidad")

#chapter("Correlaciones")

#chapter("Modelos estocásticos")

#chapter("Riesgo extremo")
#part("Modelos basados en agentes")

#chapter("Agentes heterogéneos")

#chapter("Formación de precios")

#chapter("Burbujas y crisis")

#chapter("Calibración")
#part("Redes económicas y riesgo sistémico")

#chapter("Redes financieras")

#chapter("Contagio")

#chapter("Cadenas productivas")

#chapter("Resiliencia")
#part("Macroeconomía compleja")

#chapter("Crecimiento y ciclos")

#chapter("Distribución de riqueza")

#chapter("Dinámica sectorial")

#chapter("Política económica")
#part("Métodos computacionales")

#chapter("Simulación")

#chapter("Inferencia")

#chapter("Aprendizaje automático")

#chapter("Reproducibilidad")

#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Pol-Cibercomunismo",
  slug: "cibercomunismo",
  title: "Cibcom",
  subtitle: "",
  area: "Politica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Pol-Cibercomunismo.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos, Historia y antecedentes, Infraestructura técnica, Instituciones y gobernanza, Economía política, Derechos y riesgos, Transición y evaluación.",
  out_of_scope: "",
  tags: ("cibcom",),
  cover: (
      style: "fullimage",
      image: "Imagenes/cibcom.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "#ffffff",
    ),
  style: (
      series: "Series Ciencias Políticas",
      date: "today",
      font_size_pt: 11,
      main_color: "#c22626",
      secondary_color: "#972f2f",
      tertiary_color: "#5d3030",
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

#part("Fundamentos")

#chapter("Planificación económica")

#chapter("Cibernética")

#chapter("Comunismo y cálculo")

#chapter("Información y coordinación")
#part("Historia y antecedentes")

#chapter("Debate del cálculo socialista")

#chapter("Proyecto Cybersyn")

#chapter("Planificación computacional")

#chapter("Economía digital")
#part("Infraestructura técnica")

#chapter("Datos y contabilidad")

#chapter("Optimización")

#chapter("Simulación")

#chapter("Sistemas distribuidos")
#part("Instituciones y gobernanza")

#chapter("Participación")

#chapter("Control democrático")

#chapter("Niveles de planificación")

#chapter("Auditoría")
#part("Economía política")

#chapter("Propiedad")

#chapter("Asignación y precios")

#chapter("Trabajo y automatización")

#chapter("Innovación")
#part("Derechos y riesgos")

#chapter("Privacidad")

#chapter("Seguridad")

#chapter("Concentración de poder")

#chapter("Sesgos y transparencia")
#part("Transición y evaluación")

#chapter("Prototipos")

#chapter("Escalado")

#chapter("Indicadores")

#chapter("Críticas y alternativas")

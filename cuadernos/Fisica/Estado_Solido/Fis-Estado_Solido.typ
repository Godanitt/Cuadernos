#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Estado_Solido",
  slug: "fisica-del-estado-solido",
  title: "Física del Estado Sólido",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Estado_Solido.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Estructura cristalina, Electrones en sólidos, Dinámica de la red, Transporte electrónico, Magnetismo, Superconductividad, Materia condensada avanzada.",
  out_of_scope: "",
  tags: ("fisica-del-estado-solido",),
  cover: (
      style: "fullimage",
      image: "Imagenes/solid_state_3.png",
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

#part("Estructura cristalina")

#chapter("Redes y simetrías")

#chapter("Difracción")

#chapter("Defectos cristalinos")

#chapter("Superficies e interfaces")
#part("Electrones en sólidos")

#chapter("Modelo de electrones libres")

#chapter("Teorema de Bloch")

#chapter("Bandas electrónicas")

#chapter("Superficies de Fermi")
#part("Dinámica de la red")

#chapter("Fonones")

#chapter("Capacidad calorífica")

#chapter("Interacción electrón-fonón")

#chapter("Transporte térmico")
#part("Transporte electrónico")

#chapter("Conductividad")

#chapter("Efecto Hall")

#chapter("Semimetales y aislantes")

#chapter("Transporte mesoscópico")
#part("Magnetismo")

#chapter("Diamagnetismo y paramagnetismo")

#chapter("Ferromagnetismo")

#chapter("Antiferromagnetismo")

#chapter("Espintrónica")
#part("Superconductividad")

#chapter("Fenomenología")

#chapter("Teoría BCS")

#chapter("Vórtices y superconductores tipo II")

#chapter("Superconductividad no convencional")
#part("Materia condensada avanzada")

#chapter("Sistemas de baja dimensionalidad")

#chapter("Fases topológicas")

#chapter("Materia blanda")

#chapter("Nanomateriales")

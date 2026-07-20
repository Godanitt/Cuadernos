#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-FisicaPlasma",
  slug: "fisica-del-plasma",
  title: "Física del Plasma",
  subtitle: " ",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-FisicaPlasma.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 8 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos del plasma, Movimiento de partículas, Teoría cinética, Descripción fluida y MHD, Ondas e inestabilidades, Plasmas fríos y descargas, Fusión y confinamiento, Plasmas espaciales y astrofísicos.",
  out_of_scope: "",
  tags: ("fisica-del-plasma",),
  cover: (
      style: "fullimage",
      image: "Imagenes/plasma_physics.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
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

#part("Fundamentos del plasma")

#chapter("Parámetros de plasma")

#chapter("Apantallamiento de Debye")

#chapter("Equilibrio e ionización")

#chapter("Diagnóstico")
#part("Movimiento de partículas")

#chapter("Órbitas en campos")

#chapter("Derivas")

#chapter("Espejos magnéticos")

#chapter("Colisiones")
#part("Teoría cinética")

#chapter("Ecuación de Boltzmann")

#chapter("Ecuación de Vlasov")

#chapter("Funciones de distribución")

#chapter("Amortiguamiento de Landau")
#part("Descripción fluida y MHD")

#chapter("Modelos de dos fluidos")

#chapter("Magnetohidrodinámica")

#chapter("Equilibrios")

#chapter("Reconexión magnética")
#part("Ondas e inestabilidades")

#chapter("Ondas electrostáticas")

#chapter("Ondas electromagnéticas")

#chapter("Inestabilidades cinéticas")

#chapter("Inestabilidades MHD")
#part("Plasmas fríos y descargas")

#chapter("Descargas eléctricas")

#chapter("Química de plasmas")

#chapter("Sheaths")

#chapter("Plasma tecnológico")
#part("Fusión y confinamiento")

#chapter("Tokamaks y stellarators")

#chapter("Confinamiento inercial")

#chapter("Calentamiento")

#chapter("Transporte anómalo")
#part("Plasmas espaciales y astrofísicos")

#chapter("Viento solar")

#chapter("Magnetosferas")

#chapter("Discos de acreción")

#chapter("Jets y choques")

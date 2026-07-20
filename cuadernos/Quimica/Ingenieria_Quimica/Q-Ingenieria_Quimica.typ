#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Q-Ingenieria_Quimica",
  slug: "ingenieria-quimica",
  title: "Ingeniería Química",
  subtitle: "",
  area: "Quimica",
  status: "development",
  language: "es",
  authors: ("María Álvarez Barciela",),
  output: "Q-Ingenieria_Quimica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Cuaderno desarrollado de ingeniería química con balances, transporte y operaciones de separación.",
  scope: "Incluye fundamentos de proceso, balances de materia y energía, transporte de cantidad de movimiento y calor, y operaciones de separación.",
  out_of_scope: "",
  tags: ("ingenieria-quimica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/chemical_enginering_1.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
    ),
  style: (
      series: "Series Ciencias Químicas",
      date: "today",
      font_size_pt: 12,
      main_color: "#16aeb9",
      secondary_color: "#43b6bf",
      tertiary_color: "#61afb5",
      typography: "Libertinus Serif",
      math_typography: "Libertinus Math",
      part_style: 0,
      github_url: "https://github.com/Godanitt/Cuadernos",
      lowercase_references: false,
      heading_style_compact: true,
      first_line_indent: false,
    ),
  progress: (
      text: 80,
      figures: 75,
      exercises: 0,
      bibliography: 16,
      review: 5,
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

#part("Fundamentos y balances")

#chapter("La ingeniería química y los procesos químicos")
#include "Capitulos/Introduccion.typ"

#chapter("Principios de conservación: balances de materia")
#include "Capitulos/BalancesMateria.typ"

#chapter("Principios de conservación: balances de energía")
#include "Capitulos/BalanceEnergia.typ"
#part("Fenómenos de transporte")

#chapter("Flujo de fluidos")
#include "Capitulos/TrasferenciaFluidos.typ"

#chapter("Transferencia de calor")
#include "Capitulos/Trasferencia_Calor.typ"
#part("Operaciones de separación")

#chapter("Procesos de separación")
#include "Capitulos/Procesos_Separacion.typ"
#part("Diseño, control y seguridad de procesos")
#nocite(<calleja2008>)
#nocite(<himmelblau2002>)

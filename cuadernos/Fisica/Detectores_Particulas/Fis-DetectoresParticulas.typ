#import "../../../plantilla/cuaderno.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-DetectoresParticulas",
  slug: "detectores-en-fisica-nuclear-y-particulas",
  title: "Detectores en Física Nuclear y Partículas",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-DetectoresParticulas.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Cuaderno organizado en 7 partes y 11 capítulos activos.",
  scope: "Incluye Interacción radiación–materia, Electrónica, Estadística, Aceleradores, Detectores, Simulación en física de detectores, Aplicaciones.",
  out_of_scope: "",
  tags: ("detectores-en-fisica-nuclear-y-particulas",),
  cover: (
      style: "fullimage",
      image: "Imagenes/particle_physics_detector.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Ciencias Físicas",
      date: "today",
      font_size_pt: 12,
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
      text: 5,
      figures: 3,
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

#part("Interacción Radiación-Materia")
#include "Capitulos/InteraccionRadiacionMateria.typ"

#part("Electronica")
#include "Capitulos/Electronica.typ"

#part("Estadística")
#include "Capitulos/Estadistica.typ"

#part("Aceleradores")
#include "Capitulos/Aceleradores.typ"

#part("Tecnologias de Deteccion")
#include "Capitulos/TecnologiasDeteccion.typ"

#part("Detectores Gaseosos")
#include "Capitulos/DetectoresGaseosos.typ"

#part("Detectores Líquidos")
#include "Capitulos/DetectoresLiquidos.typ"

#part("Detectores Semiconductores")
#include "Capitulos/DetectoresSemiconductores.typ"

#part("Detectores de Centelleo")
#include "Capitulos/DetectoresCentelleo.typ"

#part("Detectores Cherenkov")
#include "Capitulos/DetectoresCerenkov.typ"

#part("Calorímetros")
#include "Capitulos/Calorimetros.typ"

#part("Detectores de Neutrones")
#include "Capitulos/DetectoresNeutrones.typ"

#part("Softwares de Simulación")
#include "Capitulos/Simulacion.typ"

#part("Aplicaciones")
#include "Capitulos/Aplicaciones.typ"
#import "../../../plantilla/plantilla.typ": *

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

#part("Interacción radiación–materia")
#chapter("")
#part("Electrónica")
#chapter("")
#part("Estadística")
#chapter("")
#part("Aceleradores")
#chapter("Sincrotrón")
#include "Capitulos/Sincrotron.typ"
#part("Detectores")

#chapter("Indentificación de Partículas")

#chapter("Detectores Gaseosos")

#chapter("Detectores de Fotones")

#chapter("Detectores Centelleadores")

#chapter("Detectores Semiconductores")

#chapter("Detectores Cherenkov")

#chapter("Espectrómetros de muones")

#chapter("Calorímetros")
#include "Capitulos/Calorimetros.typ"

#chapter("Detectores de Estado Sólido")
#part("Simulación en física de detectores")
#chapter("")
#part("Aplicaciones")

#chapter("Detectores en Grandes Experimentos")
#include "Capitulos/DetectoresGrandesExp.typ"

#chapter("")

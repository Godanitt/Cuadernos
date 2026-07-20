#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Electrodinamica",
  slug: "electrodinamica",
  title: "Electrodinámica",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Electrodinamica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Cuaderno organizado en 5 partes y 16 capítulos activos.",
  scope: "Incluye Contenido, Electrostática, Magnetostática, Electrodinámica, Radiación.",
  out_of_scope: "",
  tags: ("electrodinamica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/electrodynamics.png",
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
      text: 0,
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

#chapter("Análisis Vectorial")

#part("Electrostática")
#chapter("Electrostática")
#chapter("Condiciones de frontera en Electrostática")
#chapter("Campos eléctricos en medios materiales")
#part("Magnetostática")
#chapter("Magnetostática")
#chapter("Campos magnéticos en medios materiales")
#chapter("Materiaels Magnéticos")
#part("Electrodinámica")

#chapter("Electrodinámica")
#chapter("Leyes de Conervación")
#chapter("Ondas electromagnéticas")
#chapter("Guidas de Ondas")
#chapter("Relatividad especial")
#chapter("Electrodinámica Relativista")
#part("Radiación")

#chapter("Sistemas Radiantes: multipolos")
#chapter("Radiación de Partículas en Movimiento")
#chapter("Colisiones entre partículas y pérdidas de energía")

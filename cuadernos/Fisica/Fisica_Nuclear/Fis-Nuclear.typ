#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Nuclear",
  slug: "fisica-nuclear",
  title: "Física Nuclear",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Nuclear.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Propiedades del núcleo, Modelos nucleares, Desintegraciones radiactivas, Reacciones nucleares, Fisión y fusión, Astrofísica nuclear, Aplicaciones.",
  out_of_scope: "",
  tags: ("fisica-nuclear",),
  cover: (
      style: "fullimage",
      image: "Imagenes/Nuclear_physics_4.png",
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
      main_color: "#041F68",
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

#part("Propiedades del núcleo")

#chapter("Masas y energías de enlace")

#chapter("Radios y distribuciones")

#chapter("Spin, paridad y momentos")

#chapter("Fuerzas nucleares")
#part("Modelos nucleares")

#chapter("Modelo de gota líquida")

#chapter("Modelo de capas")

#chapter("Modelos colectivos")

#chapter("Estructura de núcleos exóticos")
#part("Desintegraciones radiactivas")

#chapter("Desintegración alfa")

#chapter("Desintegración beta")

#chapter("Emisión gamma")

#chapter("Cadenas y equilibrio radiactivo")
#part("Reacciones nucleares")

#chapter("Cinemática y secciones eficaces")

#chapter("Modelo óptico")

#chapter("Reacciones directas")

#chapter("Núcleo compuesto")
#part("Fisión y fusión")

#chapter("Fisión nuclear")

#chapter("Reactores")

#chapter("Fusión termonuclear")

#chapter("Confinamiento y combustibles")
#part("Astrofísica nuclear")

#chapter("Nucleosíntesis estelar")

#chapter("Procesos r, s y rp")

#chapter("Supernovas")

#chapter("Materia nuclear densa")
#part("Aplicaciones")

#chapter("Medicina nuclear")

#chapter("Datación y análisis")

#chapter("Energía nuclear")

#chapter("Seguridad y protección radiológica")

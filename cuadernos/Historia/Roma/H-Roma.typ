#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "H-Roma",
  slug: "roma",
  title: "Hisotoria de Roma",
  subtitle: "",
  area: "Historia",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "H-Roma.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Orígenes y monarquía, República romana, Crisis de la República, Alto Imperio, Sociedad, economía y cultura, Antigüedad tardía, Legado e historiografía.",
  out_of_scope: "",
  tags: ("roma",),
  cover: (
      style: "fullimage",
      image: "Imagenes/Rome.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Historia",
      date: "today",
      font_size_pt: 11,
      main_color: "#93138f",
      secondary_color: "#8a3687",
      tertiary_color: "#81487f",
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

#part("Orígenes y monarquía")

#chapter("Italia prerromana")

#chapter("Fundación y mitos")

#chapter("Monarquía")

#chapter("Sociedad arcaica")
#part("República romana")

#chapter("Instituciones republicanas")

#chapter("Conflicto de los órdenes")

#chapter("Expansión por Italia")

#chapter("Guerras púnicas")
#part("Crisis de la República")

#chapter("Imperialismo mediterráneo")

#chapter("Transformaciones sociales")

#chapter("Guerras civiles")

#chapter("César y Augusto")
#part("Alto Imperio")

#chapter("Principado")

#chapter("Dinastías")

#chapter("Administración imperial")

#chapter("Fronteras y ejército")
#part("Sociedad, economía y cultura")

#chapter("Ciudadanía y derecho")

#chapter("Esclavitud y economía")

#chapter("Religión")

#chapter("Literatura y arte")
#part("Antigüedad tardía")

#chapter("Crisis del siglo III")

#chapter("Tetrarquía y Constantino")

#chapter("Cristianización")

#chapter("Caída de Occidente")
#part("Legado e historiografía")

#chapter("Bizancio y continuidad")

#chapter("Recepción de Roma")

#chapter("Arqueología")

#chapter("Debates historiográficos")

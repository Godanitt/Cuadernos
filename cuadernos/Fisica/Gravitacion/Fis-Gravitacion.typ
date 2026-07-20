#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Gravitacion",
  slug: "gravitacion",
  title: "Gravitación",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Gravitacion.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Relatividad especial, Geometría del espacio-tiempo, Relatividad general, Soluciones y objetos compactos, Ondas gravitacionales, Cosmología relativista, Gravedad avanzada.",
  out_of_scope: "",
  tags: ("gravitacion",),
  cover: (
      style: "fullimage",
      image: "Imagenes/gravitation.png",
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

#part("Relatividad especial")

#chapter("Postulados y transformaciones de Lorentz")

#chapter("Cinemática relativista")

#chapter("Dinámica relativista")

#chapter("Electromagnetismo covariante")
#part("Geometría del espacio-tiempo")

#chapter("Variedades y tensores")

#chapter("Conexión y geodésicas")

#chapter("Curvatura")

#chapter("Cálculo variacional")
#part("Relatividad general")

#chapter("Principio de equivalencia")

#chapter("Ecuaciones de Einstein")

#chapter("Límite newtoniano")

#chapter("Formulación inicial")
#part("Soluciones y objetos compactos")

#chapter("Schwarzschild")

#chapter("Kerr")

#chapter("Estrellas relativistas")

#chapter("Agujeros negros")
#part("Ondas gravitacionales")

#chapter("Aproximación lineal")

#chapter("Generación y propagación")

#chapter("Detectores")

#chapter("Astronomía multimensajero")
#part("Cosmología relativista")

#chapter("Modelos de Friedmann")

#chapter("Inflación")

#chapter("Perturbaciones cosmológicas")

#chapter("Energía oscura")
#part("Gravedad avanzada")

#chapter("Termodinámica de agujeros negros")

#chapter("Gravedad cuántica")

#chapter("Teorías modificadas")

#chapter("Holografía")

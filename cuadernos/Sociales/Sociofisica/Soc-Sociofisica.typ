#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Soc-Sociofisica",
  slug: "sociofisica",
  title: "Sociofísica",
  subtitle: "",
  area: "Sociales",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Soc-Sociofisica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de sociofísica, Redes sociales, Opinión y polarización, Cooperación y conflicto, Ciudades, movilidad y población, Métodos computacionales.",
  out_of_scope: "",
  tags: ("sociofisica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/sociophysics.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Urbanismo ",
      date: "today",
      font_size_pt: 11,
      main_color: "#4e4623",
      secondary_color: "#4e482f",
      tertiary_color: "#6f6848",
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

#part("Fundamentos de sociofísica")

#chapter("Modelización social")

#chapter("Regularidades estadísticas")

#chapter("Micro-macro")

#chapter("Límites epistemológicos")
#part("Redes sociales")

#chapter("Estructura de redes")

#chapter("Comunidades")

#chapter("Difusión")

#chapter("Centralidad e influencia")
#part("Opinión y polarización")

#chapter("Consenso")

#chapter("Modelos de confianza acotada")

#chapter("Cámaras de eco")

#chapter("Desinformación")
#part("Cooperación y conflicto")

#chapter("Juegos evolutivos")

#chapter("Normas sociales")

#chapter("Segregación")

#chapter("Movimientos colectivos")
#part("Ciudades, movilidad y población")

#chapter("Escalado urbano")

#chapter("Movilidad humana")

#chapter("Migraciones")

#chapter("Demografía")
#part("Métodos computacionales")

#chapter("Modelos basados en agentes")

#chapter("Inferencia causal")

#chapter("Datos masivos")

#chapter("Ética y privacidad")

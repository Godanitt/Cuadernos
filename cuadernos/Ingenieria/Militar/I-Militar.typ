#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Militar",
  slug: "ingenieria-militar",
  title: "Ingeniería Militar",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Militar.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Ingeniería de sistemas de defensa, Infraestructuras y movilidad, Sensores, comunicaciones y mando, Plataformas y protección, Logística y operaciones, Seguridad y resiliencia.",
  out_of_scope: "",
  tags: ("ingenieria-militar",),
  cover: (
      style: "fullimage",
      image: "Imagenes/militar.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "white",
    ),
  style: (
      series: "Series Ingenierías",
      date: "today",
      font_size_pt: 11,
      main_color: "#0c8608",
      secondary_color: "#51974e",
      tertiary_color: "#376335",
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

#part("Ingeniería de sistemas de defensa")

#chapter("Requisitos y arquitectura")

#chapter("Integración")

#chapter("Verificación")

#chapter("Ciclo de vida")
#part("Infraestructuras y movilidad")

#chapter("Fortificación")

#chapter("Puentes y rutas")

#chapter("Campamentos")

#chapter("Movilidad terrestre")
#part("Sensores, comunicaciones y mando")

#chapter("Sensores")

#chapter("Comunicaciones seguras")

#chapter("Navegación")

#chapter("Sistemas de mando y control")
#part("Plataformas y protección")

#chapter("Plataformas terrestres")

#chapter("Navales y aéreas")

#chapter("Protección y supervivencia")

#chapter("Mantenimiento")
#part("Logística y operaciones")

#chapter("Cadena de suministro")

#chapter("Fiabilidad")

#chapter("Planificación")

#chapter("Ingeniería humanitaria")
#part("Seguridad y resiliencia")

#chapter("Protección de infraestructuras")

#chapter("Ciberseguridad")

#chapter("Riesgos NRBQ")

#chapter("Desminado y reconstrucción")

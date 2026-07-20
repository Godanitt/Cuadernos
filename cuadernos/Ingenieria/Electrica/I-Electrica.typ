#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Electrica",
  slug: "ingenieria-electrica",
  title: "Ingeniería Eléctrica",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Electrica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Circuitos y electromagnetismo, Máquinas eléctricas, Electrónica de potencia, Generación y redes, Alta tensión y protecciones, Sistemas eléctricos modernos.",
  out_of_scope: "",
  tags: ("ingenieria-electrica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/electrical.png",
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
      tertiary_color: "#4a9b47",
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

#part("Circuitos y electromagnetismo")

#chapter("Circuitos eléctricos")

#chapter("Sistemas trifásicos")

#chapter("Campos electromagnéticos")

#chapter("Medidas eléctricas")
#part("Máquinas eléctricas")

#chapter("Transformadores")

#chapter("Máquinas de corriente continua")

#chapter("Máquinas síncronas")

#chapter("Máquinas de inducción")
#part("Electrónica de potencia")

#chapter("Rectificadores")

#chapter("Convertidores")

#chapter("Inversores")

#chapter("Accionamientos")
#part("Generación y redes")

#chapter("Generación convencional")

#chapter("Renovables")

#chapter("Flujo de carga")

#chapter("Estabilidad")
#part("Alta tensión y protecciones")

#chapter("Aislamiento")

#chapter("Sobretensiones")

#chapter("Protecciones")

#chapter("Puesta a tierra")
#part("Sistemas eléctricos modernos")

#chapter("Redes inteligentes")

#chapter("Almacenamiento")

#chapter("Microredes")

#chapter("Movilidad eléctrica")

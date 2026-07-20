#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Energetica",
  slug: "ingenieria-energetica",
  title: "Ingeniería Energética",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Energetica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos energéticos, Sistemas térmicos, Energías renovables, Almacenamiento e hidrógeno, Sistemas eléctricos y redes, Energía nuclear, Eficiencia y ambiente.",
  out_of_scope: "",
  tags: ("ingenieria-energetica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/energetic.png",
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

#part("Fundamentos energéticos")

#chapter("Balances y exergía")

#chapter("Conversión de energía")

#chapter("Recursos")

#chapter("Demanda")
#part("Sistemas térmicos")

#chapter("Ciclos de potencia")

#chapter("Turbinas")

#chapter("Cogeneración")

#chapter("Refrigeración")
#part("Energías renovables")

#chapter("Solar")

#chapter("Eólica")

#chapter("Hidráulica")

#chapter("Bioenergía")
#part("Almacenamiento e hidrógeno")

#chapter("Baterías")

#chapter("Almacenamiento térmico")

#chapter("Hidrógeno")

#chapter("Power-to-X")
#part("Sistemas eléctricos y redes")

#chapter("Integración renovable")

#chapter("Redes")

#chapter("Mercados")

#chapter("Flexibilidad")
#part("Energía nuclear")

#chapter("Reactores")

#chapter("Ciclo del combustible")

#chapter("Seguridad")

#chapter("Fusión")
#part("Eficiencia y ambiente")

#chapter("Eficiencia industrial")

#chapter("Edificios")

#chapter("Emisiones")

#chapter("Análisis de ciclo de vida")

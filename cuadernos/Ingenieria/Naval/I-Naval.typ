#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Naval",
  slug: "ingenieria-naval",
  title: "Ingeniería Naval",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Naval.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Hidrostática y estabilidad, Hidrodinámica naval, Estructuras navales, Propulsión y energía, Sistemas del buque, Construcción y proyecto, Ingeniería oceánica.",
  out_of_scope: "",
  tags: ("ingenieria-naval",),
  cover: (
      style: "fullimage",
      image: "Imagenes/naval.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
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

#part("Hidrostática y estabilidad")

#chapter("Geometría del buque")

#chapter("Flotabilidad")

#chapter("Estabilidad intacta")

#chapter("Estabilidad averiada")
#part("Hidrodinámica naval")

#chapter("Resistencia")

#chapter("Propulsión")

#chapter("Maniobrabilidad")

#chapter("Comportamiento en la mar")
#part("Estructuras navales")

#chapter("Cargas")

#chapter("Dimensionamiento")

#chapter("Fatiga")

#chapter("Materiales y corrosión")
#part("Propulsión y energía")

#chapter("Motores marinos")

#chapter("Hélices")

#chapter("Propulsión eléctrica")

#chapter("Eficiencia energética")
#part("Sistemas del buque")

#chapter("Sistemas auxiliares")

#chapter("Electricidad y control")

#chapter("Seguridad")

#chapter("Habitabilidad")
#part("Construcción y proyecto")

#chapter("Astilleros")

#chapter("Producción")

#chapter("Reglamentación")

#chapter("Diseño integrado")
#part("Ingeniería oceánica")

#chapter("Estructuras offshore")

#chapter("Energías marinas")

#chapter("Submarinos")

#chapter("Operaciones marítimas")

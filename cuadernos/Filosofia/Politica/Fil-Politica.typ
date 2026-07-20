#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fil-Politica",
  slug: "filosofia-politica",
  title: "Filosofía Política",
  subtitle: "",
  area: "Filosofia",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fil-Politica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de filosofía política, Pensamiento antiguo y medieval, Pensamiento moderno, Ideologías contemporáneas, Estado e instituciones, Debates actuales.",
  out_of_scope: "",
  tags: ("filosofia-politica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/political_phylosofy.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
    ),
  style: (
      series: "Series Filosofía ",
      date: "today",
      font_size_pt: 11,
      main_color: "#0f1434",
      secondary_color: "#292c3e",
      tertiary_color: "#0f1434",
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

#part("Fundamentos de filosofía política")

#chapter("Poder, autoridad y legitimidad")

#chapter("Libertad e igualdad")

#chapter("Justicia")

#chapter("Comunidad y ciudadanía")
#part("Pensamiento antiguo y medieval")

#chapter("Platón")

#chapter("Aristóteles")

#chapter("Estoicismo y Roma")

#chapter("Tradición medieval")
#part("Pensamiento moderno")

#chapter("Maquiavelo")

#chapter("Contractualismo")

#chapter("Liberalismo")

#chapter("Republicanismo")
#part("Ideologías contemporáneas")

#chapter("Socialismo y marxismo")

#chapter("Conservadurismo")

#chapter("Anarquismo")

#chapter("Nacionalismo")
#part("Estado e instituciones")

#chapter("Constitución y derecho")

#chapter("Democracia y representación")

#chapter("Burocracia y administración")

#chapter("Gobernanza multinivel")
#part("Debates actuales")

#chapter("Justicia global")

#chapter("Feminismos")

#chapter("Ecología política")

#chapter("Tecnología y poder")

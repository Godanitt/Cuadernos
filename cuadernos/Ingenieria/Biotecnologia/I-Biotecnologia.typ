#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Biotecnologia",
  slug: "ingenieria-biotecnologica",
  title: "Ingeniería Biotecnológica",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Biotecnologia.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Biología molecular para ingeniería, Ingeniería genética y sintética, Bioprocesos, Operaciones de separación, Omicas y biología computacional, Aplicaciones, Calidad y regulación.",
  out_of_scope: "",
  tags: ("ingenieria-biotecnologia",),
  cover: (
      style: "fullimage",
      image: "Imagenes/biotech_2.png",
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

#part("Biología molecular para ingeniería")

#chapter("Genética")

#chapter("Proteínas")

#chapter("Metabolismo")

#chapter("Biología de sistemas")
#part("Ingeniería genética y sintética")

#chapter("Edición genética")

#chapter("Circuitos biológicos")

#chapter("Chasis celulares")

#chapter("Diseño de proteínas")
#part("Bioprocesos")

#chapter("Cinética microbiana")

#chapter("Biorreactores")

#chapter("Fermentación")

#chapter("Escalado")
#part("Operaciones de separación")

#chapter("Ruptura celular")

#chapter("Filtración")

#chapter("Cromatografía")

#chapter("Purificación")
#part("Omicas y biología computacional")

#chapter("Genómica")

#chapter("Transcriptómica")

#chapter("Proteómica")

#chapter("Modelado")
#part("Aplicaciones")

#chapter("Biomedicina")

#chapter("Alimentos")

#chapter("Industria")

#chapter("Medio ambiente")
#part("Calidad y regulación")

#chapter("Bioseguridad")

#chapter("GMP")

#chapter("Regulación")

#chapter("Bioética")

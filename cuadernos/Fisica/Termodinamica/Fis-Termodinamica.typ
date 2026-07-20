#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Termodinamica",
  slug: "termodinamica-y-mecanica-estadistica",
  title: "Termodinámica y Mecánica Estadística",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Termodinamica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos termodinámicos, Potenciales y equilibrio, Mecánica estadística clásica, Estadística cuántica, Transiciones de fase y fenómenos críticos, Procesos irreversibles, Sistemas complejos.",
  out_of_scope: "",
  tags: ("termodinamica-y-mecanica-estadistica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/Thermodynamics.png",
      theme: "dark",
      zoom: 1.1,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
    ),
  style: (
      series: "Series Ciencias Físicas",
      date: "today",
      font_size_pt: 11,
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

#part("Fundamentos termodinámicos")

#chapter("Variables de estado y equilibrio")

#chapter("Primer principio")

#chapter("Segundo principio y entropía")

#chapter("Tercer principio")
#part("Potenciales y equilibrio")

#chapter("Potenciales termodinámicos")

#chapter("Relaciones de Maxwell")

#chapter("Estabilidad y equilibrio de fases")

#chapter("Sistemas abiertos y reacciones")
#part("Mecánica estadística clásica")

#chapter("Espacio de fases y ergodicidad")

#chapter("Ensamble microcanónico")

#chapter("Ensamble canónico")

#chapter("Ensamble gran canónico")
#part("Estadística cuántica")

#chapter("Bosones y fermiones")

#chapter("Gas de Bose")

#chapter("Gas de Fermi")

#chapter("Radiación térmica")
#part("Transiciones de fase y fenómenos críticos")

#chapter("Modelos de Ising y campo medio")

#chapter("Escalado y universalidad")

#chapter("Grupo de renormalización")

#chapter("Sistemas desordenados")
#part("Procesos irreversibles")

#chapter("Transporte y difusión")

#chapter("Relaciones de Onsager")

#chapter("Ecuaciones cinéticas")

#chapter("Termodinámica fuera del equilibrio")
#part("Sistemas complejos")

#chapter("Información y entropía")

#chapter("Redes y emergencia")

#chapter("Autoorganización")

#chapter("Aplicaciones interdisciplinarias")

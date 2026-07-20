#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Mecanica_Clasica",
  slug: "mecanica-clasica",
  title: "Mecánica Clásica",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Mecanica_Clasica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de la mecánica, Mecánica analítica, Mecánica hamiltoniana, Sistemas de muchas partículas y sólidos rígidos, Oscilaciones, ondas y medios continuos, Dinámica no lineal y caos.",
  out_of_scope: "",
  tags: ("mecanica-clasica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/classical_mechanics.png",
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

#part("Fundamentos de la mecánica")

#chapter("Espacio, tiempo y cinemática")

#chapter("Leyes de Newton y sistemas de referencia")

#chapter("Conservación de energía, momento y momento angular")
#part("Mecánica analítica")

#chapter("Principio variacional")

#chapter("Formalismo lagrangiano")

#chapter("Restricciones y coordenadas generalizadas")

#chapter("Simetrías y teorema de Noether")
#part("Mecánica hamiltoniana")

#chapter("Transformaciones canónicas")

#chapter("Ecuaciones de Hamilton")

#chapter("Hamilton-Jacobi")

#chapter("Teoría canónica de perturbaciones")
#part("Sistemas de muchas partículas y sólidos rígidos")

#chapter("Centro de masas y colisiones")

#chapter("Dinámica del sólido rígido")

#chapter("Rotaciones y tensores de inercia")
#part("Oscilaciones, ondas y medios continuos")

#chapter("Pequeñas oscilaciones")

#chapter("Modos normales")

#chapter("Cuerdas, membranas y elasticidad")

#chapter("Acústica")
#part("Dinámica no lineal y caos")

#chapter("Estabilidad y espacio de fases")

#chapter("Bifurcaciones")

#chapter("Caos determinista")

#chapter("Sistemas hamiltonianos no integrables")

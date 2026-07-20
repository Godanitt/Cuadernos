#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Atomica",
  slug: "fisica-atomica-y-molecular",
  title: "Física Atómica y Molecular",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Atomica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Estructura atómica, Interacción radiación-materia, Física molecular, Espectroscopia, Colisiones y materia fría, Aplicaciones y métodos experimentales.",
  out_of_scope: "",
  tags: ("fisica-atomica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/atomic.png",
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

#part("Estructura atómica")

#chapter("Átomo de hidrógeno")

#chapter("Átomos multielectrónicos")

#chapter("Acoplamiento angular")

#chapter("Estructura fina e hiperfina")
#part("Interacción radiación-materia")

#chapter("Transiciones electromagnéticas")

#chapter("Reglas de selección")

#chapter("Átomo de dos niveles")

#chapter("Campos intensos")
#part("Física molecular")

#chapter("Enlace molecular")

#chapter("Rotaciones y vibraciones")

#chapter("Estructura electrónica molecular")

#chapter("Dinámica molecular")
#part("Espectroscopia")

#chapter("Espectroscopia atómica")

#chapter("Espectroscopia molecular")

#chapter("Resonancia magnética")

#chapter("Técnicas ultrarrápidas")
#part("Colisiones y materia fría")

#chapter("Colisiones atómicas")

#chapter("Átomos ultrafríos")

#chapter("Condensados de Bose-Einstein")

#chapter("Moléculas frías")
#part("Aplicaciones y métodos experimentales")

#chapter("Relojes atómicos")

#chapter("Trampas y enfriamiento láser")

#chapter("Metrología espectroscópica")

#chapter("Astrofísica y diagnóstico de plasmas")

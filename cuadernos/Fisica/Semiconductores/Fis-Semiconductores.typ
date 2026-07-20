#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Semiconductores",
  slug: "fisica-de-semiconductores-y-electronica",
  title: "Física de Semiconductores y Electrónica",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Semiconductores.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos de semiconductores, Uniones y contactos, Transistores, Optoelectrónica, Fabricación y caracterización, Nanoelectrónica y dispositivos avanzados.",
  out_of_scope: "",
  tags: ("fisica-de-semiconductores-y-electronica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/electronic_physics.png",
      theme: "dark",
      zoom: 1.1,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "auto",
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

#part("Fundamentos de semiconductores")

#chapter("Bandas y portadores")

#chapter("Estadística de portadores")

#chapter("Dopado")

#chapter("Transporte y recombinación")
#part("Uniones y contactos")

#chapter("Unión p-n")

#chapter("Diodos")

#chapter("Contactos metal-semiconductor")

#chapter("Heterouniones")
#part("Transistores")

#chapter("BJT")

#chapter("MOSFET")

#chapter("Dispositivos de potencia")

#chapter("Dispositivos de alta frecuencia")
#part("Optoelectrónica")

#chapter("LED")

#chapter("Láser semiconductor")

#chapter("Fotodiodos")

#chapter("Células solares")
#part("Fabricación y caracterización")

#chapter("Crecimiento y deposición")

#chapter("Litografía")

#chapter("Implantación y difusión")

#chapter("Metrología de dispositivos")
#part("Nanoelectrónica y dispositivos avanzados")

#chapter("Transporte cuántico")

#chapter("HEMT y FinFET")

#chapter("Memorias")

#chapter("Dispositivos 2D")

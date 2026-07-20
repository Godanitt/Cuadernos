#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Automocion",
  slug: "ingenieria-de-la-automocion",
  title: "Ingeniería de la Automoción",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Automocion.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Arquitectura del vehículo, Propulsión, Dinámica del vehículo, Estructuras y fabricación, Electrónica y control, Seguridad y sostenibilidad.",
  out_of_scope: "",
  tags: ("ingenieria-de-la-automocion",),
  cover: (
      style: "fullimage",
      image: "Imagenes/automotive.png",
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

#part("Arquitectura del vehículo")

#chapter("Sistemas del vehículo")

#chapter("Prestaciones")

#chapter("Ergonomía")

#chapter("Diseño y homologación")
#part("Propulsión")

#chapter("Motores térmicos")

#chapter("Transmisiones")

#chapter("Vehículo eléctrico")

#chapter("Híbridos e hidrógeno")
#part("Dinámica del vehículo")

#chapter("Neumáticos")

#chapter("Suspensión")

#chapter("Dirección")

#chapter("Frenado")
#part("Estructuras y fabricación")

#chapter("Chasis y carrocería")

#chapter("Materiales")

#chapter("Aerodinámica")

#chapter("Producción")
#part("Electrónica y control")

#chapter("Redes embarcadas")

#chapter("Control del tren motriz")

#chapter("ADAS")

#chapter("Vehículo autónomo")
#part("Seguridad y sostenibilidad")

#chapter("Seguridad pasiva y activa")

#chapter("Emisiones")

#chapter("Ciclo de vida")

#chapter("Movilidad conectada")

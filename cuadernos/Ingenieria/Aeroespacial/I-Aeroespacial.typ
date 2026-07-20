#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Aeroespacial",
  slug: "ingenieria-aeroespacial-y-aeronautica",
  title: "Ingeniería Aeroespacial y Aeronáutica",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Aeroespacial.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Aerodinámica, Mecánica de vuelo, Propulsión, Estructuras y materiales, Aviónica y sistemas, Ingeniería espacial, Diseño y certificación.",
  out_of_scope: "",
  tags: ("ingenieria-aeroespacial-y-aeronautica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/aeroespacial_enginering.png",
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

#part("Aerodinámica")

#chapter("Flujo potencial")

#chapter("Perfiles y alas")

#chapter("Flujo compresible")

#chapter("Aerodinámica computacional")
#part("Mecánica de vuelo")

#chapter("Actuaciones")

#chapter("Estabilidad")

#chapter("Control de vuelo")

#chapter("Navegación")
#part("Propulsión")

#chapter("Motores alternativos")

#chapter("Turbinas de gas")

#chapter("Cohetes")

#chapter("Propulsión eléctrica")
#part("Estructuras y materiales")

#chapter("Estructuras aeronáuticas")

#chapter("Materiales compuestos")

#chapter("Fatiga")

#chapter("Aeroelasticidad")
#part("Aviónica y sistemas")

#chapter("Sensores")

#chapter("Comunicaciones")

#chapter("Sistemas embarcados")

#chapter("Fiabilidad")
#part("Ingeniería espacial")

#chapter("Mecánica orbital")

#chapter("Vehículos espaciales")

#chapter("Sistemas de misión")

#chapter("Operaciones")
#part("Diseño y certificación")

#chapter("Diseño conceptual")

#chapter("Optimización multidisciplinar")

#chapter("Seguridad")

#chapter("Certificación")

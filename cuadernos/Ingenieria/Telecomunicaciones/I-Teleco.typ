#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Teleco",
  slug: "ingenieria-de-telecomunicaciones",
  title: "Ingeniería de Teleco",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Teleco.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Señales y sistemas, Comunicaciones analógicas y digitales, Información y codificación, Radiofrecuencia y microondas, Antenas y propagación, Comunicaciones ópticas, Redes y sistemas modernos.",
  out_of_scope: "",
  tags: ("ingenieria-de-teleco",),
  cover: (
      style: "fullimage",
      image: "Imagenes/teleco.png",
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

#part("Señales y sistemas")

#chapter("Señales continuas y discretas")

#chapter("Fourier y muestreo")

#chapter("Filtrado")

#chapter("Procesado digital")
#part("Comunicaciones analógicas y digitales")

#chapter("Modulación analógica")

#chapter("Modulación digital")

#chapter("Detección")

#chapter("Sincronización")
#part("Información y codificación")

#chapter("Teoría de la información")

#chapter("Códigos de canal")

#chapter("Compresión")

#chapter("Criptografía aplicada")
#part("Radiofrecuencia y microondas")

#chapter("Líneas de transmisión")

#chapter("Circuitos RF")

#chapter("Microondas")

#chapter("Medidas")
#part("Antenas y propagación")

#chapter("Antenas")

#chapter("Propagación terrestre")

#chapter("Canales móviles")

#chapter("Radar")
#part("Comunicaciones ópticas")

#chapter("Fibras")

#chapter("Transmisores y receptores")

#chapter("Redes ópticas")

#chapter("Fotónica integrada")
#part("Redes y sistemas modernos")

#chapter("Internet")

#chapter("Redes móviles")

#chapter("5G y 6G")

#chapter("Comunicaciones satelitales")

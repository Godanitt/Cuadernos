#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Optica",
  slug: "optica",
  title: "Óptica",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Optica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 7 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Óptica geométrica, Óptica ondulatoria, Coherencia y Fourier, Instrumentación óptica, Óptica de medios, Óptica no lineal, Óptica cuántica.",
  out_of_scope: "",
  tags: ("optica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/optic.png",
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

#part("Óptica geométrica")

#chapter("Rayos y principio de Fermat")

#chapter("Lentes y espejos")

#chapter("Sistemas ópticos")

#chapter("Aberraciones")
#part("Óptica ondulatoria")

#chapter("Ecuación de onda")

#chapter("Interferencia")

#chapter("Difracción")

#chapter("Polarización")
#part("Coherencia y Fourier")

#chapter("Coherencia temporal y espacial")

#chapter("Óptica de Fourier")

#chapter("Formación de imagen")

#chapter("Filtrado espacial")
#part("Instrumentación óptica")

#chapter("Microscopía")

#chapter("Telescopios")

#chapter("Cámaras y detectores")

#chapter("Espectrómetros")
#part("Óptica de medios")

#chapter("Dispersión")

#chapter("Cristales anisótropos")

#chapter("Óptica guiada")

#chapter("Fibras ópticas")
#part("Óptica no lineal")

#chapter("Susceptibilidades no lineales")

#chapter("Generación armónica")

#chapter("Mezcla de frecuencias")

#chapter("Solitones")
#part("Óptica cuántica")

#chapter("Estados de luz")

#chapter("Fotodetección")

#chapter("Entrelazamiento")

#chapter("Interferometría cuántica")

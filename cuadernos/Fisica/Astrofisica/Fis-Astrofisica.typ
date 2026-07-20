#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "Fis-Astrofisica",
  slug: "astrofisica-y-cosmologia",
  title: "Astrofísica y Cosmología",
  subtitle: "",
  area: "Fisica",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "Fis-Astrofisica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: true,
  summary: "Cuaderno organizado en 3 partes y 3 capítulos activos.",
  scope: "Incluye Astrofísica Nuclear, Nucleosíntesis Estelar y Primordial, Cosmología.",
  out_of_scope: "",
  tags: ("astrofisica-y-cosmologia",),
  cover: (
      style: "fullimage",
      image: "Imagenes/astro_generated.png",
      theme: "dark",
      zoom: 1.18,
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
      text: 2,
      figures: 10,
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

#let H1 = $"H"$
#let H2 = $""^2"H"$
#let He3 = $""^3"He"$
#let He4 = $""^4"He"$
#let Li7 = $""^7"Li"$

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.5em,
)

#part("Astrofísica Nuclear")

#chapter("Introducción")
#part("Nucleosíntesis Estelar y Primordial")

#chapter("Introducción")

// #chapter("Mecánica y Equilibrio Térmico")

// #chapter("Ecuaciones de Estado Nuclear")

#chapter("Nucleosíntesis en el Big Bang")

Después del confinamiento de los quarks y de la transición a los hadrones, el universo temprano hecho de hadrones, leptones y fotones, con una pequeña asimetría materia-antimateria.

En los primeros modelos del Big-Bang, algunos elementos podían sintetizarse, al menos en el tiempo en el que la temperatura y densidad eran apropiadas para que ocurrieran las reacciones nucleares. En estas condiciones los modelos predicen la creación de las primeras especies ligeras como #H2, #He3, #He4 y #Li7, y se predijo la observación del fondo cósmico de microondas. Podemos obersvar diferentes procesos en función que trascurrió desde el Big-Bang

- A $t=0.5" s"$ y $T_9 ~ 15$ la expansión 

// #chapter("Modelos Politrópicos Estelares")

// #chapter("Transporte de Energía en el Interior Estelar")

// #chapter("Procesos Nucleares en Estrellas")

// #chapter("Modelos Estelares y Estabilidad Estelar")

// #chapter("Evolución Estelar y Teorema del Virial")

// #chapter("Primeras fases de evolución estelar")

// #chapter("Evolución no-secuencia principal: quemado de helio")

// #chapter("Evolución tardía de estrellas pequeñas y medianas")

// #chapter("Evoulción de estrellas masivas: presupernova")

// #chapter("Evoulción de estrellas masivas: supernovas y remanentes")
#part("Cosmología")

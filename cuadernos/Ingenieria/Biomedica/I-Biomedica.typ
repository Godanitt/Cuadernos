#import "../../../plantilla/plantilla.typ": *

// <cuadernos:metadata>
#let notebook = (
  id: "I-Biomedica",
  slug: "ingenieria-biomedica",
  title: "Ingeniería Biomédica",
  subtitle: "",
  area: "Ingenieria",
  status: "skeleton",
  language: "es",
  authors: ("Daniel Vázquez Lago",),
  output: "I-Biomedica.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  summary: "Esquema editorial organizado en 6 partes; el desarrollo del texto está en fase inicial.",
  scope: "Incluye Fundamentos biomédicos, Instrumentación biomédica, Señales e imágenes médicas, Dispositivos y prótesis, Ingeniería clínica, Regulación y diseño.",
  out_of_scope: "",
  tags: ("ingenieria-biomedica",),
  cover: (
      style: "fullimage",
      image: "Imagenes/biomedical.png",
      theme: "dark",
      zoom: 1.0,
      dx_cm: 0.0,
      dy_cm: 0.0,
      text_color: "black",
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

#part("Fundamentos biomédicos")

#chapter("Anatomía y fisiología")

#chapter("Bioelectricidad")

#chapter("Biomecánica")

#chapter("Biomateriales")
#part("Instrumentación biomédica")

#chapter("Electrodos y sensores")

#chapter("Acondicionamiento")

#chapter("Seguridad eléctrica")

#chapter("Monitorización")
#part("Señales e imágenes médicas")

#chapter("ECG, EEG y EMG")

#chapter("Ultrasonidos")

#chapter("Tomografía")

#chapter("Resonancia magnética")
#part("Dispositivos y prótesis")

#chapter("Prótesis")

#chapter("Implantes")

#chapter("Órganos artificiales")

#chapter("Rehabilitación")
#part("Ingeniería clínica")

#chapter("Gestión tecnológica")

#chapter("Mantenimiento")

#chapter("Interoperabilidad")

#chapter("Hospital digital")
#part("Regulación y diseño")

#chapter("Diseño centrado en el paciente")

#chapter("Validación")

#chapter("Regulación")

#chapter("Ética")

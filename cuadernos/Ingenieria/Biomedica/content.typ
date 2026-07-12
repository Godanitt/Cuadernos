// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos biomédicos")

#chapter("Anatomía y fisiología")

#chapter("Bioelectricidad")

#chapter("Biomecánica")

#chapter("Biomateriales")

#part-reading-list("fundamentos-biomedicos")

#part("Instrumentación biomédica")

#chapter("Electrodos y sensores")

#chapter("Acondicionamiento")

#chapter("Seguridad eléctrica")

#chapter("Monitorización")

#part-reading-list("instrumentacion-biomedica")

#part("Señales e imágenes médicas")

#chapter("ECG, EEG y EMG")

#chapter("Ultrasonidos")

#chapter("Tomografía")

#chapter("Resonancia magnética")

#part-reading-list("senales-e-imagenes-medicas")

#part("Dispositivos y prótesis")

#chapter("Prótesis")

#chapter("Implantes")

#chapter("Órganos artificiales")

#chapter("Rehabilitación")

#part-reading-list("dispositivos-y-protesis")

#part("Ingeniería clínica")

#chapter("Gestión tecnológica")

#chapter("Mantenimiento")

#chapter("Interoperabilidad")

#chapter("Hospital digital")

#part-reading-list("ingenieria-clinica")

#part("Regulación y diseño")

#chapter("Diseño centrado en el paciente")

#chapter("Validación")

#chapter("Regulación")

#chapter("Ética")

#part-reading-list("regulacion-y-diseno")

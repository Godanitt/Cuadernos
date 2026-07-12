// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Mecánica y materiales")

#chapter("Estática")

#chapter("Dinámica")

#chapter("Resistencia de materiales")

#chapter("Selección de materiales")

#part-reading-list("mecanica-y-materiales")

#part("Diseño mecánico")

#chapter("Elementos de máquinas")

#chapter("Fatiga")

#chapter("Tribología")

#chapter("Diseño asistido por ordenador")

#part-reading-list("diseno-mecanico")

#part("Máquinas y vibraciones")

#chapter("Mecanismos")

#chapter("Dinámica de máquinas")

#chapter("Vibraciones")

#chapter("Mantenimiento")

#part-reading-list("maquinas-y-vibraciones")

#part("Sistemas térmicos y fluidos")

#chapter("Termodinámica aplicada")

#chapter("Transferencia de calor")

#chapter("Mecánica de fluidos")

#chapter("Máquinas térmicas")

#part-reading-list("sistemas-termicos-y-fluidos")

#part("Fabricación")

#chapter("Procesos de mecanizado")

#chapter("Conformado")

#chapter("Fabricación aditiva")

#chapter("Metrología y calidad")

#part-reading-list("fabricacion")

#part("Mecatrónica y control")

#chapter("Actuadores")

#chapter("Sensores")

#chapter("Control")

#chapter("Robótica")

#part-reading-list("mecatronica-y-control")

#part("Fiabilidad y proyecto")

#chapter("Fiabilidad")

#chapter("Seguridad")

#chapter("Gestión del ciclo de vida")

#chapter("Proyecto mecánico")

#part-reading-list("fiabilidad-y-proyecto")

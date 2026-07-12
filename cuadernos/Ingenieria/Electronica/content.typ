// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Dispositivos electrónicos")

#chapter("Semiconductores")

#chapter("Diodos")

#chapter("Transistores")

#chapter("Tecnologías integradas")

#part-reading-list("dispositivos-electronicos")

#part("Electrónica analógica")

#chapter("Amplificadores")

#chapter("Realimentación")

#chapter("Filtros")

#chapter("Conversión de datos")

#part-reading-list("electronica-analogica")

#part("Electrónica digital")

#chapter("Lógica combinacional")

#chapter("Lógica secuencial")

#chapter("Arquitecturas digitales")

#chapter("FPGA")

#part-reading-list("electronica-digital")

#part("Sistemas embebidos")

#chapter("Microcontroladores")

#chapter("Interfaces")

#chapter("Tiempo real")

#chapter("Sistemas operativos embebidos")

#part-reading-list("sistemas-embebidos")

#part("Electrónica de potencia")

#chapter("Convertidores")

#chapter("Control de potencia")

#chapter("Fuentes")

#chapter("Gestión térmica")

#part-reading-list("electronica-de-potencia")

#part("Diseño y fabricación")

#chapter("PCB")

#chapter("Compatibilidad electromagnética")

#chapter("Verificación")

#chapter("Test y fiabilidad")

#part-reading-list("diseno-y-fabricacion")

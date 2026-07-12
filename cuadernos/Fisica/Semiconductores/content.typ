// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos de semiconductores")

#chapter("Bandas y portadores")

#chapter("Estadística de portadores")

#chapter("Dopado")

#chapter("Transporte y recombinación")

#part-reading-list("fundamentos-de-semiconductores")

#part("Uniones y contactos")

#chapter("Unión p-n")

#chapter("Diodos")

#chapter("Contactos metal-semiconductor")

#chapter("Heterouniones")

#part-reading-list("uniones-y-contactos")

#part("Transistores")

#chapter("BJT")

#chapter("MOSFET")

#chapter("Dispositivos de potencia")

#chapter("Dispositivos de alta frecuencia")

#part-reading-list("transistores")

#part("Optoelectrónica")

#chapter("LED")

#chapter("Láser semiconductor")

#chapter("Fotodiodos")

#chapter("Células solares")

#part-reading-list("optoelectronica")

#part("Fabricación y caracterización")

#chapter("Crecimiento y deposición")

#chapter("Litografía")

#chapter("Implantación y difusión")

#chapter("Metrología de dispositivos")

#part-reading-list("fabricacion-y-caracterizacion")

#part("Nanoelectrónica y dispositivos avanzados")

#chapter("Transporte cuántico")

#chapter("HEMT y FinFET")

#chapter("Memorias")

#chapter("Dispositivos 2D")

#part-reading-list("nanoelectronica-y-dispositivos-avanzados")

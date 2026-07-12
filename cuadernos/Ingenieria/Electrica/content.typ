// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Circuitos y electromagnetismo")

#chapter("Circuitos eléctricos")

#chapter("Sistemas trifásicos")

#chapter("Campos electromagnéticos")

#chapter("Medidas eléctricas")

#part-reading-list("circuitos-y-electromagnetismo")

#part("Máquinas eléctricas")

#chapter("Transformadores")

#chapter("Máquinas de corriente continua")

#chapter("Máquinas síncronas")

#chapter("Máquinas de inducción")

#part-reading-list("maquinas-electricas")

#part("Electrónica de potencia")

#chapter("Rectificadores")

#chapter("Convertidores")

#chapter("Inversores")

#chapter("Accionamientos")

#part-reading-list("electronica-de-potencia")

#part("Generación y redes")

#chapter("Generación convencional")

#chapter("Renovables")

#chapter("Flujo de carga")

#chapter("Estabilidad")

#part-reading-list("generacion-y-redes")

#part("Alta tensión y protecciones")

#chapter("Aislamiento")

#chapter("Sobretensiones")

#chapter("Protecciones")

#chapter("Puesta a tierra")

#part-reading-list("alta-tension-y-protecciones")

#part("Sistemas eléctricos modernos")

#chapter("Redes inteligentes")

#chapter("Almacenamiento")

#chapter("Microredes")

#chapter("Movilidad eléctrica")

#part-reading-list("sistemas-electricos-modernos")

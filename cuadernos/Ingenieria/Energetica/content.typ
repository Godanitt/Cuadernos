// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos energéticos")

#chapter("Balances y exergía")

#chapter("Conversión de energía")

#chapter("Recursos")

#chapter("Demanda")

#part-reading-list("fundamentos-energeticos")

#part("Sistemas térmicos")

#chapter("Ciclos de potencia")

#chapter("Turbinas")

#chapter("Cogeneración")

#chapter("Refrigeración")

#part-reading-list("sistemas-termicos")

#part("Energías renovables")

#chapter("Solar")

#chapter("Eólica")

#chapter("Hidráulica")

#chapter("Bioenergía")

#part-reading-list("energias-renovables")

#part("Almacenamiento e hidrógeno")

#chapter("Baterías")

#chapter("Almacenamiento térmico")

#chapter("Hidrógeno")

#chapter("Power-to-X")

#part-reading-list("almacenamiento-e-hidrogeno")

#part("Sistemas eléctricos y redes")

#chapter("Integración renovable")

#chapter("Redes")

#chapter("Mercados")

#chapter("Flexibilidad")

#part-reading-list("sistemas-electricos-y-redes")

#part("Energía nuclear")

#chapter("Reactores")

#chapter("Ciclo del combustible")

#chapter("Seguridad")

#chapter("Fusión")

#part-reading-list("energia-nuclear")

#part("Eficiencia y ambiente")

#chapter("Eficiencia industrial")

#chapter("Edificios")

#chapter("Emisiones")

#chapter("Análisis de ciclo de vida")

#part-reading-list("eficiencia-y-ambiente")

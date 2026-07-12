// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Propiedades del núcleo")

#chapter("Masas y energías de enlace")

#chapter("Radios y distribuciones")

#chapter("Spin, paridad y momentos")

#chapter("Fuerzas nucleares")

#part-reading-list("propiedades-del-nucleo")

#part("Modelos nucleares")

#chapter("Modelo de gota líquida")

#chapter("Modelo de capas")

#chapter("Modelos colectivos")

#chapter("Estructura de núcleos exóticos")

#part-reading-list("modelos-nucleares")

#part("Desintegraciones radiactivas")

#chapter("Desintegración alfa")

#chapter("Desintegración beta")

#chapter("Emisión gamma")

#chapter("Cadenas y equilibrio radiactivo")

#part-reading-list("desintegraciones-radiactivas")

#part("Reacciones nucleares")

#chapter("Cinemática y secciones eficaces")

#chapter("Modelo óptico")

#chapter("Reacciones directas")

#chapter("Núcleo compuesto")

#part-reading-list("reacciones-nucleares")

#part("Fisión y fusión")

#chapter("Fisión nuclear")

#chapter("Reactores")

#chapter("Fusión termonuclear")

#chapter("Confinamiento y combustibles")

#part-reading-list("fision-y-fusion")

#part("Astrofísica nuclear")

#chapter("Nucleosíntesis estelar")

#chapter("Procesos r, s y rp")

#chapter("Supernovas")

#chapter("Materia nuclear densa")

#part-reading-list("astrofisica-nuclear")

#part("Aplicaciones")

#chapter("Medicina nuclear")

#chapter("Datación y análisis")

#chapter("Energía nuclear")

#chapter("Seguridad y protección radiológica")

#part-reading-list("aplicaciones")

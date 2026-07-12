// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Interacción luz-materia")

#chapter("Emisión espontánea y estimulada")

#chapter("Inversión de población")

#chapter("Ensanchamiento de líneas")

#chapter("Ecuaciones de tasa")

#part-reading-list("interaccion-luz-materia")

#part("Resonadores ópticos")

#chapter("Modos de cavidad")

#chapter("Estabilidad")

#chapter("Pérdidas y calidad")

#chapter("Selección modal")

#part-reading-list("resonadores-opticos")

#part("Dinámica del láser")

#chapter("Umbral y ganancia")

#chapter("Ecuaciones de Maxwell-Bloch")

#chapter("Estabilidad y ruido")

#chapter("Bloqueo de modos")

#part-reading-list("dinamica-del-laser")

#part("Tipos de láser")

#chapter("Láseres de gas")

#chapter("Láseres de estado sólido")

#chapter("Láseres semiconductores")

#chapter("Láseres de fibra")

#part-reading-list("tipos-de-laser")

#part("Pulsos ultracortos")

#chapter("Generación de pulsos")

#chapter("Dispersión y chirp")

#chapter("Amplificación CPA")

#chapter("Peines de frecuencia")

#part-reading-list("pulsos-ultracortos")

#part("Aplicaciones")

#chapter("Procesado de materiales")

#chapter("Medicina")

#chapter("Metrología")

#chapter("Comunicaciones y sensores")

#part-reading-list("aplicaciones")

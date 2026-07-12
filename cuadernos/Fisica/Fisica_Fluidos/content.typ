// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos de medios continuos")

#chapter("Cinemática de fluidos")

#chapter("Conservación de masa")

#chapter("Conservación de momento")

#chapter("Conservación de energía")

#part-reading-list("fundamentos-de-medios-continuos")

#part("Fluidos ideales")

#chapter("Ecuaciones de Euler")

#chapter("Bernoulli")

#chapter("Flujo potencial")

#chapter("Vorticidad")

#part-reading-list("fluidos-ideales")

#part("Fluidos viscosos")

#chapter("Navier-Stokes")

#chapter("Flujo de Poiseuille")

#chapter("Número de Reynolds")

#chapter("Disipación")

#part-reading-list("fluidos-viscosos")

#part("Capas límite y aerodinámica")

#chapter("Teoría de capa límite")

#chapter("Separación")

#chapter("Sustentación y resistencia")

#chapter("Flujo alrededor de cuerpos")

#part-reading-list("capas-limite-y-aerodinamica")

#part("Turbulencia")

#chapter("Transición")

#chapter("Cascada de energía")

#chapter("Modelos estadísticos")

#chapter("Simulación de turbulencia")

#part-reading-list("turbulencia")

#part("Flujos compresibles")

#chapter("Ondas de choque")

#chapter("Flujo supersónico")

#chapter("Toberas")

#chapter("Combustión")

#part-reading-list("flujos-compresibles")

#part("Fluidos multifásicos y geofísicos")

#chapter("Tensión superficial")

#chapter("Burbujas y gotas")

#chapter("Fluidos estratificados")

#chapter("Atmósfera y océanos")

#part-reading-list("fluidos-multifasicos-y-geofisicos")

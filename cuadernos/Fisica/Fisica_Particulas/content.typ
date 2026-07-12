// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos y simetrías")

#chapter("Partículas relativistas")

#chapter("Grupos de Lorentz y Poincaré")

#chapter("Simetrías internas")

#chapter("Teorema de Noether")

#part-reading-list("fundamentos-y-simetrias")

#part("Mecánica cuántica relativista")

#chapter("Ecuación de Klein-Gordon")

#chapter("Ecuación de Dirac")

#chapter("Espinores y antipartículas")

#chapter("Campos libres")

#part-reading-list("mecanica-cuantica-relativista")

#part("Campos clásicos")

#chapter("Campos escalares")

#chapter("Campos fermiónicos")

#chapter("Campos gauge")

#chapter("Ruptura espontánea de simetría")

#part-reading-list("campos-clasicos")

#part("Teoría cuántica de campos")

#chapter("Cuantización canónica")

#chapter("Integral de camino")

#chapter("Diagramas de Feynman")

#chapter("Renormalización")

#part-reading-list("teoria-cuantica-de-campos")

#part("Teorías gauge y modelo estándar")

#chapter("Electrodinámica cuántica")

#chapter("Interacción electrodébil")

#chapter("Cromodinámica cuántica")

#chapter("Mecanismo de Higgs")

#part-reading-list("teorias-gauge-y-modelo-estandar")

#part("Fenomenología de partículas")

#chapter("Desintegraciones y dispersión")

#chapter("Quarks y hadrones")

#chapter("Neutrinos")

#chapter("Física de sabor")

#part-reading-list("fenomenologia-de-particulas")

#part("Más allá del modelo estándar")

#chapter("Supersimetría y dimensiones extra")

#chapter("Materia oscura")

#chapter("Gran unificación")

#chapter("Física de neutrinos avanzada")

#part-reading-list("mas-alla-del-modelo-estandar")

#part("Astropartículas y cosmología de partículas")

#chapter("Universo temprano")

#chapter("Bariogénesis")

#chapter("Rayos cósmicos")

#chapter("Ondas gravitacionales y partículas")

#part-reading-list("astroparticulas-y-cosmologia-de-particulas")

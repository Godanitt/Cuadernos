// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#chapter("Análisis Vectorial")

#part("Electrostática")
#chapter("Electrostática")
#chapter("Condiciones de frontera en Electrostática")
#chapter("Campos eléctricos en medios materiales")

#part("Magnetostática")
#chapter("Magnetostática")
#chapter("Campos magnéticos en medios materiales")
#chapter("Materiaels Magnéticos")

#part("Electrodinámica")

#chapter("Electrodinámica")
#chapter("Leyes de Conervación")
#chapter("Ondas electromagnéticas")
#chapter("Guidas de Ondas")
#chapter("Relatividad especial")
#chapter("Electrodinámica Relativista")

#part("Radiación")

#chapter("Sistemas Radiantes: multipolos")
#chapter("Radiación de Partículas en Movimiento")
#chapter("Colisiones entre partículas y pérdidas de energía")

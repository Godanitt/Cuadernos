// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

//==================================================//

#part("Introducción y Grupos Discretos")

#chapter("Introducción a la Teoría de Grupos")
#include "Capitulos/Introduccion.typ"
#pagebreak()
#include "Ejercicios/Introduccion.typ"

#chapter("Homomorfismos y Reducibilidad")
#include "Capitulos/Homomorfismos.typ"
#pagebreak()
#include "Ejercicios/Homomorfismos.typ"

#chapter("Grupos finitos")
#include "Capitulos/GruposFinitos.typ"
#pagebreak()
#include "Ejercicios/GruposFinitos.typ"


//===============================================//

#part("Grupos Continuos")
#chapter("Grupos de Lie")
#include "Capitulos/GruposLie.typ"
#pagebreak()
#include "Ejercicios/GruposLie.typ"



//==============================================//

#part("Teoría de Grupos aplicada a la física")

#chapter("Rotaciones")
== Grupo $O(3)$
== Grupo $ S U (2)$

#chapter("Ecuacón de Dirac")


== Hamiton, Clifford y Dirac
== Álgebra de Dirac


#chapter("Campos de Yang-Milles")

== Teorema de Noeteher para Simetrías Internas
== El Nucleón de Yangs-Milles

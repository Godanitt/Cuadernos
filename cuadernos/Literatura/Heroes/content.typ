// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("El héroe mítico")

#chapter("Arquetipos")

#chapter("Viaje del héroe")

#chapter("Mito y ritual")

#chapter("Héroes trágicos")

#part-reading-list("el-heroe-mitico")

#part("Épica antigua")

#chapter("Gilgamesh")

#chapter("Homero")

#chapter("Virgilio")

#chapter("Épicas comparadas")

#part-reading-list("epica-antigua")

#part("Héroe medieval")

#chapter("Cantar de gesta")

#chapter("Caballería")

#chapter("Héroes religiosos")

#chapter("Materia artúrica")

#part-reading-list("heroe-medieval")

#part("Modernidad y novela")

#chapter("Héroe renacentista")

#chapter("Individuo moderno")

#chapter("Héroe romántico")

#chapter("Realismo")

#part-reading-list("modernidad-y-novela")

#part("Antihéroe y crisis del sujeto")

#chapter("Picaresca")

#chapter("Héroe absurdo")

#chapter("Modernismo")

#chapter("Distopía")

#part-reading-list("antiheroe-y-crisis-del-sujeto")

#part("Héroes contemporáneos")

#chapter("Cómic y superhéroe")

#chapter("Cine y televisión")

#chapter("Fantasía y ciencia ficción")

#chapter("Relecturas poscoloniales y feministas")

#part-reading-list("heroes-contemporaneos")

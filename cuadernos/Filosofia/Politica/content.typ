// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos de filosofía política")

#chapter("Poder, autoridad y legitimidad")

#chapter("Libertad e igualdad")

#chapter("Justicia")

#chapter("Comunidad y ciudadanía")

#part-reading-list("fundamentos-de-filosofia-politica")

#part("Pensamiento antiguo y medieval")

#chapter("Platón")

#chapter("Aristóteles")

#chapter("Estoicismo y Roma")

#chapter("Tradición medieval")

#part-reading-list("pensamiento-antiguo-y-medieval")

#part("Pensamiento moderno")

#chapter("Maquiavelo")

#chapter("Contractualismo")

#chapter("Liberalismo")

#chapter("Republicanismo")

#part-reading-list("pensamiento-moderno")

#part("Ideologías contemporáneas")

#chapter("Socialismo y marxismo")

#chapter("Conservadurismo")

#chapter("Anarquismo")

#chapter("Nacionalismo")

#part-reading-list("ideologias-contemporaneas")

#part("Estado e instituciones")

#chapter("Constitución y derecho")

#chapter("Democracia y representación")

#chapter("Burocracia y administración")

#chapter("Gobernanza multinivel")

#part-reading-list("estado-e-instituciones")

#part("Debates actuales")

#chapter("Justicia global")

#chapter("Feminismos")

#chapter("Ecología política")

#chapter("Tecnología y poder")

#part-reading-list("debates-actuales")

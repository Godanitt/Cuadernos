// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos")

#chapter("Planificación económica")

#chapter("Cibernética")

#chapter("Comunismo y cálculo")

#chapter("Información y coordinación")

#part-reading-list("fundamentos")

#part("Historia y antecedentes")

#chapter("Debate del cálculo socialista")

#chapter("Proyecto Cybersyn")

#chapter("Planificación computacional")

#chapter("Economía digital")

#part-reading-list("historia-y-antecedentes")

#part("Infraestructura técnica")

#chapter("Datos y contabilidad")

#chapter("Optimización")

#chapter("Simulación")

#chapter("Sistemas distribuidos")

#part-reading-list("infraestructura-tecnica")

#part("Instituciones y gobernanza")

#chapter("Participación")

#chapter("Control democrático")

#chapter("Niveles de planificación")

#chapter("Auditoría")

#part-reading-list("instituciones-y-gobernanza")

#part("Economía política")

#chapter("Propiedad")

#chapter("Asignación y precios")

#chapter("Trabajo y automatización")

#chapter("Innovación")

#part-reading-list("economia-politica")

#part("Derechos y riesgos")

#chapter("Privacidad")

#chapter("Seguridad")

#chapter("Concentración de poder")

#chapter("Sesgos y transparencia")

#part-reading-list("derechos-y-riesgos")

#part("Transición y evaluación")

#chapter("Prototipos")

#chapter("Escalado")

#chapter("Indicadores")

#chapter("Críticas y alternativas")

#part-reading-list("transicion-y-evaluacion")

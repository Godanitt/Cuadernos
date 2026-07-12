// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#part("Fundamentos y balances")

#chapter("La ingeniería química y los procesos químicos")
#include "Capitulos/Introduccion.typ"

#chapter("Principios de conservación: balances de materia")
#include "Capitulos/BalancesMateria.typ"

#chapter("Principios de conservación: balances de energía")
#include "Capitulos/BalanceEnergia.typ"

#part-reading-list("fundamentos-y-balances")

#part("Fenómenos de transporte")

#chapter("Flujo de fluidos")
#include "Capitulos/TrasferenciaFluidos.typ"

#chapter("Transferencia de calor")
#include "Capitulos/Trasferencia_Calor.typ"

#part-reading-list("fenomenos-de-transporte")

#part("Operaciones de separación")

#chapter("Procesos de separación")
#include "Capitulos/Procesos_Separacion.typ"

#part-reading-list("operaciones-de-separacion")

#part("Diseño, control y seguridad de procesos")

#part-reading-list("diseno-control-y-seguridad-de-procesos")

#nocite(<calleja2008>)
#nocite(<himmelblau2002>)

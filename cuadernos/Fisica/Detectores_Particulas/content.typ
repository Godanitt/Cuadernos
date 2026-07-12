// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#part("Interacción radiación–materia")
#chapter("")

#part("Electrónica")
#chapter("")

#part("Estadística")
#chapter("")

#part("Aceleradores")
#chapter("Sincrotrón")
#include "Capitulos/Sincrotron.typ"

#part("Detectores")

#chapter("Indentificación de Partículas")

#chapter("Detectores Gaseosos")

#chapter("Detectores de Fotones")

#chapter("Detectores Centelleadores")

#chapter("Detectores Semiconductores")

#chapter("Detectores Cherenkov")

#chapter("Espectrómetros de muones")

#chapter("Calorímetros")
#include "Capitulos/Calorimetros.typ"

#chapter("Detectores de Estado Sólido")

#part("Simulación en física de detectores")
#chapter("")

#part("Aplicaciones")

#chapter("Detectores en Grandes Experimentos")
#include "Capitulos/DetectoresGrandesExp.typ"

#chapter("")

// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Geología y exploración")

#chapter("Mineralogía")

#chapter("Yacimientos")

#chapter("Prospección")

#chapter("Estimación de recursos")

#part-reading-list("geologia-y-exploracion")

#part("Explotación minera")

#chapter("Minería a cielo abierto")

#chapter("Minería subterránea")

#chapter("Perforación y voladura")

#chapter("Planificación")

#part-reading-list("explotacion-minera")

#part("Mecánica de rocas")

#chapter("Caracterización")

#chapter("Estabilidad")

#chapter("Sostenimiento")

#chapter("Geotecnia")

#part-reading-list("mecanica-de-rocas")

#part("Ventilación y servicios")

#chapter("Ventilación")

#chapter("Drenaje")

#chapter("Transporte")

#chapter("Energía y comunicaciones")

#part-reading-list("ventilacion-y-servicios")

#part("Procesamiento de minerales")

#chapter("Conminución")

#chapter("Concentración")

#chapter("Hidrometalurgia")

#chapter("Pirometalurgia")

#part-reading-list("procesamiento-de-minerales")

#part("Seguridad y medio ambiente")

#chapter("Riesgos")

#chapter("Residuos")

#chapter("Restauración")

#chapter("Agua y emisiones")

#part-reading-list("seguridad-y-medio-ambiente")

#part("Economía y gestión")

#chapter("Evaluación de proyectos")

#chapter("Costes")

#chapter("Legislación")

#chapter("Cierre de mina")

#part-reading-list("economia-y-gestion")

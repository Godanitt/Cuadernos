// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Arquitectura del vehículo")

#chapter("Sistemas del vehículo")

#chapter("Prestaciones")

#chapter("Ergonomía")

#chapter("Diseño y homologación")

#part-reading-list("arquitectura-del-vehiculo")

#part("Propulsión")

#chapter("Motores térmicos")

#chapter("Transmisiones")

#chapter("Vehículo eléctrico")

#chapter("Híbridos e hidrógeno")

#part-reading-list("propulsion")

#part("Dinámica del vehículo")

#chapter("Neumáticos")

#chapter("Suspensión")

#chapter("Dirección")

#chapter("Frenado")

#part-reading-list("dinamica-del-vehiculo")

#part("Estructuras y fabricación")

#chapter("Chasis y carrocería")

#chapter("Materiales")

#chapter("Aerodinámica")

#chapter("Producción")

#part-reading-list("estructuras-y-fabricacion")

#part("Electrónica y control")

#chapter("Redes embarcadas")

#chapter("Control del tren motriz")

#chapter("ADAS")

#chapter("Vehículo autónomo")

#part-reading-list("electronica-y-control")

#part("Seguridad y sostenibilidad")

#chapter("Seguridad pasiva y activa")

#chapter("Emisiones")

#chapter("Ciclo de vida")

#chapter("Movilidad conectada")

#part-reading-list("seguridad-y-sostenibilidad")

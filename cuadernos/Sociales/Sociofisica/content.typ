// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos de sociofísica")

#chapter("Modelización social")

#chapter("Regularidades estadísticas")

#chapter("Micro-macro")

#chapter("Límites epistemológicos")

#part-reading-list("fundamentos-de-sociofisica")

#part("Redes sociales")

#chapter("Estructura de redes")

#chapter("Comunidades")

#chapter("Difusión")

#chapter("Centralidad e influencia")

#part-reading-list("redes-sociales")

#part("Opinión y polarización")

#chapter("Consenso")

#chapter("Modelos de confianza acotada")

#chapter("Cámaras de eco")

#chapter("Desinformación")

#part-reading-list("opinion-y-polarizacion")

#part("Cooperación y conflicto")

#chapter("Juegos evolutivos")

#chapter("Normas sociales")

#chapter("Segregación")

#chapter("Movimientos colectivos")

#part-reading-list("cooperacion-y-conflicto")

#part("Ciudades, movilidad y población")

#chapter("Escalado urbano")

#chapter("Movilidad humana")

#chapter("Migraciones")

#chapter("Demografía")

#part-reading-list("ciudades-movilidad-y-poblacion")

#part("Métodos computacionales")

#chapter("Modelos basados en agentes")

#chapter("Inferencia causal")

#chapter("Datos masivos")

#chapter("Ética y privacidad")

#part-reading-list("metodos-computacionales")

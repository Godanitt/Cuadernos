// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos del paniberismo")

#chapter("Conceptos y alcance")

#chapter("Iberismo e hispanidad")

#chapter("Lusofonía")

#chapter("Paniberismo contemporáneo")

#part-reading-list("fundamentos-del-paniberismo")

#part("Historia compartida")

#chapter("Península Ibérica")

#chapter("Expansión ultramarina")

#chapter("Independencias")

#chapter("Cooperación contemporánea")

#part-reading-list("historia-compartida")

#part("Lenguas y culturas")

#chapter("Español y portugués")

#chapter("Lenguas cooficiales")

#chapter("Cultura y educación")

#chapter("Patrimonio")

#part-reading-list("lenguas-y-culturas")

#part("Instituciones y ciudadanía")

#chapter("Modelos de integración")

#chapter("Derecho y movilidad")

#chapter("Representación")

#chapter("Cooperación territorial")

#part-reading-list("instituciones-y-ciudadania")

#part("Economía e infraestructuras")

#chapter("Comercio")

#chapter("Energía")

#chapter("Transportes")

#chapter("Ciencia y tecnología")

#part-reading-list("economia-e-infraestructuras")

#part("Geopolítica y relaciones internacionales")

#chapter("Atlántico")

#chapter("Europa")

#chapter("América Latina")

#chapter("África y Asia")

#part-reading-list("geopolitica-y-relaciones-internacionales")

#part("Escenarios y hoja de ruta")

#chapter("Integración gradual")

#chapter("Riesgos y críticas")

#chapter("Políticas públicas")

#chapter("Indicadores de seguimiento")

#part-reading-list("escenarios-y-hoja-de-ruta")

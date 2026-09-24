#import "elsevier.typ": elsevier-paper
#import "ieee.typ": ieee-paper
#import "mdpi.typ": mdpi-paper

// Dispatcher editorial común.
//
// IMPORTANTE: todos los estilos consumen exactamente el MISMO `meta`.
// Cambiar de Elsevier a IEEE o MDPI solo requiere cambiar `style`.
//
// Los argumentos específicos antiguos se mantienen temporalmente en la firma
// para que los papers creados con la primera versión sigan compilando, pero ya
// no se usan. La información editorial sale siempre de `meta`.
#let paper-template(
  meta: (:),
  style: none,
  bibliography-source: none,

  // Compatibilidad con la primera versión del sistema (ignorados).
  elsevier-authors: (),
  elsevier-affiliations: (:),
  elsevier-journal: none,
  elsevier-paper-type: none,
  elsevier-paper-info: (:),
  ieee-authors: (),
  ieee-paper-size: "us-letter",
  ieee-figure-supplement: [Fig.],
  mdpi-authors: (),
  mdpi-date: none,
  mdpi-doi: "",

  body,
) = {
  let selected-style = if style == none {
    meta.at("style", default: "elsevier")
  } else {
    style
  }

  if selected-style == "elsevier" {
    elsevier-paper.with(
      meta: meta,
      journal: elsevier-journal,
      paper-type: elsevier-paper-type,
      paper-info: elsevier-paper-info,
      bibliography-source: bibliography-source,
    )(body)
  } else if selected-style == "ieee" {
    ieee-paper.with(
      meta: meta,
      bibliography-source: bibliography-source,
      paper-size: ieee-paper-size,
      figure-supplement: ieee-figure-supplement,
    )(body)
  } else if selected-style == "mdpi" {
    mdpi-paper.with(
      meta: meta,
      bibliography-source: bibliography-source,
    )(body)
  } else {
    panic("Unknown paper style: " + selected-style)
  }
}

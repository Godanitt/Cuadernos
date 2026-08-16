#import "elsevier.typ": elsevier-paper
#import "ieee.typ": ieee-paper
#import "mdpi.typ": mdpi-paper

// Dispatcher editorial común.
// Si `style` no está definido en los metadatos, Elsevier es el valor por defecto.
#let paper-template(
  meta: (:),
  style: none,
  bibliography-source: none,

  // Elsevier
  elsevier-authors: (),
  elsevier-affiliations: (:),
  elsevier-journal: none,
  elsevier-paper-type: none,
  elsevier-paper-info: (:),

  // IEEE
  ieee-authors: (),
  ieee-paper-size: "us-letter",
  ieee-figure-supplement: "Fig.",

  // MDPI
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
      authors: elsevier-authors,
      affiliations: elsevier-affiliations,
      journal: elsevier-journal,
      paper-type: elsevier-paper-type,
      paper-info: elsevier-paper-info,
      bibliography-source: bibliography-source,
    )(body)
  } else if selected-style == "ieee" {
    ieee-paper.with(
      meta: meta,
      authors: ieee-authors,
      bibliography-source: bibliography-source,
      paper-size: ieee-paper-size,
      figure-supplement: ieee-figure-supplement,
    )(body)
  } else if selected-style == "mdpi" {
    mdpi-paper.with(
      meta: meta,
      authors: mdpi-authors,
      date: mdpi-date,
      doi: mdpi-doi,
      bibliography-source: bibliography-source,
    )(body)
  } else {
    panic("Unknown paper style: " + selected-style)
  }
}

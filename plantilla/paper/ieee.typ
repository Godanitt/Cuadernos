#import "@preview/charged-ieee:0.1.4": ieee

// Adaptador común para papers IEEE.
// `authors` conserva deliberadamente la estructura nativa de charged-ieee.
#let ieee-paper(
  meta: (:),
  authors: (),
  bibliography-source: none,
  paper-size: "us-letter",
  figure-supplement: "Fig.",
  body,
) = [
  #let bib = if bibliography-source == none {
    none
  } else {
    bibliography(bibliography-source)
  }

  #show: ieee.with(
    title: [#meta.title],
    authors: authors,
    abstract: if meta.abstract == "" { none } else { [#meta.abstract] },
    index-terms: meta.keywords.map(keyword => [#keyword]),
    paper-size: paper-size,
    bibliography: bib,
    figure-supplement: figure-supplement,
  )

  #body
]

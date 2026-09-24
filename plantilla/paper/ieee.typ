#import "common.typ": common-authors, author-name, author-department, author-institution, author-location, author-email, as-content
#import "@preview/charged-ieee:0.1.4": ieee

// Adaptador IEEE. Recibe SOLO el esquema común `meta` y lo convierte
// internamente a la estructura nativa de charged-ieee.
#let ieee-paper(
  meta: (:),
  bibliography-source: none,
  paper-size: "us-letter",
  figure-supplement: [Fig.],
  body,
) = {
  let native-authors = common-authors(meta).map(author => (
    // charged-ieee exige específicamente un string en `name`.
    name: author-name(author),
    department: as-content(author-department(meta, author)),
    organization: as-content(author-institution(meta, author)),
    location: as-content(author-location(meta, author)),
    email: author-email(meta, author),
  ))

  let bib = if bibliography-source == none {
    none
  } else {
    bibliography(bibliography-source)
  }

  [
    #show: ieee.with(
      title: [#meta.title],
      authors: native-authors,
      abstract: if meta.at("abstract", default: "") == "" {
        none
      } else {
        [#meta.abstract]
      },
      index-terms: meta.at("keywords", default: ()),
      paper-size: paper-size,
      bibliography: bib,
      figure-supplement: figure-supplement,
    )

    #body
  ]
}

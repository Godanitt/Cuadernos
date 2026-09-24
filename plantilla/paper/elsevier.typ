#import "common.typ": common-authors, author-name, author-email, author-orcid, author-corresponding, author-affiliation, as-content
#import "@preview/elspub:1.0.0": *

// Adaptador Elsevier. Recibe SOLO el esquema común `meta` y lo convierte
// internamente a la estructura nativa de elspub.
#let elsevier-paper(
  meta: (:),
  journal: none,
  paper-type: none,
  paper-info: none,
  bibliography-source: none,
  body,
) = {
  let common = common-authors(meta)

  let native-authors = range(common.len()).map(index => {
    let author = common.at(index)
    let email = author-email(meta, author)
    let orcid = author-orcid(author)
    let native = (
      name: as-content(author-name(author)),
      affiliations: (str(index + 1),),
      corresponding: author-corresponding(author),
    )
    if email != "" { native += (email: email,) }
    if orcid != "" { native += (orcid: orcid,) }
    native
  })

  let native-affiliations = (:)
  for index in range(common.len()) {
    native-affiliations.insert(
      str(index + 1),
      as-content(author-affiliation(meta, common.at(index))),
    )
  }

  // Regla del proyecto: Elsevier siempre se renderiza a dos columnas.
  let base-journal = if journal == none { meta.at("journal", default: mssp) } else { journal }
  let normalized-journal = base-journal + (numcol: 2,)

  let custom-paper-info = if paper-info == none { (:) } else { paper-info }
  let normalized-paper-info = paper-info-default + (extra-info: []) + custom-paper-info

  [
    #show: elspub.with(
      paper-type: paper-type,
      journal: normalized-journal,
      title: [#meta.title],
      abstract: [#meta.at("abstract", default: "")],
      authors: native-authors,
      affiliations: native-affiliations,
      paper-info: normalized-paper-info,
      keywords: meta.at("keywords", default: ()),
    )

    #body

    #if bibliography-source != none {
      bibliography(bibliography-source, style: "elsevier-with-titles")
    }
  ]
}

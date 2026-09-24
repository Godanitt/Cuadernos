#import "common.typ": common-authors, author-name, author-department, author-institution, author-city, author-country, author-email, normalized-date
#import "@preview/splendid-mdpi:0.1.0"

// Adaptador MDPI. Recibe SOLO el esquema común `meta` y lo convierte
// internamente a la estructura nativa de splendid-mdpi.
#let mdpi-paper(
  meta: (:),
  bibliography-source: none,
  body,
) = {
  let native-authors = common-authors(meta).map(author => (
    name: author-name(author),
    department: author-department(meta, author),
    institution: author-institution(meta, author),
    city: author-city(meta, author),
    country: author-country(meta, author),
    mail: author-email(meta, author),
  ))

  [
    #show: splendid-mdpi.template.with(
      title: [#meta.title],
      authors: native-authors,
      date: normalized-date(meta),
      keywords: meta.at("keywords", default: ()),
      doi: meta.at("doi", default: ""),
      abstract: [#meta.at("abstract", default: "")],
    )

    #body

    #if bibliography-source != none {
      bibliography(
        bibliography-source,
        style: "multidisciplinary-digital-publishing-institute",
      )
    }
  ]
}

#import "@preview/splendid-mdpi:0.1.0"

// Adaptador común para papers MDPI.
// `authors` y `date` usan la estructura nativa de splendid-mdpi.
#let mdpi-paper(
  meta: (:),
  authors: (),
  date: none,
  doi: "",
  bibliography-source: none,
  body,
) = [
  #show: splendid-mdpi.template.with(
    title: [#meta.title],
    authors: authors,
    date: date,
    keywords: meta.keywords,
    doi: doi,
    abstract: [#meta.abstract],
  )

  #body

  #if bibliography-source != none {
    bibliography(
      bibliography-source,
      style: "multidisciplinary-digital-publishing-institute",
    )
  }
]

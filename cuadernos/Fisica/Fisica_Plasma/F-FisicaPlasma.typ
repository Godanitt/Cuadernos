#import "../../../plantilla/plantilla.typ": *
#import "generated/config.typ": notebook-config, bibliography-file, bibliography-enabled
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)

#show: book.with(..notebook-config)

#include "content.typ"

#if bibliography-enabled {
  my-bibliography(
    bibliography(bibliography-file, title: "Bibliografía", full: true)
  )
}

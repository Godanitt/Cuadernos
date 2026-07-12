#import "../../../plantilla/plantilla.typ": *
#import "generated/config.typ": notebook-config, bibliography-file, bibliography-enabled
#show: book.with(..notebook-config)

#include "content.typ"

#if bibliography-enabled {
  my-bibliography(
    bibliography(bibliography-file, title: "Bibliografía", full: true)
  )
}

#import "@preview/elspub:1.0.0": *

// Adaptador común para el estilo Elsevier.
// El selector público del proyecto sigue siendo `style: "elsevier"`.
//
// `elspub` usa `mssp` como journal por defecto. Como nuestro dispatcher
// permite `none`, normalizamos aquí los valores para no sobrescribir los
// defaults internos del paquete con `none`.
#let elsevier-paper(
  meta: (:),
  authors: (),
  affiliations: (:),
  journal: none,
  paper-type: none,
  paper-info: none,
  bibliography-source: none,
  body,
) = {
  // Regla del proyecto: todos los papers Elsevier se maquetan siempre
  // a dos columnas, independientemente del journal seleccionado.
  let base-journal = if journal == none { mssp } else { journal }
  let normalized-journal = base-journal + (numcol: 2,)

  // elspub accede directamente a `paper-info.extra-info`, por lo que
  // garantizamos un diccionario completo incluso si el paper no define
  // información editorial adicional.
  let custom-paper-info = if paper-info == none { (:) } else { paper-info }
  let normalized-paper-info = paper-info-default + (extra-info: []) + custom-paper-info

  [
    #show: elspub.with(
      paper-type: paper-type,
      journal: normalized-journal,
      title: [#meta.title],
      abstract: [#meta.abstract],
      authors: authors,
      affiliations: affiliations,
      paper-info: normalized-paper-info,
      keywords: meta.keywords,
    )

    #body

    #if bibliography-source != none {
      bibliography(bibliography-source, style: "elsevier-with-titles")
    }
  ]
}

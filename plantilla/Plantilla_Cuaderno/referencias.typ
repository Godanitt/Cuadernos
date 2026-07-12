// Bibliografía o lista de lecturas específica de una parte.
// Las entradas se generan automáticamente desde cuaderno.toml y el BibTeX local.
#let part-bibliography(
  title: "Bibliografía y lecturas recomendadas",
  entries: (),
) = {
  if entries.len() > 0 [
    #heading(level: 2, title)
    #for entry in entries [
      - #entry.label
        #if entry.doi != "" [ · #link("https://doi.org/" + entry.doi)[DOI]]
        #if entry.url != "" [ · #link(entry.url)[Enlace]]
        #text(size: 8pt, fill: gray)[ (#entry.key)]
    ]
  ]
}

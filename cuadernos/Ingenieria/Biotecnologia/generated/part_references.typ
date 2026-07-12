// Generado desde cuaderno.toml y Bibliografia/referencias.bib.
// No editar a mano: ejecuta `python -m cuadernos update`.
#let part-references = (
  "biologia-molecular-para-ingenieria": (),
  "ingenieria-genetica-y-sintetica": (),
  "bioprocesos": (),
  "operaciones-de-separacion": (),
  "omicas-y-biologia-computacional": (),
  "aplicaciones": (),
  "calidad-y-regulacion": (),
)

#let part-reading-list(slug, title: "Bibliografía y lecturas recomendadas") = {
  let entries = part-references.at(slug, default: ())
  if entries.len() > 0 [
    #heading(level: 2)[#title]
    #for entry in entries [
      - #entry.label
        #if entry.doi != "" [ · #link("https://doi.org/" + entry.doi)[DOI]]
        #if entry.url != "" [ · #link(entry.url)[Enlace]]
    ]
  ]
}

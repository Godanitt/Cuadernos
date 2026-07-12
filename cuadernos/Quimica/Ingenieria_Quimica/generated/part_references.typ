// Generado desde cuaderno.toml y Bibliografia/referencias.bib.
// No editar a mano: ejecuta `python -m cuadernos update`.
#let part-references = (
  "fundamentos-y-balances": ((key: "calleja2008", label: "Calleja, G., García, F., de Lucas, A., Prats, D., Rodríguez, J. M. — Introducción a la Ingeniería Química (2008)", doi: "", url: ""), (key: "himmelblau2002", label: "Himmelblau, David M. — Principios Básicos y Cálculos en Ingeniería Química (2002)", doi: "", url: "")),
  "fenomenos-de-transporte": ((key: "calleja2008", label: "Calleja, G., García, F., de Lucas, A., Prats, D., Rodríguez, J. M. — Introducción a la Ingeniería Química (2008)", doi: "", url: ""), (key: "himmelblau2002", label: "Himmelblau, David M. — Principios Básicos y Cálculos en Ingeniería Química (2002)", doi: "", url: "")),
  "operaciones-de-separacion": ((key: "calleja2008", label: "Calleja, G., García, F., de Lucas, A., Prats, D., Rodríguez, J. M. — Introducción a la Ingeniería Química (2008)", doi: "", url: ""),),
  "diseno-control-y-seguridad-de-procesos": ((key: "calleja2008", label: "Calleja, G., García, F., de Lucas, A., Prats, D., Rodríguez, J. M. — Introducción a la Ingeniería Química (2008)", doi: "", url: ""),),
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

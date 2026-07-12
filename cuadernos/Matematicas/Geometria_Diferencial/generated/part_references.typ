// Generado desde cuaderno.toml y Bibliografia/referencias.bib.
// No editar a mano: ejecuta `python -m cuadernos update`.
#let part-references = (
  "variedades-diferenciales": ((key: "gross2023manifolds", label: "Gross, G., Meinrenken, E. — Manifolds, Vector Fields, and Differential Forms: An Introduction to Differential Geometry (2023)", doi: "", url: "https://books.google.es/books?id=7yiSzwEACAAJ"), (key: "FrankelGeometryPhysics", label: "Frankel, Theodore — The Geometry of Physics: An Introduction (2011)", doi: "", url: "")),
  "geometria-de-riemann": ((key: "FrankelGeometryPhysics", label: "Frankel, Theodore — The Geometry of Physics: An Introduction (2011)", doi: "", url: ""), (key: "NakaharaGeometryTopologyPhysics", label: "Nakahara, Mikio — Geometry, Topology and Physics (2003)", doi: "", url: "")),
  "relatividad-general": ((key: "FrankelGeometryPhysics", label: "Frankel, Theodore — The Geometry of Physics: An Introduction (2011)", doi: "", url: ""), (key: "NakaharaGeometryTopologyPhysics", label: "Nakahara, Mikio — Geometry, Topology and Physics (2003)", doi: "", url: "")),
  "teorias-de-gauge": ((key: "NakaharaGeometryTopologyPhysics", label: "Nakahara, Mikio — Geometry, Topology and Physics (2003)", doi: "", url: ""), (key: "FrankelGeometryPhysics", label: "Frankel, Theodore — The Geometry of Physics: An Introduction (2011)", doi: "", url: "")),
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

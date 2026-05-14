#import "@preview/cetz:0.5.2"

#let cover1_title(
  primary: color,
  seccond: color,
  third: color,
  accent: color,
  title: str,
  subtitle: "",
  serie: "",
  author: (),
  github_url: "https://github.com/Godanitt/Cuadernos",
  cover: none,
) = [
  #set page(margin: 0cm)

  #let authors = if type(author) == array {
    author
  } else if author == none {
    ()
  } else {
    (author,)
  }

  #let top-label = if serie != "" {
    link(github_url)[#serie]
  } else {
    ""
  }

  #rect(width: 100%, height: 100%, fill: white)[

    // =========================================================
    // Barra superior azul
    // =========================================================
    #place(top + left, dx: 0cm, dy: 0cm)[
      #box(
        width: 15.7cm,
        height: 1.05cm,
        fill: primary,
        inset: 0pt,
      )[
        #align(center + horizon)[
          #text(
            size: 18pt,
            fill: white,
            weight: "regular",
            tracking: 2pt,
          )[
            #top-label
          ]
        ]
      ]
    ]

    // Pequeña barra decorativa superior derecha, sin logo editorial
    #place(top + right, dx: 0cm, dy: 2.65cm)[
      #box(
        width: 4.7cm,
        height: 0.23cm,
        fill: primary,
      )[]
    ]

    // =========================================================
    // Autor
    // =========================================================
    #place(top + left, dx: 2.25cm, dy: 2.25cm)[
      #block(width: 15cm)[
        #if authors.len() > 0 [
          #for a in authors [
            #text(size: 16pt, weight: "bold", fill: black)[#a]
            #v(0.15cm)
          ]
        ]
      ]
    ]

    // =========================================================
    // Título principal
    // =========================================================
    #place(top + left, dx: 2.25cm, dy: 4.3cm)[
      #block(width: 16.5cm)[
        #text(
          size: 55pt,
          weight: "bold",
          fill: black,
        )[
          #title
        ]

        #if subtitle != "" [
          #v(0.75cm)
          #text(
            size: 18pt,
            style: "italic",
            fill: black,
          )[
            #subtitle
          ]
        ]
      ]
    ]

    // =========================================================
    // Barra vertical azul izquierda
    // =========================================================
    #place(bottom + left, dx: 0cm, dy: -1.15cm)[
      #box(
        width: 1.95cm,
        height: 1cm,
        fill: primary,
      )[]
    ]

    // =========================================================
    // Panel inferior tipo portada de libro
    // =========================================================
    #place(bottom + left, dx: 2.25cm, dy: -1.15cm)[
      #box(
        width: 17.2cm,
        height: 15.5cm,
        fill: seccond,
        inset: 0pt,
      )[
        #if cover != none [
          #align(center + horizon)[
            #image(cover, width: 100%, height: 100%, fit: "cover")
          ]
        ] else [
          #align(center + horizon)[
            #cetz.canvas(length: 2.15cm, {
              import cetz.draw: *

              // Estilo general del dibujo
              let black-stroke = (
                paint: black,
                thickness: 1.25pt,
                cap: "round",
              )

              let yellow-stroke = (
                paint: third,
                thickness: 1.35pt,
                cap: "round",
              )

              // Vértice central
              circle((0, 0), radius: 0.075, fill: black, stroke: none)

              // Líneas negras entrantes/salientes
              line(
                (-1.95, 0.9),
                (0, 0),
                stroke: black-stroke,
                mark: (end: ">"),
              )

              line(
                (-1.55, -1.25),
                (0, 0),
                stroke: black-stroke,
                mark: (end: ">"),
              )

              line(
                (0, 0),
                (2.05, 0.45),
                stroke: black-stroke,
                mark: (end: ">"),
              )

              // Línea amarilla superior
              line(
                (-1.45, 1.22),
                (-0.15, 0.28),
                stroke: yellow-stroke,
                mark: (end: ">"),
              )
              // Línea amarilla inferior
              line(
                (-0.55, -1.05),
                (0.05, -0.12),
                stroke: yellow-stroke,
                mark: (end: ">"),
              )

              // Gluon amarillo ondulado aproximado
              for i in range(0, 10) {
                let x0 = 0.15 + i * 0.22
                bezier(
                  (x0, 0.18),
                  (x0 + 0.06, 0.55),
                  (x0 + 0.16, -0.05),
                  (x0 + 0.22, 0.32),
                  stroke: yellow-stroke,
                )
              }

              // Etiquetas negras
              content((-1.28, 0.75), [$q$], anchor: "center")
              content((-0.62, -0.56), [$q$], anchor: "center")
              content((1.1, -0.22), [$g$], anchor: "center")

              // Etiquetas amarillas con efecto de partícula
              content((-0.62, 1.18), text(fill: third, size: 16pt)[$q$], anchor: "center")
              content((0.05, -0.78), text(fill: third, size: 16pt)[$q$], anchor: "center")
              content((1.55, 0.67), text(fill: third, size: 16pt)[$g$], anchor: "center")
            })
          ]
        ]
      ]
    ]

    // =========================================================
    // Footer discreto con GitHub/serie
    // // =========================================================
    // #place(bottom + left, dx: 2.25cm, dy: -0.35cm)[
    //   #if github_url != "" [
    //     #text(size: 10pt, fill: primary, weight: "bold")[
    //       #link(github_url)[#github_url]
    //     ]
    //   ]
    // ]
  ]
]
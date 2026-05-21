#let cover2_title(
  primary: color,
  seccond: color,
  third: color,
  accent: color,
  image_path: none,
  title: str,
  subtitle: "",
  serie: "",
  author: (),
  github_url: "https://github.com/Godanitt/Cuadernos",
  cover: none,
) = [
  #page(margin: 0pt)[
    #let authors = if author == none {
      ()
    } else {
      author
    }

    #let top-label = if serie != "" {
      serie
    } else {
      "SERIES"
    }

    #rect(width: 100%, height: 100%, fill: white)[

      // =====================================================
      // Barra superior
      // =====================================================
      #place(top + left, dx: 0cm, dy: 0cm)[
        #box(
          width: 100%,
          height: 1.35cm,
          fill: primary,
          inset: 0pt,
        )[
          #place(right, dx: -1.1cm, dy: 0cm)[
            #text(
              size: 22pt,
              fill: white,
              weight: "regular",
            )[
              #top-label
            ]
          ]
        ]
      ]

      // =====================================================
      // Autor
      // =====================================================
      #place(top + left, dx: 2.35cm, dy: 2.15cm)[
        #block(width: 14cm)[
          #if authors.len() > 0 [
            #for a in authors [
              #text(
                size: 16pt,
                fill: black,
                weight: "bold",
              )[
                #a
              ]
              #v(0.1cm)
            ]
          ]
        ]
      ]

      // =====================================================
      // Título
      // =====================================================
      #place(top + left, dx: 2.35cm, dy: 4.0cm)[
        #block(width: 14cm)[
          #text(
            size: 44pt,
            fill: black,
            weight: "bold",
          )[
            #title
          ]

          #if subtitle != "" [
            #v(0.75cm)
            #text(
              size: 18pt,
              fill: black,
              style: "italic",
            )[
              #subtitle
            ]
          ]
        ]
      ]

      // =====================================================
      // Línea de corte recta
      // =====================================================
      #place(top + left, dx: 0cm, dy: 10.6cm)[
        #box(
          width: 100%,
          height: 0.18cm,
          fill: primary,
        )[]
      ]

      // =====================================================
      // Imagen inferior a sangre
      // =====================================================
      #place(top + left, dx: 0cm, dy: 10.78cm)[
        #box(
          width: 100%,
          height: 18.92cm,
          fill: black,
          inset: 0pt,
        )[
          #if cover != none [
            #image(
              cover,
              width: 100%,
              height: 100%,
              fit: "cover",
            )
          ] else if image_path != none [
            #image(
              image_path,
              width: 100%,
              height: 100%,
              fit: "cover",
            )
          ] else [
            #align(center + horizon)[
              #text(size: 20pt, fill: white)[Sin imagen de portada]
            ]
          ]
        ]
      ]

      // =====================================================
      // Footer opcional sobre la imagen
      // =====================================================
      #if github_url != "" [
        #place(bottom + left, dx: 1.1cm, dy: -0.6cm)[
          #box(
            inset: (x: 0.35cm, y: 0.18cm),
            fill: rgb(255, 255, 255, 35%),
            radius: 0.08cm,
            stroke: none,
          )[
            #text(
              size: 9pt,
              fill: white,
              weight: "bold",
            )[
              #link(github_url)[#github_url]
            ]
          ]
        ]
      ]
    ]
  ]
]
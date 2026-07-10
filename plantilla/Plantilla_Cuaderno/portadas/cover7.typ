#let _cover_crop(
  cover,
  box-width,
  box-height,
  zoom: 1.0,
  dx: 0cm,
  dy: 0cm,
) = {
  box(width: box-width, height: box-height, inset: 0pt, clip: true, fill: white)[
    #if cover != none [
      #align(center + horizon)[
        #move(dx: dx, dy: dy)[
          #image(
            cover,
            width: box-width * zoom,
            height: box-height * zoom,
            fit: "cover",
          )
        ]
      ]
    ] else [
      #align(center + horizon)[#text(size: 18pt, fill: gray)[Sin imagen de portada]]
    ]
  ]
}

#let cover7_title(
  primary: color,
  seccond: color,
  third: color,
  accent: color,
  title: str,
  subtitle: "",
  serie: "",
  author: (),
  github_url: "https://github.com/Godanitt/Cuadernos",
  volume: "",
  cover: none,
  cover-zoom: 1.08,
  cover-dx: 0cm,
  cover-dy: 0cm,
) = [
  #page(margin: 0pt)[
    #layout(size => {
      let page-w = size.width
      let page-h = size.height
      let image-y = 9.25cm
      let footer-h = 1.55cm
      let image-h = page-h - image-y - footer-h
      let bleed-x = 0.35cm
      let authors = if type(author) == array { author } else if author == none { () } else { (author,) }

      rect(width: page-w, height: page-h, fill: white)[
        // Cabecera superior compacta.
        #place(top + left, dx: 1.05cm, dy: 1.05cm)[
          #block(width: 10.5cm)[
            #text(size: 12pt, weight: "bold", fill: primary)[Cuadernos]
            #v(0.08cm)
            #if serie != "" [
              #text(size: 11pt, fill: black)[#serie]
            ]
            #v(0.25cm)
            #box(width: 1.65cm, height: 0.055cm, fill: primary)[]
          ]
        ]

        // Volumen/código.
        #if volume != "" [
          #place(top + right, dx: -1.05cm, dy: 0.75cm)[
            #box(width: 1.45cm, height: 1.45cm, fill: primary)[
              #align(center + horizon)[
                #text(size: 15pt, weight: "bold", fill: white)[#volume]
              ]
            ]
          ]
        ]

        // Título + línea + autor.
        #place(top + left, dx: 1.05cm, dy: 4.25cm)[
          #block(width: page-w - 2.1cm)[
            #text(size: 62pt, weight: "bold", fill: black)[#title]
            #v(0.32cm)
            #box(width: 6.2cm, height: 0.055cm, fill: primary)[]
            #if subtitle != "" and subtitle != " " [
              #v(0.38cm)
              #text(size: 22pt, style: "italic", fill: black.lighten(20%))[#subtitle]
            ]
            #if authors.len() > 0 [
              #v(0.35cm)
              #for a in authors [
                #if a != "" [
                  #text(size: 22pt, style: "italic", fill: black)[#a]
                  #v(0.1cm)
                ]
              ]
            ]
          ]
        ]

        // Imagen central/inferior, con fade superior.
        #place(top + left, dx: 0cm, dy: image-y)[
          #box(width: page-w, height: image-h, inset: 0pt, clip: true)[
            #place(top + left, dx: -bleed-x, dy: 0cm)[
              #_cover_crop(
                cover,
                page-w + 2 * bleed-x,
                image-h,
                zoom: cover-zoom,
                dx: cover-dx,
                dy: cover-dy,
              )
            ]

            #place(top + left)[
              #rect(
                width: page-w,
                height: 2.8cm,
                fill: gradient.linear(
                  angle: 90deg,
                  (white, 0%),
                  (rgb(255, 255, 255, 0%), 100%),
                ),
              )[]
            ]
          ]
        ]

        // Footer azul.
        #place(bottom + left, dx: 0cm, dy: 0cm)[
          #rect(width: page-w, height: footer-h, fill: primary)[]
        ]

        #place(bottom + left, dx: 1.05cm, dy: -0.95cm)[
          #if serie != "" [
            #text(size: 9pt, fill: white)[#link(github_url)[#serie]]
          ]
        ]

        #place(bottom + right, dx: -1.05cm, dy: -0.95cm)[
          #if github_url != "" [
            #text(size: 7.6pt, fill: white)[#github_url]
          ]
        ]
      ]
    })
  ]
]

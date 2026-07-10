#let _cover_crop(
  cover,
  region-width,
  region-height,
  zoom: 1.14,
  dx: 0cm,
  dy: 0cm,
) = {
  box(width: region-width, height: region-height, inset: 0pt, clip: true)[
    #if cover != none [
      #align(center + horizon)[
        #move(dx: dx, dy: dy)[
          #image(
            cover,
            width: region-width * zoom,
            height: region-height * zoom,
            fit: "cover",
          )
        ]
      ]
    ] else [
      #align(center + horizon)[#text(size: 18pt, fill: gray)[Sin imagen de portada]]
    ]
  ]
}

#let cover3_title(
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
  cover-zoom: 1.16,
  cover-dx: 0cm,
  cover-dy: 0cm,
) = [
  #page(margin: 0pt)[
    #layout(size => {
      let page-w = size.width
      let page-h = size.height

      // Región activa vertical de la imagen.
      let image-y = 9.20cm
      let image-h = page-h - image-y

      // Bleed real de página: la caja de imagen se dibuja un poco fuera
      // de la página por ambos lados y el PDF recorta al borde físico.
      // Esto elimina el hilo blanco lateral que aparece en algunos visores.
      let page-bleed-x = 0.35cm
      let image-w = page-w + 2 * page-bleed-x

      let authors = if type(author) == array {
        author
      } else if author == none {
        ()
      } else {
        (author,)
      }

      let top-label = if serie != "" {
        serie
      } else {
        "SERIES"
      }

      rect(width: page-w, height: page-h, fill: white)[
        // Barra superior
        #place(top + left, dx: 0cm, dy: 0cm)[
          #box(width: page-w, height: 1.15cm, fill: primary, inset: 0pt)[
            #align(center + horizon)[
              #text(size: 18pt, fill: white, tracking: 2pt, weight: "regular")[
                #if serie != "" and github_url != "" [
                  #link(github_url)[#serie]
                ] else [
                  #top-label
                ]
              ]
            ]
          ]
        ]

        // Autor
        #place(top + left, dx: 2.15cm, dy: 2.05cm)[
          #block(width: page-w - 4.3cm)[
            #if authors.len() > 0 [
              #for a in authors [
                #if a != "" [
                  #text(size: 22pt, weight: "bold", fill: black)[#a]
                  #v(0.16cm)
                ]
              ]
            ]
          ]
        ]

        // Título principal. Este bloque queda fuera de la región activa.
        #place(top + left, dx: 2.15cm, dy: 3.85cm)[
          #block(width: page-w - 4.3cm)[
            #text(size: 62pt, weight: "bold", fill: black)[#title]

            #if subtitle != "" and subtitle != " " [
              #v(0.55cm)
              #text(size: 22pt, style: "italic", fill: black.lighten(15%))[#subtitle]
            ]
          ]
        ]

        // Imagen a sangre real: la región empieza antes del borde izquierdo.
        // La imagen se adapta a esta región y se recorta, no se reduce la región.
        #place(top + left, dx: -page-bleed-x, dy: image-y)[
          #box(width: image-w, height: image-h, inset: 0pt, clip: true)[
            #_cover_crop(
              cover,
              image-w,
              image-h,
              zoom: cover-zoom,
              dx: cover-dx,
              dy: cover-dy,
            )

            // Fundido superior extendido, también con bleed.
            #place(top + left)[
              #rect(
                width: image-w,
                height: 3.5cm,
                fill: gradient.linear(
                  angle: 90deg,
                  (white, 0%),
                  (rgb(255, 255, 255, 0%), 100%),
                ),
              )[]
            ]
          ]
        ]
      ]
    })
  ]
]

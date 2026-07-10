#let _cover_crop(
  cover,
  box-width,
  box-height,
  zoom: 1.0,
  dx: 0cm,
  dy: 0cm,
  fallback-fill: black,
) = {
  box(width: box-width, height: box-height, inset: 0pt, clip: true, fill: fallback-fill)[
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
      #align(center + horizon)[#text(size: 18pt, fill: white)[Sin imagen de portada]]
    ]
  ]
}

#let cover5_title(
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
  cover-theme: "dark",
  cover-zoom: 1.04,
  cover-dx: 0cm,
  cover-dy: 0cm,
) = [
  #page(margin: 0pt)[
    #layout(size => {
      let page-w = size.width
      let page-h = size.height
      let authors = if type(author) == array { author } else if author == none { () } else { (author,) }
      let text-color = if cover-theme == "light" { black } else { white }
      let veil = if cover-theme == "light" { rgb(255, 255, 255, 8%) } else { rgb(0, 0, 0, 18%) }

      rect(width: page-w, height: page-h, fill: black)[
        #_cover_crop(
          cover,
          page-w,
          page-h,
          zoom: cover-zoom,
          dx: cover-dx,
          dy: cover-dy,
        )

        // Velo global, no caja bajo título.
        #place(top + left)[
          #rect(width: page-w, height: page-h, fill: veil)[]
        ]

        // Cabecera superior izquierda.
        #place(top + left, dx: 1.05cm, dy: 1.0cm)[
          #block(width: 9.5cm)[
            #text(size: 11pt, weight: "bold", fill: text-color)[Cuadernos]
            #v(0.06cm)
            #if serie != "" [
              #text(size: 10pt, fill: text-color)[#serie]
            ]
            #v(0.25cm)
            #box(width: 1.6cm, height: 0.045cm, fill: text-color)[]
          ]
        ]

        // Volumen/código.
        #if volume != "" [
          #place(top + right, dx: -1.0cm, dy: 0.8cm)[
            #box(width: 1.35cm, height: 1.35cm, fill: if cover-theme == "light" { primary } else { white })[
              #align(center + horizon)[
                #text(
                  size: 15pt,
                  weight: "bold",
                  fill: if cover-theme == "light" { white } else { black },
                )[#volume]
              ]
            ]
          ]
        ]

        // Título.
        #place(top + left, dx: 1.05cm, dy: 3.85cm)[
          #block(width: page-w - 2.15cm)[
            #text(size: 62pt, weight: "bold", fill: text-color)[#title]
            #v(0.35cm)
            #box(width: 4.0cm, height: 0.055cm, fill: text-color)[]
            #if subtitle != "" and subtitle != " " [
              #v(0.42cm)
              #text(size: 22pt, style: "italic", fill: text-color)[#subtitle]
            ]
            #if authors.len() > 0 [
              #v(0.55cm)
              #for a in authors [
                #if a != "" [
                  #text(size: 22pt, style: "italic", weight: "bold", fill: text-color)[#a]
                  #v(0.1cm)
                ]
              ]
            ]
          ]
        ]

        // Footer.
        #place(bottom + left, dx: 1.05cm, dy: -1.08cm)[
          #block(width: page-w - 2.1cm)[
            #if serie != "" [
              #text(size: 8.5pt, fill: text-color)[#link(github_url)[#serie]]
            ]
            #v(0.06cm)
            #if github_url != "" [
              #text(size: 7.6pt, fill: text-color)[#github_url]
            ]
          ]
        ]
      ]
    })
  ]
]

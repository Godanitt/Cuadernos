#let cover4_title(
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
  cover-text-color: "auto",
) = [
  #page(margin: 0pt)[
    #layout(size => {
      let page-w = size.width
      let page-h = size.height
      let bleed = 0.35cm

      let authors = if type(author) == array {
        author
      } else if author == none {
        ()
      } else {
        (author,)
      }

      let base-text-color = if cover-theme == "light" {
        black
      } else {
        white
      }

      let text-color = if cover-text-color == "auto" {
        base-text-color
      } else if cover-text-color == "black" {
        black
      } else if cover-text-color == "white" {
        white
      } else {
        cover-text-color
      }

      [
        // Fondo solo de seguridad. No contiene la imagen.
        #rect(width: page-w, height: page-h, fill: black)[]

        // Imagen a sangre real.
        // Se dibuja ligeramente fuera de la página y el PDF la recorta.
        // Así no queda marco negro aunque el visor o el contenedor introduzca un borde.
        #if cover != none [
          #place(top + left, dx: -bleed + cover-dx, dy: -bleed + cover-dy)[
            #box(
              width: page-w + 2 * bleed,
              height: page-h + 2 * bleed,
              inset: 0pt,
              clip: true,
            )[
              #image(
                cover,
                width: (page-w + 2 * bleed) * cover-zoom,
                height: (page-h + 2 * bleed) * cover-zoom,
                fit: "cover",
              )
            ]
          ]
        ] else [
          #place(center + horizon)[
            #text(size: 18pt, fill: white)[Sin imagen de portada]
          ]
        ]

        // Autor
        #place(top + left, dx: 1.8cm, dy: 3cm)[
          #block(width: 12cm)[
            #if authors.len() > 0 [
              #for a in authors [
                #if a != "" [
                  #text(size: 22pt, fill: text-color)[#a]
                  #v(0.15cm)
                ]
              ]
            ]
          ]
        ]

        // Título
        #place(top + left, dx: 1.8cm, dy: 5.9cm)[
          #block(width: 16.2cm)[
            #text(size: 68pt, weight: "bold", fill: text-color)[#title]

            #if subtitle != "" and subtitle != " " [
              #v(0.5cm)
              #text(size: 22pt, fill: text-color.lighten(10%))[#subtitle]
            ]
          ]
        ]

        // Código de cuaderno opcional, por ejemplo F-02, I-01...
        #if volume != "" [
          #place(top + right, dx: -1.0cm, dy: 0.8cm)[
            #box(
              width: 1.35cm,
              height: 1.35cm,
              fill: if cover-theme == "light" { primary } else { white },
              inset: 0pt,
            )[
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

        // Serie inferior izquierda. El enlace al GitHub está en la propia serie,
        // sin imprimir la URL debajo.
        #if serie != "" [
          #place(bottom + left, dx: 1.8cm, dy: -1.45cm)[
            #block(width: 12cm)[
              #text(size: 18pt, fill: text-color, tracking: 0.8pt, weight: "bold")[
                #if github_url != "" [
                  #link(github_url)[#serie]
                ] else [
                  #serie
                ]
              ]
            ]
          ]
        ]
      ]
    })
  ]
]
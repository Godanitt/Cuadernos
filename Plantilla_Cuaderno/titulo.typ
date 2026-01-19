#let make_title(
  primary: color,
  seccond: color,
  third: color,
  accent: color,
  image: none,
  title: str,
  subtitle: "",
  author: [],        // AHORA ES ARRAY
  github_url: "https://github.com/Godanitt/Cuadernos",
) = [
  // Fondo completo
  #set page(margin: 0cm)
  
  #rect(width: 100%, height: 100%, fill: gradient.linear(
    angle: 40deg,

    //..color.map.cividis,
    (primary, 0%),
    (seccond, 50%),
    (third, 100%),
  ))[
    #move(dx: 0cm, dy: 2.5cm)[  ]
    
    #v(1.5cm)
    #h(0.5cm)


    // Imagen opcional centrada
    #if image != none [
      #align(center)[#image(image, width: 70%)]
      #v(1cm)
    ]

    
    // Autor
    #move(dx: 2.5cm, dy: 1cm)[
      #box(
        width: 100%,
        inset: (left: 1cm, top: 0.7cm, bottom: 0.7cm),
        fill: rgb(100%, 100%, 100%, 10%),
        stroke: 0pt + accent,
        radius: 0pt,
      )[
        #if author != "" [
          #align(left)[
            #for a in author {
            text(size: 22pt, fill: accent, weight: "bold")[#a #v(6pt)]                   
            }
          ]
        ]
      ]
    ]

    // Título
    #move(dx: 2.5cm, dy: 0.55cm)[

      #box(
        width: 100%,
        inset: (left: 1cm, top: 0.7cm, bottom: 20cm),
        fill: rgb(100%, 100%, 100%, 15%),     // blanco translúcido  
        stroke: 0pt + accent,
        radius: 0pt,
        )[

        #align(left)[
          #block(width: 80%)[
            #text(size: 62pt, weight: "bold", fill: accent)[#title]
          ]
        ]

        #if subtitle != "" [
          #v(1cm)
          #align(left)[
            #block(width: 75%)[
              #text(size: 22pt, style: "italic", fill: accent)[#subtitle]
            ]
          ]
        ]
      ]
    ] 
    

    
  ]
]

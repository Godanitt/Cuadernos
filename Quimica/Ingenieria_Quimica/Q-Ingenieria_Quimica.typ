#import "../../plantilla.typ": *

#show: book.with(
  title: "Ingeniería Química",
  subtitle: "",
  typography: "Libertinus Serif",
  math-typography: "Libertinus Math",
  date: datetime.today,
  author: ("Daniel Vázquez Lago","María Álvarez Barciela"),
  main-color: rgb("#0789a0"),
  seccond-color: rgb("#39a2b5"),
  third-color: rgb("#87cedb"),
  lang: "es",
  cover: none,
  image-index: none,
  list-of-figure-title: "List of Figures",
  list-of-table-title: "List of Tables",
  supplement-chapter: "Chapter",
  supplement-part: "Part",
  font-size: 12pt,
  part-style: 0,
  copyright: [
    Template based on "typst-orange-template"
    
    © 2023 Flavio Barisi (Apache 2.0)

    Modifications in the template by

    © 2025 Daniel Vázquez Lago 

    and content of "Ingeniería Química" made by

    © 2025 María Álvarez Barciela

    All original content, modifications, and extensions contained in this document are the intellectual property of the authors.

  ],
  lowercase-references: false,
  heading-style-compact: true,
  first-line-indent: false,
)


//#part("Ingeniería") 

#chapter("La ingeniería Química y los Procesos Químicos")
#include "Capitulos/Introduccion.typ"

#chapter("Principios de Conservación: Balances de Materia")
#include "Capitulos/BalancesMateria.typ"

#chapter("Principios de Conservación: Balances de Energía")
#include "Capitulos/BalanceEnergia.typ"

#chapter("Flujo de fluidos")
#include "Capitulos/TrasferenciaFluidos.typ"

#chapter("Trasferencia de calor")
#include "Capitulos/Trasferencia_Calor.typ"

#chapter("Procesos de separación")
#include "Capitulos/Procesos_Separacion.typ"

#nocite(<calleja2008>)
#nocite(<himmelblau2002>)

#my-bibliography( bibliography("sample.bib"))

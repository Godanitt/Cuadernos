#import "../../plantilla.typ": *



#show: book.with(
  title: "Teoría de Grupos",
  subtitle: " ",
  typography: "Libertinus Serif",
  math-typography: "Libertinus Math",
  date: datetime.today,
  author: ("Daniel Vázquez Lago",""),
  main-color: rgb("#ee9b64"),
  seccond-color: rgb("#e06c29"),
  third-color:rgb("#d13c5c"),
  lang: "es",
  cover: none,
  image-index: none,
  list-of-figure-title: "List of Figures",
  list-of-table-title: "List of Tables",
  supplement-chapter: "Capítulo",
  supplement-part: "Parte",
  font-size: 12pt,
  part-style: 0,
  copyright: [
    Copyright © 2023 Flavio Barisi

    PUBLISHED BY PUBLISHER

    #link("https://github.com/flavio20002/typst-orange-template", "TEMPLATE-WEBSITE")

    Licensed under the Apache 2.0 License (the “License”).
    You may not use this file except in compliance with the License. You may obtain a copy of
    the License at https://www.apache.org/licenses/LICENSE-2.0. Unless required by
    applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.


    _First printing, July 2023_
  ],
  lowercase-references: false,
  heading-style-compact: true,
  first-line-indent: false,
)


//==================================================//

#part("Introducción y Grupos Discretos")

#chapter("Introducción a la Teoría de Grupos")
#include "Capitulos/Introduccion.typ"
#pagebreak()
#include "Ejercicios/Introduccion.typ"

#chapter("Homomorfismos y Reducibilidad")
#include "Capitulos/Homomorfismos.typ"
#pagebreak()
#include "Ejercicios/Homomorfismos.typ"

#chapter("Grupos finitos")
#include "Capitulos/GruposFinitos.typ"
#pagebreak()
#include "Ejercicios/GruposFinitos.typ"


//===============================================//

#part("Grupos Continuos")
#chapter("Grupos de Lie")
#include "Capitulos/GruposLie.typ"
#pagebreak()
#include "Ejercicios/GruposLie.typ"



//==============================================//

#part("Teoría de Grupos aplicada a la física")

#chapter("Rotaciones")
== Grupo $O(3)$
== Grupo $ S U (2)$

#chapter("Ecuacón de Dirac")


== Hamiton, Clifford y Dirac
== Álgebra de Dirac


#chapter("Campos de Yang-Milles")

== Teorema de Noeteher para Simetrías Internas
== El Nucleón de Yangs-Milles

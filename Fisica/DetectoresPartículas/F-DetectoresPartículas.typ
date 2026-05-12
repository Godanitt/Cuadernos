#import "../../plantilla.typ": *



#show: book.with(
  title: "Detectores en Física Nuclear y de Partículas",
  subtitle: "Fundamentos, Ejemplos y Simulaciones",
  date: datetime.today,
  author: ("Daniel Vázquez Lago",""),
  main-color: rgb("#0d2871"),
  seccond-color: rgb("#4e5761c4"),
  third-color: rgb("#e9be3b"),
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


#part("Interacción radiación–materia")
#chapter("")

#part("Electrónica")
#chapter("")

#part("Estadística")
#chapter("")

#part("Aceleradores")
#chapter("Sincrotrón")
#include "Capitulos/Sincrotron.typ"

#part("Detectores")

#chapter("Indentificación de Partículas")

#chapter("Detectores Gaseosos")

#chapter("Detectores de Fotones")

#chapter("Detectores Centelleadores")

#chapter("Detectores Semiconductores")

#chapter("Detectores Cherenkov")

#chapter("Espectrómetros de muones")

#chapter("Calorímetros")
#include "Capitulos/Calorimetros.typ"

#chapter("Detectores de Estado Sólido")

#part("Simulación en física de detectores")
#chapter("")

#part("Aplicaciones")

#chapter("Detectores en Grandes Experimentos")
#include "Capitulos/DetectoresGrandesExp.typ"

#chapter("")

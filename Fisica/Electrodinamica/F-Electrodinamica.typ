#import "../../plantilla.typ": *



#show: book.with(
  title: "Electrodinámica",
  subtitle: "",
  date: datetime.today,
  author: ("Daniel Vázquez Lago",""),
  main-color: rgb("#ca0d0d"),
  lang: "es",
  cover: none,
  image-index: none,
  list-of-figure-title: "List of Figures",
  list-of-table-title: "List of Tables",
  supplement-chapter: "Chapter",
  supplement-part: "Part",
  font-size: 11pt,
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

#chapter("Análisis Vectorial")

#part("Electrostática")
#chapter("Electrostática")
#chapter("Condiciones de frontera en Electrostática")
#chapter("Campos eléctricos en medios materiales")

#part("Magnetostática")
#chapter("Magnetostática")
#chapter("Campos magnéticos en medios materiales")
#chapter("Materiaels Magnéticos")

#part("Electrodinámica")

#chapter("Electrodinámica")
#chapter("Leyes de Conervación")
#chapter("Ondas electromagnéticas")
#chapter("Guidas de Ondas")
#chapter("Relatividad especial")
#chapter("Electrodinámica Relativista")

#part("Radiación")

#chapter("Sistemas Radiantes: multipolos")
#chapter("Radiación de Partículas en Movimiento")
#chapter("Colisiones entre partículas y pérdidas de energía")



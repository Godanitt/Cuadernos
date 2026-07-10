#import "../../../plantilla/plantilla.typ": *



#show: book.with(
  title: "Física de Semiconductores y Electrónica",
  subtitle: "",
  series: "Series Ciencias Físicas",
  volume: "F-03",
  date: datetime.today,
  author: ("Daniel Vázquez Lago",""),
  main-color: rgb("#0d2871"),
  seccond-color: rgb("#3c4f82"),
  third-color: rgb("#60709b"),
  lang: "es",
  cover: "Imagenes/electronic_physics.png",
  format: "fullimage",
  image-index: none,
  list-of-figure-title: "List of Figures",
  list-of-table-title: "List of Tables",
  supplement-chapter: "Chapter",
  supplement-part: "Part",
  font-size: 11pt,
  part-style: 0,
  cover-zoom: 1.10,
  cover-dx: 0cm,
  cover-dy: 0cm,
  copyright: [
    Copyright © 2023 Flavio Barisi

    PUBLISHED BY PUBLISHER

    #link("https://github.com/flavio20002/typst-orange-template", "TEMPLATE-WEBSITE")

    Licensed under the Apache 2.0 License (the “License”).
    You may not use this file except in compliance with the License. You may obtain a copy of
    the License at https://www.apache.org/licenses/LICENSE-2.0. Unless reequired by
    applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.


    _First printing, July 2023_
  ],
  lowercase-references: false,
  heading-style-compact: true,
  first-line-indent: false,
)

#part("Introducción")
#chapter("Mecánica Cuántica Relativista")
#part("Teoría Cuántica de Campos")

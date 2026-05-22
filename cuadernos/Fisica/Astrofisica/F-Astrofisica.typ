#import "../../../plantilla/plantilla.typ": *

#let H1 = $"H"$
#let H2 = $""^2"H"$
#let He3 = $""^3"He"$
#let He4 = $""^4"He"$
#let Li7 = $""^7"Li"$


#show: book.with(
  title: "Astrofísica y Cosmología",
  subtitle: "",
  series: "Series Ciencias Físicas",
  date: datetime.today,
  author: ("Daniel Vázquez Lago",""),
  main-color: rgb("#0d2871"),
  seccond-color: rgb("#3c4f82"),
  third-color: rgb("#60709b"),
  lang: "es",
  cover: "Imagenes/Astrofisica.jpg",
  image-index: none,
  list-of-figure-title: "List of Figures",
  list-of-table-title: "List of Tables",
  supplement-chapter: "Chapter",
  supplement-part: "Part",
  font-size: 12pt,
  part-style: 0,
  format: "cover1",
  copyright: [
    // Copyright © 2023 Flavio Barisi

    // PUBLISHED BY PUBLISHER

    // #link("https://github.com/flavio20002/typst-orange-template", "TEMPLATE-WEBSITE")

    // Licensed under the Apache 2.0 License (the “License”).
    // You may not use this file except in compliance with the License. You may obtain a copy of
    // the License at https://www.apache.org/licenses/LICENSE-2.0. Unless required by
    // applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    // See the License for the specific language governing permissions and limitations under the License.


    // _First printing, July 2023_
  ],
  lowercase-references: false,
  heading-style-compact: true,
  first-line-indent: false,
)

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.5em,
)

#part("Astrofísica Nuclear")

#chapter("Introducción")

#part("Nucleosíntesis Estelar y Primordial")

#chapter("Introducción")

// #chapter("Mecánica y Equilibrio Térmico")

// #chapter("Ecuaciones de Estado Nuclear")

#chapter("Nucleosíntesis en el Big Bang")

Después del confinamiento de los quarks y de la transición a los hadrones, el universo temprano hecho de hadrones, leptones y fotones, con una pequeña asimetría materia-antimateria.


En los primeros modelos del Big-Bang, algunos elementos podían sintetizarse, al menos en el tiempo en el que la temperatura y densidad eran apropiadas para que ocurrieran las reacciones nucleares. En estas condiciones los modelos predicen la creación de las primeras especies ligeras como #H2, #He3, #He4 y #Li7, y se predijo la observación del fondo cósmico de microondas. Podemos obersvar diferentes procesos en función que trascurrió desde el Big-Bang

- A $t=0.5" s"$ y $T_9 ~ 15$ la expansión 

// #chapter("Modelos Politrópicos Estelares")

// #chapter("Transporte de Energía en el Interior Estelar")

// #chapter("Procesos Nucleares en Estrellas")

// #chapter("Modelos Estelares y Estabilidad Estelar")

// #chapter("Evolución Estelar y Teorema del Virial")

// #chapter("Primeras fases de evolución estelar")

// #chapter("Evolución no-secuencia principal: quemado de helio")

// #chapter("Evolución tardía de estrellas pequeñas y medianas")

// #chapter("Evoulción de estrellas masivas: presupernova")

// #chapter("Evoulción de estrellas masivas: supernovas y remanentes")


#part("Cosmología")
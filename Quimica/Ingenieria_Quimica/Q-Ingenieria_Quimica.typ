#import "../../Plantilla_Cuaderno/plantilla.typ": *



#show: book.with(
  title: "Ingeniería Química",
  subtitle: "A Practical Guide",
  date: datetime.today,
  author: ("Daniel Vázquez Lago","María Álvarez Barciela"),
  main-color: rgb("#0a6f81"),
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


//#part("Ingeniería") 

#chapter("La ingeniería Química y los Procesos Químicos")
#include "Capitulos/Introduccon.typ"

#chapter("Principios de Conservación: Balances de Materia")
#include "Capitulos/BalancesMateria.typ"

#chapter("Principios de Conservación: Balances de Energía")
#include "Capitulos/BalanceEnergia.typ"

#chapter("Flujo de fluidos")
#include "Capitulos/Flujo_Fluidos.typ"

#chapter("Trasferencia de calor")
#include "Capitulos/Trasferencia_Calor.typ"

#chapter("Procesos de separación")
#include "Capitulos/Procesos_Separacion.typ"



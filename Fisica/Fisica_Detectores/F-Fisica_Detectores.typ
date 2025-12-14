#import "../../plantilla.typ": *



#show: book.with(
  title: "Física de Detectores",
  subtitle: " ",
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


#part("Interacción radiación–materia")

#chapter("Naturaleza de la radiación")
#chapter("Interacción de partículas cargadas con la materia")
#chapter("Interacción de radiación electromagnética con la materia")
#chapter("Interacción de neutrones con la materia")
#chapter("Procesos microscópicos y secciones eficaces")
#chapter("Pérdida de energía y alcance de partículas")
#chapter("Fluctuaciones estadísticas y straggling")
#chapter("Producción secundaria y cascadas")


#part("Detectores")

#chapter("Principios generales de detección de radiación")
#chapter("Detectores gaseosos")
#chapter("Detectores de centelleo")
#chapter("Detectores semiconductores")
#chapter("Detectores de neutrones")
#chapter("Detectores de radiación Cherenkov y de transición")
#chapter("Electrónica asociada a detectores")
#chapter("Resolución, eficiencia y calibración")
#chapter("Tiempo, coincidencias y discriminación")
#chapter("Daño por radiación y envejecimiento de detectores")


#part("Simulación en física de detectores")


#chapter("Generación de eventos y fuentes de radiación")
#chapter("Modelos físicos de interacción radiación–materia")
#chapter("Transporte de partículas en la materia")
#chapter("Simulación de detectores y respuesta instrumental")
#chapter("Digitalización de señales")
#chapter("Tratamiento estadístico de los datos simulados")
#chapter("Validación y comparación con datos experimentales")
#chapter("GEANT4: fundamentos y arquitectura")
#chapter("Aplicaciones de la simulación en experimentos reales")

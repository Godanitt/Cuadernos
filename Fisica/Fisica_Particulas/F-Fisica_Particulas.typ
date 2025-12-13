#import "../../Plantilla_Cuaderno/plantilla.typ": *



#show: book.with(
  title: "Física de Partículas",
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

#part("Electrodinámica cuántica")

#chapter("Cuantización del campo electromagnético")
#chapter("Campos de Dirac y ecuación de Dirac")
#chapter("Simetría gauge U(1)")
#chapter("Interacción electrón–fotón")
#chapter("Reglas de Feynman en QED")
#chapter("Correcciones radiativas y renormalización")
#chapter("Dispersión y procesos fundamentales en QED")
#chapter("Anomalías y precisión en QED")


#part("Teoría electrodébil")

#chapter("Fundamentos de teorías gauge no abelianas")
#chapter("Simetría $ SU(2)_L \times U(1)_Y $")
#chapter("Campos fermiónicos y corrientes débiles")
#chapter("Ruptura espontánea de simetría")
#chapter("Mecanismo de Higgs")
#chapter("Bosones W y Z")
#chapter("Corrientes cargadas y neutras")
#chapter("Violación de paridad y estructura quiral")
#chapter("Pruebas experimentales de la teoría electrodébil")


#part("Cromodinámica cuántica")

#chapter("Carga de color y simetría SU(3)_C")
#chapter("Campos de quarks y gluones")
#chapter("Estructura no abeliana de QCD")
#chapter("Confinamiento y libertad asintótica")
#chapter("Reglas de Feynman en QCD")
#chapter("Renormalización y ecuaciones del grupo de renormalización")
#chapter("Hadronización y modelos fenomenológicos")
#chapter("Estados ligados: mesones y bariones")
#chapter("QCD en redes (Lattice QCD)")


#part("Modelo estándar")

#chapter("Estructura gauge del Modelo Estándar")
#chapter("Contenido de partículas fundamentales")
#chapter("Matriz CKM y violación CP")
#chapter("Masas y acoplamientos")
#chapter("Renormalización del Modelo Estándar")
#chapter("Predicciones de precisión y observables")
#chapter("Neutrinos y mezcla leptónica")
#chapter("Limitaciones del Modelo Estándar")
#chapter("Extensiones: más allá del Modelo Estándar")

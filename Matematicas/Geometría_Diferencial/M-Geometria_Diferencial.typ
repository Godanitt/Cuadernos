#import "../../plantilla.typ": *

#show: book.with(
  title: "Geometría Diferencial",
  subtitle: "Introducción a la Geometría de Riemann",
  typography: "Libertinus Serif",
  math-typography: "Libertinus Math",
  date: datetime.today,
  author: ("Daniel Vázquez Lago",""),
  main-color: rgb("#e8833f"),
  seccond-color: rgb("#e06c29"),
  third-color:rgb("#d13c5c"),
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


//==========================================//
// -- VARIEDADES --------------------------
//==========================================//
#part("Variedades Diferenciales")

#chapter("Variedades Diferenciales")
#include "Capitulos/Variedades.typ"
#chapter("Formas Diferenciables")
#chapter("Tensores y Formas Exteriores")
#chapter("Álgebra Exeterior")
#chapter("Integrales en Variedades")
#chapter("Derivada de Lie")
#chapter("Lema de Poincaré")

//==========================================//
// -- GEOMETRÍA DE RIEMANN ----------------
//==========================================//
#part("Geometría de Riemann")

#chapter("Métrica de Riemann")
#chapter("Conexiones")
#chapter("Conexiones de Levi-Civita")
#chapter("Geodésicas y Distancias")
#chapter("Curvatura")


/*
//==========================================//
// -- RELATIVIDAD GENERAL ---------.-------
//==========================================//
#part("Relatividad General")

#chapter("Principio de equivalencia")
#chapter("Espaciotiempo y métrica lorentziana")
#chapter("Conexión y derivada covariante en Relatividad General")
#chapter("Geodésicas relativistas")
#chapter("Curvatura del espaciotiempo")
#chapter("Tensor energía-momento")
#chapter("Ecuaciones de Einstein")

//==========================================//
// -- TEORIAS GAUGE  ----------------------
//==========================================//
#part("Teorías de Gauge")


#chapter("Simetrías y principios de gauge")
#chapter("Fibrados principales y asociados")
#chapter("Conexiones en fibrados")
#chapter("Teoría gauge abeliana: electromagnetismo")
#chapter("Teorías gauge no abelianas")
*/

//==========================================//
// -- BIBLIOGRAFIA -------------------------
//==========================================//

#nocite(<FrankelGeometryPhysics>)
#nocite(<gross2023manifolds>)
#nocite(<NakaharaGeometryTopologyPhysics>)
#nocite(<Szekeres_2004>)

#my-bibliography( bibliography("sample.bib",
style: "apa",)
)

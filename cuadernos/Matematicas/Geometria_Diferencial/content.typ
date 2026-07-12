// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

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


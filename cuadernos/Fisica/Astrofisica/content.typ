// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#let H1 = $"H"$
#let H2 = $""^2"H"$
#let He3 = $""^3"He"$
#let He4 = $""^4"He"$
#let Li7 = $""^7"Li"$

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

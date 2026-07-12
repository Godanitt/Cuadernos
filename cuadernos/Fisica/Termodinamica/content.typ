// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Fundamentos termodinámicos")

#chapter("Variables de estado y equilibrio")

#chapter("Primer principio")

#chapter("Segundo principio y entropía")

#chapter("Tercer principio")

#part-reading-list("fundamentos-termodinamicos")

#part("Potenciales y equilibrio")

#chapter("Potenciales termodinámicos")

#chapter("Relaciones de Maxwell")

#chapter("Estabilidad y equilibrio de fases")

#chapter("Sistemas abiertos y reacciones")

#part-reading-list("potenciales-y-equilibrio")

#part("Mecánica estadística clásica")

#chapter("Espacio de fases y ergodicidad")

#chapter("Ensamble microcanónico")

#chapter("Ensamble canónico")

#chapter("Ensamble gran canónico")

#part-reading-list("mecanica-estadistica-clasica")

#part("Estadística cuántica")

#chapter("Bosones y fermiones")

#chapter("Gas de Bose")

#chapter("Gas de Fermi")

#chapter("Radiación térmica")

#part-reading-list("estadistica-cuantica")

#part("Transiciones de fase y fenómenos críticos")

#chapter("Modelos de Ising y campo medio")

#chapter("Escalado y universalidad")

#chapter("Grupo de renormalización")

#chapter("Sistemas desordenados")

#part-reading-list("transiciones-de-fase-y-fenomenos-criticos")

#part("Procesos irreversibles")

#chapter("Transporte y difusión")

#chapter("Relaciones de Onsager")

#chapter("Ecuaciones cinéticas")

#chapter("Termodinámica fuera del equilibrio")

#part-reading-list("procesos-irreversibles")

#part("Sistemas complejos")

#chapter("Información y entropía")

#chapter("Redes y emergencia")

#chapter("Autoorganización")

#chapter("Aplicaciones interdisciplinarias")

#part-reading-list("sistemas-complejos")

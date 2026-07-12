// <cuadernos:auto-imports>
#import "../../../plantilla/plantilla.typ": *
#import "generated/part_references.typ": part-references

#let part-reading-list(slug) = part-bibliography(
  entries: part-references.at(slug, default: ()),
)
// </cuadernos:auto-imports>

#set par(justify: true, leading: 0.65em, spacing: 1.5em)

#part("Estructura atómica")

#chapter("Átomo de hidrógeno")

#chapter("Átomos multielectrónicos")

#chapter("Acoplamiento angular")

#chapter("Estructura fina e hiperfina")

#part-reading-list("estructura-atomica")

#part("Interacción radiación-materia")

#chapter("Transiciones electromagnéticas")

#chapter("Reglas de selección")

#chapter("Átomo de dos niveles")

#chapter("Campos intensos")

#part-reading-list("interaccion-radiacion-materia")

#part("Física molecular")

#chapter("Enlace molecular")

#chapter("Rotaciones y vibraciones")

#chapter("Estructura electrónica molecular")

#chapter("Dinámica molecular")

#part-reading-list("fisica-molecular")

#part("Espectroscopia")

#chapter("Espectroscopia atómica")

#chapter("Espectroscopia molecular")

#chapter("Resonancia magnética")

#chapter("Técnicas ultrarrápidas")

#part-reading-list("espectroscopia")

#part("Colisiones y materia fría")

#chapter("Colisiones atómicas")

#chapter("Átomos ultrafríos")

#chapter("Condensados de Bose-Einstein")

#chapter("Moléculas frías")

#part-reading-list("colisiones-y-materia-fria")

#part("Aplicaciones y métodos experimentales")

#chapter("Relojes atómicos")

#chapter("Trampas y enfriamiento láser")

#chapter("Metrología espectroscópica")

#chapter("Astrofísica y diagnóstico de plasmas")

#part-reading-list("aplicaciones-y-metodos-experimentales")

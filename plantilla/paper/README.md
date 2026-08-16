# Plantillas de paper

`paper.typ` es la entrada común para todos los artículos. Actúa como dispatcher
y mantiene el cuerpo del paper independiente del formato editorial.

## Estilos

- `elsevier` (por defecto) → `@preview/elspub:1.0.0`
- `ieee` → `@preview/charged-ieee:0.1.4`
- `mdpi` → `@preview/splendid-mdpi:0.1.0`

Los adaptadores específicos son:

```text
paper.typ
├── elsevier.typ
├── ieee.typ
└── mdpi.typ
```

Un paper normal importa únicamente `paper.typ`:

```typst
#import "../../../plantilla/paper/paper.typ": paper-template
```

El estilo se selecciona en `paper.style`. Si no existe ese campo, el dispatcher
usa Elsevier.

La carpeta `cuadernos/paper/Photoabsorption_Photoionization_Gases/` contiene un
ejemplo mínimo que define los perfiles de autor de los tres formatos y reutiliza
exactamente el mismo cuerpo científico.

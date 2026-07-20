# Plantilla compartida

Aquí vive únicamente el código común de presentación:

- `plantilla.typ`: macros, entornos y función `cuaderno`.
- `Plantilla_Cuaderno/`: índices, títulos, teoremas, comandos y diseños de portada.
- `../run_all.py`: flujo completo del repositorio.

Cada main importa:

```typst
#import "../../../plantilla/plantilla.typ": *
// El main carga sus recursos locales y los pasa a `cuaderno`.
#show: cuaderno.with(
  meta: notebook,
  cover-source: cover-source,
  bibliography-source: bibliography-source,
)
```

Las imágenes de portada no se guardan aquí. Cada una vive en `Imagenes/` dentro de su cuaderno.

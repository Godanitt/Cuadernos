# Arquitectura editorial automática

El proyecto se gobierna mediante manifiestos. No hay que registrar cuadernos a mano en listas Python ni editar el README para añadir un volumen.

## Flujo principal

```bash
python -m cuadernos update
```

El comando realiza, en orden:

1. Busca recursivamente todos los archivos `cuaderno.toml` dentro de `cuadernos/`.
2. Sincroniza las partes del manifiesto con las partes activas de `content.typ`.
3. Genera `generated/config.typ` y `generated/part_references.typ`.
4. Recupera una portada desde un PDF antiguo cuando falta el fondo; si no existe, crea una provisional.
5. Valida IDs, rutas, fuentes, portadas y claves BibTeX.
6. Compila únicamente los volúmenes cuyo hash ha cambiado.
7. Extrae la primera página de cada PDF como preview.
8. Regenera README raíz, README de área, README individual, catálogos y panel de salud.

## Flujo de datos

```text
cuadernos.toml
   └── áreas, orden, prefijos, series y valores globales

cuadernos/**/cuaderno.toml
   ├── generated/config.typ
   ├── generated/part_references.typ
   ├── README individual
   ├── README de área
   ├── README raíz
   ├── docs/catalog.json
   ├── docs/HEALTH.md
   └── bibliografia/catalogo.bib

content.typ + #include
   ├── partes y capítulos del catálogo
   ├── métricas estructurales
   └── dependencias de compilación

PDF compilado
   └── docs/assets/previews/<ID>.png
```

## Estructura de un volumen

```text
<Cuaderno>/
├── cuaderno.toml
├── main.typ o <codigo>.typ
├── content.typ
├── Partes/
├── Capitulos/
├── Ejercicios/
├── Soluciones/
├── Imagenes/
├── Bibliografia/
│   └── referencias.bib
└── generated/
    ├── config.typ
    ├── part_references.typ
    └── cover-placeholder.svg o cover-extracted.png
```

El archivo principal solo importa la plantilla, la configuración generada y `content.typ`. La bibliografía general se coloca automáticamente al final cuando el archivo BibTeX contiene entradas.

## Descubrimiento automático

Cualquier carpeta que contenga un `cuaderno.toml` válido se incorpora al proyecto. Esto funciona también con áreas nuevas. Por ejemplo:

```bash
python -m cuadernos new \
  --area Medicina \
  --title "Fundamentos biomédicos de la medicina" \
  --part "Anatomía y fisiología" \
  --part "Patología general"
```

El ID, slug, carpeta y entrada del catálogo se generan automáticamente.

## Progreso automático

Por defecto, `[progress].mode = "auto"`. El gestor calcula:

- Texto a partir de palabras por capítulo.
- Figuras por capítulo.
- Ejercicios por capítulo.
- Referencias por parte.
- Revisión a partir del estado editorial del cuaderno.

La ponderación global es 45 % texto, 15 % figuras, 15 % ejercicios, 10 % bibliografía y 15 % revisión. Los objetivos pueden ajustarse en cada manifiesto. Para fijar valores manuales, usa `mode = "manual"`.

## Bibliografía por parte

Las claves se guardan en cada bloque `[[parts]]`:

```toml
[[parts]]
title = "Geometría de Riemann"
slug = "geometria-de-riemann"
status = "draft"
references = [
  "FrankelGeometryPhysics",
  "NakaharaGeometryTopologyPhysics",
]
```

La CLI comprueba que existan en `Bibliografia/referencias.bib` y genera una lista formateada con DOI y URL cuando están disponibles:

```typst
#part-reading-list("geometria-de-riemann")
```

## Compilación incremental

El hash incluye manifiesto, fuentes, bibliografía, imágenes, plantilla compartida y configuración del proyecto. Si no cambia y el PDF existe, el volumen se omite.

## Archivos generados

No edites a mano `generated/`, los README de catálogo, los previews ni los JSON. Las fuentes de verdad son `cuadernos.toml`, cada `cuaderno.toml`, el contenido Typst y los BibTeX locales.

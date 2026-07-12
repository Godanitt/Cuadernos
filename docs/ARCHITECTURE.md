# Arquitectura editorial automática

El proyecto se gobierna mediante manifiestos. No hay que registrar cuadernos a mano en listas Python ni editar el README para añadir un volumen.

## Flujo principal

```bash
python -m cuadernos update
```

El comando realiza, en orden:

1. Busca recursivamente todos los archivos `cuaderno.toml` dentro de `cuadernos/`.
2. Migra de forma idempotente los cuadernos antiguos al formato de bibliografía global.
3. Sincroniza las partes del manifiesto con las partes activas de `content.typ`.
4. Genera `generated/config.typ`.
5. Valida IDs, rutas, fuentes, portadas, configuración de Tinymist y claves BibTeX.
6. Detecta todos los documentos principales, incluidos los cuadernos recién añadidos.
7. Compila incrementalmente con Tinymist y actualiza un único `tinymist.lock`.
8. Extrae la primera página de cada PDF como preview.
9. Regenera README raíz, README de área, README individual, catálogos y panel de salud.

Tinymist escribe una base de proyectos compartida, por lo que estas compilaciones se ejecutan en serie. Solo se compilan los cuadernos modificados o aquellos cuya ruta todavía no aparece en `tinymist.lock`.

## Flujo de datos

```text
cuadernos.toml
   └── áreas, orden, prefijos, series y valores globales

cuadernos/**/cuaderno.toml
   ├── generated/config.typ
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

Tinymist
   ├── pdf/<salida>.pdf
   └── tinymist.lock

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
    └── cover-placeholder.svg o cover-extracted.png
```

El archivo principal importa la plantilla, la configuración generada y `content.typ`. Cuando el BibTeX contiene entradas, se imprime una única bibliografía completa al final del PDF.

## Descubrimiento automático

Cualquier carpeta que contenga un `cuaderno.toml` válido se incorpora al proyecto, también dentro de áreas nuevas. Por ejemplo:

```bash
python -m cuadernos new \
  --area Medicina \
  --title "Fundamentos biomédicos de la medicina" \
  --part "Anatomía y fisiología" \
  --part "Patología general"

python -m cuadernos update
```

El ID, slug, carpeta, documento principal, ruta de Tinymist y entrada del catálogo se generan automáticamente.

## Resolución multifichero con Tinymist

La configuración versionada en `.vscode/settings.json` activa:

```json
{
  "tinymist.rootPath": "${workspaceFolder}",
  "tinymist.projectResolution": "lockDatabase",
  "tinymist.exportPdf": "never"
}
```

El gestor detecta automáticamente si la versión instalada usa `--lockfile` o `--save-lock`. También busca el ejecutable en `PATH`, en `TINYMIST_BIN` y en instalaciones habituales de extensiones de VS Code, VS Code Server y Cursor.

Si `tinymist.lock` falta, está dañado o conserva rutas de cuadernos eliminados, se reconstruye. Para forzarlo manualmente:

```bash
python -m cuadernos update --rebuild-lock
```

## Progreso automático

Por defecto, `[progress].mode = "auto"`. El gestor calcula:

- Texto a partir de palabras por capítulo.
- Figuras por capítulo.
- Ejercicios por capítulo.
- Referencias por parte.
- Revisión a partir del estado editorial del cuaderno.

La ponderación global es 45 % texto, 15 % figuras, 15 % ejercicios, 10 % bibliografía y 15 % revisión. Los objetivos pueden ajustarse en cada manifiesto. Para fijar valores manuales, usa `mode = "manual"`.

## Bibliografía general y lecturas por parte

Cada cuaderno usa un único archivo BibTeX, normalmente `Bibliografia/referencias.bib`. Las claves pueden seleccionarse para cada bloque `[[parts]]`:

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

En cada `update`, el gestor genera `generated/part_references.typ`, que exporta directamente la función, y garantiza al comienzo de `content.typ`:

```typst
#import "generated/part_references.typ": part-reading-list
```

Al final de cada parte mantiene:

```typst
#part-reading-list("geometria-de-riemann")
```

Esa llamada no imprime nada cuando `references = []`. Cuando hay claves, muestra una lista breve titulada **Bibliografía y lecturas recomendadas**, con DOI o enlace cuando estén disponibles.

El archivo principal conserva además la bibliografía general clásica al final:

```typst
#if bibliography-enabled {
  my-bibliography(
    bibliography(bibliography-file, title: "Bibliografía", full: true)
  )
}
```

Por tanto, las listas de cada parte funcionan como selección de lectura y la bibliografía final funciona como catálogo completo del volumen.

## Compilación incremental

El hash incluye manifiesto, fuentes, bibliografía, imágenes, plantilla compartida, configuración del proyecto y ajustes de VS Code. Si no cambia, el PDF existe y la ruta está registrada en `tinymist.lock`, el volumen se omite.

## Archivos generados

No edites a mano `generated/`, los README de catálogo, los previews, los JSON ni `tinymist.lock`. Las fuentes de verdad son `cuadernos.toml`, cada `cuaderno.toml`, el contenido Typst y los BibTeX locales.

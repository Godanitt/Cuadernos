# Esquema de `cuaderno.toml`

## Metadatos principales

```toml
schema = 1
id = "F-08"
slug = "fisica-de-particulas-y-teoria-cuantica-de-campos"
title = "Física de Partículas y Teoría Cuántica de Campos"
area = "Fisica"
status = "development"
authors = ["Daniel Vázquez Lago"]
main_file = "F-Fisica_Particulas.typ"
content_file = "content.typ"
output_file = "F-Fisica_Particulas.pdf"
bibliography_file = "Bibliografia/referencias.bib"
```

No hay que añadir el cuaderno a ninguna lista adicional. `python -m cuadernos update` lo detecta mediante búsqueda recursiva.

## Estado editorial

Estados de cuaderno:

- `planned`
- `skeleton`
- `development`
- `usable`
- `stable`
- `paused`

Estados de parte:

- `planned`
- `outline`
- `draft`
- `review`
- `stable`

## Progreso

```toml
[progress]
mode = "auto" # auto | manual
text = 0
figures = 0
exercises = 0
bibliography = 0
review = 0
target_words_per_chapter = 1500
target_figures_per_chapter = 1.0
target_exercises_per_chapter = 2.0
target_references_per_part = 4.0
```

En modo automático, los cinco valores manuales se ignoran y se calculan a partir del contenido. En modo manual, se utilizan exactamente los porcentajes escritos.

## Portada

```toml
[cover]
style = "fullimage" # solid | fullimage | wiley | wiley2
image = "Imagenes/particle_physics.png"
theme = "dark"
zoom = 1.1
dx_cm = 0.0
dy_cm = 0.0
text_color = "auto"
```

Si la imagen no existe, el gestor intenta extraer automáticamente la imagen incrustada de la primera página de un PDF antiguo. Si tampoco hay PDF, genera un fondo SVG provisional para que el cuaderno siga compilando.

## Configuración Typst

```toml
[typst]
series = "Series Ciencias Físicas"
date = "today"
font_size_pt = 11
main_color = "#0d2871"
secondary_color = "#3c4f82"
tertiary_color = "#60709b"
part_style = 0
```

Las áreas, sus prefijos y sus series por defecto se configuran una sola vez en `cuadernos.toml`.

## Partes y referencias bibliográficas

```toml
[[parts]]
title = "Teoría cuántica de campos"
slug = "teoria-cuantica-de-campos"
status = "outline"
summary = ""
references = ["peskin1995", "weinberg1995"]
```

`python -m cuadernos update` actualiza automáticamente la lista de partes a partir de `content.typ`, conservando estado, resumen y referencias cuando el slug no cambia. Las claves se validan y cuentan por parte, pero todas las entradas del BibTeX se imprimen una única vez en la bibliografía final del PDF.

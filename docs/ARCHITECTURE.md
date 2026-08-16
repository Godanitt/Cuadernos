# Arquitectura editorial

El repositorio tiene dos clases de documentos Typst completamente separadas en origen y salida.

```text
cuadernos/<Área>/<Cuaderno>/  ->  pdf/<Cuaderno>.pdf
cuadernos/paper/<Paper>/      ->  paper/<Paper>.pdf
```

`cuadernos/paper/` queda excluido del descubrimiento de áreas: un paper nunca se convierte accidentalmente en un cuaderno.

## Cuadernos

Cada cuaderno es una carpeta autocontenida:

```text
cuadernos/<Área>/<Cuaderno>/
├── <principal>.typ
├── referencias.bib
├── Capitulos/
├── Imagenes/
└── data/
```

El main contiene el bloque `notebook`, aplica `plantilla/cuaderno.typ` y define el orden de partes/capítulos. La salida vive en `pdf/`.

## Papers

Los papers viven exclusivamente bajo:

```text
cuadernos/paper/
```

La organización recomendada es:

```text
cuadernos/paper/<Paper>/
├── <principal>.typ
├── referencias.bib
├── Imagenes/
└── data/
```

El main contiene un bloque `paper` y declara uno de tres estilos: `ieee`, `elsevier` o `mdpi`. Sus adaptadores comunes viven en `plantilla/paper/`. La salida vive en `paper/`.

## Flujo principal

```bash
python run_all.py
```

Actualiza **cuadernos y papers** de forma incremental.

También se puede limitar el target:

```bash
python run_all.py cuadernos
python run_all.py cuadernos Fisica
python run_all.py paper
python run_all.py paper P-MiArticulo
```

`--force` fuerza los documentos seleccionados y `--rebuild-lock` reconstruye el `tinymist.lock` usando todo el inventario.

## Compilación incremental

Cada documento tiene su propio hash. Un cuaderno depende de su carpeta y de la plantilla normal; un paper depende de su carpeta y de `plantilla/paper/`. Por tanto, cambiar una plantilla de paper no invalida los 80 cuadernos normales, y viceversa.

## Archivos derivados

Se pueden regenerar y no forman parte de la fuente esencial:

- `pdf/`
- `paper/`
- `.cuadernos-cache/`
- `docs/assets/previews/`
- `docs/catalog.json`
- `docs/HEALTH.md`
- `docs/VALIDATION.md`
- `tinymist.lock`

# Aplicación del sistema automático

Este parche contiene únicamente Python, Typst, configuración y documentación. No incluye PDF, portadas ni previews.

## Aplicarlo

Extrae la carpeta `Cuadernos/` sobre la raíz de tu repositorio y ejecuta:

```bash
python -m cuadernos update
```

El comando descubre todos los `cuaderno.toml`, genera el módulo autocontenido de lecturas bibliográficas, importa `part-reading-list` dentro de cada `content.typ`, valida el proyecto, compila incrementalmente con Tinymist, actualiza `tinymist.lock` y reconstruye el README.

## Primer uso o reparación de Tinymist

La configuración de VS Code ya está incluida en `.vscode/settings.json`. Si quieres reconstruir completamente las rutas de todos los cuadernos:

```bash
python -m cuadernos update --rebuild-lock
```

El gestor detecta versiones de Tinymist con `--lockfile` y con `--save-lock`. Si el ejecutable no está en `PATH`, puedes indicar su ruta:

```bash
TINYMIST_BIN=/ruta/a/tinymist python -m cuadernos update
```

## Añadir un cuaderno de Medicina

```bash
python -m cuadernos new \
  --area Medicina \
  --title "Fundamentos biomédicos de la medicina" \
  --part "Anatomía y fisiología" \
  --part "Patología general"

python -m cuadernos update
```

El gestor asigna el ID (`MED-01`, `MED-02`, ...), crea la estructura y lo añade automáticamente al README y a `tinymist.lock`.

También puedes crear manualmente una carpeta con un `cuaderno.toml`; será descubierta en el siguiente `update`.

## Bibliografía

Cada cuaderno mantiene `Bibliografia/referencias.bib`. Las claves asignadas mediante `references = [...]` se muestran como lecturas recomendadas al final de su parte. La bibliografía general completa se imprime además una vez al final del PDF.

## Solo regenerar documentación

```bash
python -m cuadernos update --no-build
```

Este modo no compila y, por tanto, no modifica `tinymist.lock`.

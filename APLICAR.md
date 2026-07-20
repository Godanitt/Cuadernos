# Corrección de `missing argument: body`

Copia el contenido de este parche sobre la raíz del repositorio y permite sobrescribir archivos.

La corrección principal cambia la firma de la plantilla a:

```typst
#let cuaderno(meta: (:), cover-source: none, bibliography-source: none, body) = {
```

`meta` debe ser un argumento nombrado porque los mains lo fijan mediante
`cuaderno.with(meta: notebook, ...)`; así el único argumento que deja pendiente
el `show` global es `body`.

Después ejecuta:

```bash
python3 run_all.py
```

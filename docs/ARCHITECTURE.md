# Arquitectura editorial

Cada cuaderno es una carpeta autocontenida. No hay manifiestos TOML ni archivos Typst generados dentro de los volúmenes.

## Estructura de un cuaderno

```text
cuadernos/<Área>/<Cuaderno>/
├── <principal>.typ
├── referencias.bib
├── Capitulos/
├── Imagenes/
└── data/
```

El archivo principal —por ejemplo `F-Electrodinamica.typ` o `M-AnalisisComplejo.typ`— contiene:

1. El bloque `notebook` con título, ID, portada, autores, salida PDF y configuración.
2. La aplicación de la plantilla común.
3. El orden de partes y capítulos.
4. Las inclusiones de `Capitulos/`.

Los ejercicios se escriben al final del archivo del capítulo correspondiente. La portada y el resto de figuras viven en `Imagenes/`. Los CSV, JSON, tablas y materiales auxiliares viven en `data/`.

## Flujo principal

```bash
python run_all.py
```

Equivale a:

```bash
python -m cuadernos update
```

El gestor:

1. Busca mains Typst con el bloque `// <cuadernos:metadata>`.
2. Lee el diccionario `notebook` directamente del main.
3. Analiza las partes, capítulos, figuras, ejercicios y referencias.
4. Valida IDs, portadas, bibliografías y rutas.
5. Compila solo los cuadernos modificados.
6. Actualiza `tinymist.lock`, README y catálogos.

No crea `generated/`, no extrae portadas dentro del cuaderno y no copia imágenes.

## Añadir un cuaderno

Copia una carpeta existente, renombra su main y edita el bloque `notebook` del principio. Después ejecuta `run_all.py`.

No hay que ejecutar un comando de alta ni editar una lista central.

## Compilación incremental

El hash incluye el main, `Capitulos/`, `Imagenes/`, `data/`, `referencias.bib`, la plantilla y la configuración global. Si nada cambia y el PDF existe, el cuaderno se omite.

## Archivos derivados

Fuera de los cuadernos se regeneran:

- `README.md` y los README de área.
- `docs/catalog.json`.
- `docs/HEALTH.md` y `docs/VALIDATION.md`.
- `docs/assets/previews/`.
- `bibliografia/catalogo.bib`.
- `tinymist.lock`.

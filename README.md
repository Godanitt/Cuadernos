# Cuadernos

Repositorio reorganizado para separar claramente plantilla, fuentes de los cuadernos y PDFs compilados.

## Estructura

```text
Cuadernos/
├── plantilla/      # plantilla Typst común, módulos base y scripts de compilación
├── cuadernos/      # fuentes de cada cuaderno, agrupadas por área
├── pdf/            # PDFs compilados finales
├── typst.toml      # metadatos del proyecto Typst
└── README.md       # esta guía
```

## Cómo compilar todo

Desde la raíz del proyecto:

```bash
python plantilla/scripts/run_all.py
```

El script busca automáticamente los `.typ` principales dentro de `cuadernos/<area>/<cuaderno>/` y deja los PDFs en `pdf/`.

También puedes compilar un cuaderno individual, por ejemplo:

```bash
typst compile cuadernos/Fisica/Electrodinamica/F-Electrodinamica.typ pdf/F-Electrodinamica.pdf --root .
```

## Convención de cada cuaderno

Cada cuaderno debería seguir esta estructura:

```text
cuadernos/<Area>/<Nombre_Cuaderno>/
├── <archivo-principal>.typ
├── Capitulos/
├── Ejercicios/
├── Imagenes/
├── sample.bib
└── README.md
```

Los PDFs no se guardan dentro de cada cuaderno, sino en `pdf/`.

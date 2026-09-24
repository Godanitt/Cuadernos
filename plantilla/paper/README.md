# Plantillas de paper

Todos los papers usan **un único esquema de metadatos**. Los adaptadores de esta
carpeta traducen ese esquema internamente al formato nativo de cada paquete.

Estilos disponibles:

- `elsevier` — por defecto; siempre a dos columnas.
- `ieee` — `charged-ieee`.
- `mdpi` — `splendid-mdpi`.

Cambiar de estilo debe requerir únicamente:

```typst
style: "elsevier",
```

por:

```typst
style: "ieee",
```

ó:

```typst
style: "mdpi",
```

## Esquema común

```typst
#let paper = (
  title: "Paper title",
  style: "elsevier",
  authors: (
    (
      name: "Author Name",
      department: "Department",
      institution: "Institution",
      city: "City",
      country: "Country",
      email: "author@example.com",
      orcid: "0000-0000-0000-0000",
      corresponding: true,
    ),
  ),
  date: (year: 2026, month: "September", day: 6),
  doi: "",
  abstract: "Abstract...",
  keywords: ("keyword 1", "keyword 2"),
)

#show: paper-template.with(meta: paper)
```

También se acepta el formato abreviado `authors: ("Author Name",)`. Los campos
ausentes reciben valores seguros por defecto dentro de los adaptadores.

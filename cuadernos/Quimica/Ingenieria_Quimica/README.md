# Ingeniería Química

<img src="../../../docs/assets/previews/Q-01.png" width="210" alt="Portada de Ingeniería Química">

**Código:** `Q-01` · **Estado:** 🟡 En desarrollo · **Progreso:** 57 %

Cuaderno desarrollado de ingeniería química con balances, transporte y operaciones de separación.

## Alcance

Incluye fundamentos de proceso, balances de materia y energía, transporte de cantidad de movimiento y calor, y operaciones de separación.

## Fuera de alcance

Pendiente de definir.

## Estructura

### Parte 1. Fundamentos y balances

- La ingeniería química y los procesos químicos
- Principios de conservación: balances de materia
- Principios de conservación: balances de energía

**Lecturas recomendadas:** `calleja2008`, `himmelblau2002`

### Parte 2. Fenómenos de transporte

- Flujo de fluidos
- Transferencia de calor

**Lecturas recomendadas:** `calleja2008`, `himmelblau2002`

### Parte 3. Operaciones de separación

- Procesos de separación

**Lecturas recomendadas:** `calleja2008`

### Parte 4. Diseño, control y seguridad de procesos

- Sin capítulos activos todavía.

**Lecturas recomendadas:** `calleja2008`

## Estado editorial

| Dimensión | Progreso |
|---|---:|
| Texto | 80 % |
| Figuras | 100 % |
| Ejercicios | 0 % |
| Bibliografía | 12 % |
| Revisión | 30 % |
| **Global ponderado** | **57 %** |

Capítulos activos: **6** · Páginas compiladas: **63** · PDF: **actualizado**.

## Compilación

Desde la raíz del repositorio:

```bash
python -m cuadernos update Q-01
```

Para regenerar todo el proyecto sin compilar:

```bash
python -m cuadernos update --no-build
```

## Archivos principales

- Manifiesto: `cuaderno.toml`
- Entrada Typst: `Q-Ingenieria_Quimica.typ`
- Contenido: `content.typ`
- Bibliografía: `Bibliografia/referencias.bib`
- PDF: `Q-Ingenieria_Quimica.pdf`

> Este README se genera automáticamente a partir del manifiesto y del contenido Typst.

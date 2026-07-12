# Corrección de rutas de portada, fuentes y migración

Desde la raíz del repositorio (`~/GitHub/Cuadernos`), copia el contenido de este
paquete conservando las rutas y ejecuta:

```bash
python -m cuadernos update --force
```

La actualización normal ya no mueve ni renombra archivos. Si alguna vez quieres
ejecutar la antigua migración de forma explícita:

```bash
python -m cuadernos migrate
```

Los PDF `*-legacy.pdf` fueron creados por la versión anterior para no sobrescribir
un PDF distinto que ya existía en `pdf/`. No se usan como salida canónica. Se
pueden borrar si no quieres conservar esas copias históricas:

```bash
rm -f pdf/*-legacy.pdf
```

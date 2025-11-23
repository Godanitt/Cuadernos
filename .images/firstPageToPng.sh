#!/bin/bash

# Carpeta de origen y destino
SRC="../_Pdf"
DST="."

# Crear carpeta .images si no existe
mkdir -p "$DST"

# Recorrer todos los PDF de la carpeta _Pdf
for pdf in "$SRC"/*.pdf; do
    # Obtener nombre base sin extensión
    base=$(basename "$pdf" .pdf)

    # Convertir primera página a PNG
    convert -density 200 "$pdf[0]" "$DST/$base.png"

    echo "Generado: $base.png"
done

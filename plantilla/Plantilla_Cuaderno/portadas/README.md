# Portadas Cuadernos

Portadas disponibles:

- `format: "fullimage"` / `format: "cover4"`
- `format: "wiley1"` / `format: "cover1"`
- `format: "wiley2"` / `format: "cover3"`
- `format: "fullimage2"` / `format: "cover5"`
- `format: "wiley2.1"` / `format: "cover6"`
- `format: "wiley2.2"` / `format: "cover7"`

Cambios de este patch:

- títulos principales ampliados a tamaño tipo `solid` (`62pt`);
- autores ampliados a tamaño tipo `solid` (`22pt`);
- subtítulos ampliados a `22pt`;
- en `wiley2`, la serie superior se enlaza a `github_url`.

`wiley2` no dibuja ningún recuadro gris sobre la imagen: solo hay una región de imagen recortada y un fundido blanco superior.

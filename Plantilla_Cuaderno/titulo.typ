#import "portadas/cover1.typ": cover1_title
#import "portadas/solid.typ": solid_title

#let make_title(
  primary: color,
  seccond: color,
  third: color,
  accent: color,
  image: none,
  title: str,
  subtitle: "",
  serie: "",
  author: (),
  github_url: "https://github.com/Godanitt/Cuadernos",
  cover: none,
  format: "solid",
) = {
  if format == "solid" or format == "default" {
    solid_title(
      primary: primary,
      seccond: seccond,
      third: third,
      accent: accent,
      image: image,
      title: title,
      subtitle: subtitle,
      serie: serie,
      author: author,
      github_url: github_url,
      cover: cover,
    )
  } else if format == "cover1" {
    cover1_title(
      primary: primary,
      seccond: seccond,
      third: third,
      accent: accent,
      title: title,
      subtitle: subtitle,
      serie: serie,
      author: author,
      github_url: github_url,
      cover: cover,
    )
  } else if format == "cover2" {
    panic("La portada `cover2` todavía no está implementada. Crea `portadas/cover2.typ` y añádela en `portadas.typ`.")
  } else {
    panic("Formato de portada desconocido: `" + format + "`. Usa `solid`, `default`, `cover1` o `cover2`.")
  }
}
#import "portadas/cover1.typ": cover1_title
#import "portadas/cover2.typ": cover2_title
#import "portadas/cover3.typ": cover3_title
#import "portadas/cover4.typ": cover4_title
#import "portadas/cover5.typ": cover5_title
#import "portadas/cover6.typ": cover6_title
#import "portadas/cover7.typ": cover7_title
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
  volume: "",
  cover: none,
  format: "solid",
  cover-theme: "dark",
  cover-zoom: 1.0,
  cover-dx: 0cm,
  cover-dy: 0cm,
  cover-text-color: "auto",
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
  } else if format == "cover1" or format == "wiley1" {
    cover1_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, cover: cover,
    )
  } else if format == "cover2" {
    cover2_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, cover: cover,
    )
  } else if format == "cover3" or format == "wiley2" or format == "springer" {
    cover3_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, cover: cover,
      cover-zoom: cover-zoom,
      cover-dx: cover-dx,
      cover-dy: cover-dy,
    )
  } else if format == "cover4" or format == "fullimage" {
    cover4_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, cover: cover,
      cover-theme: cover-theme,
      cover-zoom: cover-zoom,
      cover-dx: cover-dx,
      cover-dy: cover-dy,
      cover-text-color: cover-text-color,
    )
  } else if format == "cover5" or format == "fullimage2" {
    cover5_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, volume: volume, cover: cover,
      cover-theme: cover-theme, cover-zoom: cover-zoom,
      cover-dx: cover-dx, cover-dy: cover-dy,
    )
  } else if format == "cover6" or format == "wiley2.1" or format == "wiley21" {
    cover6_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, volume: volume, cover: cover,
      cover-zoom: cover-zoom, cover-dx: cover-dx, cover-dy: cover-dy,
    )
  } else if format == "cover7" or format == "wiley2.2" or format == "wiley22" {
    cover7_title(
      primary: primary, seccond: seccond, third: third, accent: accent,
      title: title, subtitle: subtitle, serie: serie, author: author,
      github_url: github_url, volume: volume, cover: cover,
      cover-zoom: cover-zoom, cover-dx: cover-dx, cover-dy: cover-dy,
    )
  } else {
    panic("Formato de portada desconocido: `" + format + "`.")
  }
}

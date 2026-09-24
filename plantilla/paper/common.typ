// Normalización común de metadatos para todos los estilos de paper.
//
// Un autor puede declararse simplemente como string:
//   authors: ("Daniel Vázquez Lago",)
//
// o como diccionario común, reutilizable por Elsevier / IEEE / MDPI:
//   authors: ((
//     name: "Daniel Vázquez Lago",
//     department: "Department of Particle Physics",
//     institution: "University of Santiago de Compostela",
//     city: "Santiago de Compostela",
//     country: "Spain",
//     email: "name@example.com",
//     orcid: "0000-0000-0000-0000",
//     corresponding: true,
//   ),)

#let _author-field(author, key, default: "") = if type(author) == dictionary {
  author.at(key, default: default)
} else {
  default
}

#let common-authors(meta) = {
  let authors = meta.at("authors", default: ())
  if authors.len() == 0 { ("Anonymous",) } else { authors }
}

#let author-name(author) = if type(author) == str {
  author
} else {
  author.at("name", default: "Anonymous")
}

#let author-department(meta, author) = {
  let value = _author-field(author, "department")
  if value != "" { value } else { meta.at("department", default: "") }
}

#let author-institution(meta, author) = {
  let value = _author-field(
    author,
    "institution",
    default: _author-field(author, "organization"),
  )
  if value != "" {
    value
  } else {
    meta.at(
      "institution",
      default: meta.at("organization", default: "Cuadernos project"),
    )
  }
}

#let author-city(meta, author) = {
  let value = _author-field(author, "city")
  if value != "" { value } else { meta.at("city", default: "") }
}

#let author-country(meta, author) = {
  let value = _author-field(author, "country")
  if value != "" { value } else { meta.at("country", default: "Spain") }
}

#let author-location(meta, author) = {
  let explicit = _author-field(author, "location")
  if explicit != "" {
    explicit
  } else {
    let city = author-city(meta, author)
    let country = author-country(meta, author)
    (city, country).filter(value => value != "").join(", ")
  }
}

#let author-email(meta, author) = {
  let value = _author-field(
    author,
    "email",
    default: _author-field(author, "mail"),
  )
  if value != "" { value } else { meta.at("email", default: "") }
}

#let author-orcid(author) = _author-field(author, "orcid")

#let author-corresponding(author) = _author-field(author, "corresponding", default: false)

#let author-affiliation(meta, author) = {
  let explicit = _author-field(author, "affiliation")
  if explicit != "" {
    explicit
  } else {
    let department = author-department(meta, author)
    let institution = author-institution(meta, author)
    let location = author-location(meta, author)
    (department, institution, location)
      .filter(value => value != "")
      .join(", ")
  }
}

#let as-content(value) = if type(value) == content { value } else { [#value] }

#let normalized-date(meta) = {
  let supplied = meta.at("date", default: none)
  if supplied == none {
    let today = datetime.today()
    (
      year: today.year(),
      month: today.display("[month repr:long]"),
      day: today.day(),
    )
  } else if type(supplied) == datetime {
    (
      year: supplied.year(),
      month: supplied.display("[month repr:long]"),
      day: supplied.day(),
    )
  } else {
    let raw-month = supplied.at("month", default: "January")
    let month = if type(raw-month) == int {
      (
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December",
      ).at(raw-month - 1, default: "January")
    } else {
      raw-month
    }
    (
      year: supplied.at("year", default: datetime.today().year()),
      month: month,
      day: supplied.at("day", default: 1),
    )
  }
}

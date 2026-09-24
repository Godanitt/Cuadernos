#import "../../../plantilla/paper/paper.typ": paper-template

// <paper:metadata>
#let paper = (
  id: "P-SEvENS",
  slug: "Coherent Elastic Neutrino Nucleus Scattering",
  title: "Dispersión Elástica Coherente Neutrino-Núcleo",
  // Cambia únicamente esta línea por "ieee" o "mdpi" para probar otro estilo.
  // Si se omite `style`, el gestor y la plantilla usan Elsevier por defecto.
  style: "elsevier",
  authors: ("Daniel Vázquez Lago",),
  output: "P-SEvENS.pdf",
  bibliography: "referencias.bib",
  bibliography_enabled: false,
  journal: (
    name: [Nuclear Physics A],
    foot-info: [Elsevier B.V. All rights reserved.],
  ),
  abstract: "La dispersion (scattering) elastico coherente de neutrino-nucleo (CEvENS) es un proceso en el que los neutrinos se disperan tras el impacto con un nucleo, actuando este como una unica particula individual. A pesar de tener una seccion eficaz grande (en los estandares de neutrinos), la deteccion de este proceso parece dificil de detectar, dado que la deposicion de energia esta en el orden del keV. Su deteccion tienee importantes implicaciones no solo en la fisica de altas energias, en el que aportaria nuevas cotas en la fisica mas alla del modelo estandar asi como nuevos metodos experimentales; sino en astrofisica, fisica nuclear entre otras. Este paper discute la importancia de los CEvENS y experimentos relacionados (COHERENT), asi como su relacion con otros campos de la fisica.",
  keywords: ("CEvENS", "Neutrinos", "Scattering Elastico "),
  tags: ("gases", "radiation", "test"),
)
// </paper:metadata>

// The body is common to all styles. Only the author dictionaries below adapt
// the same metadata to the native API of each external template.
#let elsevier-authors = (
  (
    name: [Daniel Vázquez Lago],
    affiliations: ("a",),
    corresponding: true,
    email: "daniel@example.com",
  ),
)
#let elsevier-affiliations = (
  "a": [Cuadernos project, Spain],
)

#let ieee-authors = (
  (
    name: [Daniel Vázquez Lago],
    organization: [Cuadernos project],
    location: [Spain],
    email: "daniel@example.com",
  ),
)

#let mdpi-authors = (
  (
    name: "Daniel Vázquez Lago",
    department: "Test paper",
    institution: "Cuadernos project",
    city: "Madrid",
    country: "Spain",
    mail: "daniel@example.com",
  ),
)

#show: paper-template.with(
  meta: paper,
  elsevier-authors: elsevier-authors,
  elsevier-affiliations: elsevier-affiliations,
  ieee-authors: ieee-authors,
  mdpi-authors: mdpi-authors,
)

= Introduccion

Los neutrinos han sido una de las piezas claves en la no-comprension del modelo estandar (SM, de sus siglas en ingles _Standard Model_). A pesar de que el SM es capaz de describir como los neutrinos interaccionan con leptones y quarks a traves de las interacciones debiles, no es capaz de responder algunas de las preguntas fundamentales sobre los mismos, por ejemplo, ¿Como se generan las masas de los neutrinos?¿Son particulas de Dirac o de Majorana? Los neutrinos son por tanto una prueba ineludible de que existe fisica mas alla del modelo estandar (BSM, de las singlas en ingles _Beyond Standard Model_) y por tanto son un objeto de estudio interesantÍsimo. 

Los neutrinos detectados provienen tanto de fuentes terrestres como de astrofisicas, en un gran rango de energias diferentes. Los reactores nucleares producen neutrinos con $>= "MeV"$ y aceleradores sobre $>= "GeV"$. Las fuente astrosfisicas emiten neutrinos desde los MeV hasta los PeV. 

Los neutrinos de baja energia $("MeV")$ son especialmente relavantes a la hora de detectar las propiedades de los neutrinos, como puede ser las diferencias de masas o las propiedades de mezcla. A estas energias, existen multitud de estudios complementarios, de fuentes tanto terrestres como astrofisicas. Por ejemplo, los neutrinos procendentes del Sol son una prueba de su produccion en procesos astrofisico nucleares en el interior de las estrellas, y ha sido combinado con reactores para estableccer la solución de Gran Ángulo de Mezcla (LMA, por sus siglas en inglés _Large Mixing Angle_) del efecto Mikheyev-Smirnov-Wolfenstein (MSW) en los neutrinos solares. 

A las energias de MeV, los neutrinos han sido detectados a traves de numerosos canales, incluyendo interacciones elasticas neutrino-electron ($nu + e^- arrow nu + e^-$), asi como a traves de interacciones inelasticas neutras y cargadas con nucleones y nucleos. Para ello se suele medir la energia del electron dispersado o en el caso de los ultimos detectores a traves del electron generado en las interacciones cargadas o rayos gamma en las interacciones nucleares inelasticas. Particularmente si la interaccion es beta-inversa ($dash(nu)_e + p arrow e^+ + n$) se detectan los positrones como los neutrones. En el regimen de MeV, las interacciones de los neutrinos transitan de poder ser descritas como interacciones puntuales con particulas fundamentales a ser descritas como interacciones con las particulas consituyentes del nucleo. 

$"CE"nu"NS"$ (del ingles _Coherent Elastic neutrino Nucleus Scattering_) es un proceso en el que los neutrinos se dispersan interaccionando cno el nucleo en el que este ultimo actua como una particula puntual. En el SM, los $"CE"nu"NS"$ se describen fundamentalmente a traves de una corriente neutra de interaccion neutrino-quark, y debido a la naturaleza de los acoplos del SM es proporcional al numero de neutrones al cuadrado. Tal y como hemos mencionado en el abstract, los $"CE"nu"NS"$ poseen una seccion eficaz total grande (en la escala habitual de los neutrinos) pero son dificiles de detectar, debido a la baja energia de deposicion $tilde "keV"$. En 2017 la colaboraciÓn COHERENT anuncio la deteccion de $"CE"nu"NS"$ usando una fuente de piones usando un cristal centelleador CsI[Na]. Posteriormente se detecto un $"CE"nu"NS"$ en un detector de fase liquida de Ar (_single-phase liquid detector argon target_).

La deteccion de estos $"CE"nu"NS"$ son fuente de inspiracion para los fisicos teoricos, capaces de constrÑir la fisica BSM. Tambien ha motivado la apariciÓn de grandes detectores y tecnologia para disminuir la sensibilidad hasta unas centenas de "eV". 

Ademas de proveer un nuevo canal para la deteccion de neutrinos, existen varias aplicaciones de los detectores $"CE"nu"NS"$. El primero de ellos es por ejemplo la busqueda de particulas de materia oscura de baja masa ($< "GeV"$) como WIPMs. Experimentos de $"CE"nu"NS"$ pueden dar nuevos metodos en la busqueda de estas particulas de baja masa. Mas alla de la materia oscura, tambien pueden ayudar al estudio de de partÍculas como axiones. 

= $"CE"nu"NS"$ en el Modelo Estandar


#import "../../../plantilla/paper/paper.typ": paper-template
#import "@preview/physica:0.9.8": *
#import "@preview/lilaq:0.6.0" as lq
#import "../../../plantilla/componentes/comandos.typ": * 

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
  bibliography_enabled: true,
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

// La ruta del .bib se resuelve aquí, junto al paper, y se pasan sus bytes
// a la plantilla editorial común.
#let bibliography-source = if paper.bibliography_enabled {
  read(paper.bibliography, encoding: none)
} else {
  none
}

#show: paper-template.with(
  meta: paper,
  elsevier-authors: elsevier-authors,
  elsevier-affiliations: elsevier-affiliations,
  ieee-authors: ieee-authors,
  mdpi-authors: mdpi-authors,
  bibliography-source: bibliography-source,
)

#let cevens = $"CE"nu"NS"$

#outline()

= Introduccion

Los neutrinos han sido una de las piezas claves en la no-comprension del modelo estandar (SM, de sus siglas en ingles _Standard Model_). A pesar de que el SM es capaz de describir como los neutrinos interaccionan con leptones y quarks a traves de las interacciones debiles, no es capaz de responder algunas de las preguntas fundamentales sobre los mismos, por ejemplo, ¿Como se generan las masas de los neutrinos?¿Son particulas de Dirac o de Majorana? Los neutrinos son por tanto una prueba ineludible de que existe fisica mas alla del modelo estandar (BSM, de las singlas en ingles _Beyond Standard Model_) y por tanto son un objeto de estudio interesantÍsimo. 

Los neutrinos detectados provienen tanto de fuentes terrestres como de astrofisicas, en un gran rango de energias diferentes. Los reactores nucleares producen neutrinos con $>= "MeV"$ y aceleradores sobre $>= "GeV"$. Las fuente astrosfisicas emiten neutrinos desde los MeV hasta los PeV. 

Los neutrinos de baja energia $("MeV")$ son especialmente relavantes a la hora de detectar las propiedades de los neutrinos, como puede ser las diferencias de masas o las propiedades de mezcla. A estas energias, existen multitud de estudios complementarios, de fuentes tanto terrestres como astrofisicas. Por ejemplo, los neutrinos procendentes del Sol son una prueba de su produccion en procesos astrofisico nucleares en el interior de las estrellas, y ha sido combinado con reactores para estableccer la solución de Gran Ángulo de Mezcla (LMA, por sus siglas en inglés _Large Mixing Angle_) del efecto Mikheyev-Smirnov-Wolfenstein (MSW) en los neutrinos solares. 

A las energias de MeV, los neutrinos han sido detectados a traves de numerosos canales, incluyendo interacciones elasticas neutrino-electron ($nu + e^- arrow nu + e^-$), asi como a traves de interacciones inelasticas neutras y cargadas con nucleones y nucleos. Para ello se suele medir la energia del electron dispersado o en el caso de los ultimos detectores a traves del electron generado en las interacciones cargadas o rayos gamma en las interacciones nucleares inelasticas. Particularmente si la interaccion es beta-inversa ($dash(nu)_e + p arrow e^+ + n$) se detectan los positrones como los neutrones. En el regimen de MeV, las interacciones de los neutrinos transitan de poder ser descritas como interacciones puntuales con particulas fundamentales a ser descritas como interacciones con las particulas consituyentes del nucleo. 

$"CE"nu"NS"$ (del ingles _Coherent Elastic neutrino Nucleus Scattering_) es un proceso en el que los neutrinos se dispersan interaccionando cno el nucleo en el que este ultimo actua como una particula puntual. En el SM, los $"CE"nu"NS"$ se describen fundamentalmente a traves de una corriente neutra de interaccion neutrino-quark, y debido a la naturaleza de los acoplos del SM es proporcional al numero de neutrones al cuadrado. Tal y como hemos mencionado en el abstract, los $"CE"nu"NS"$ poseen una seccion eficaz total grande (en la escala habitual de los neutrinos) pero son dificiles de detectar, debido a la baja energia de deposicion $tilde "keV"$. En 2017 la colaboraciÓn COHERENT anuncio la deteccion de $"CE"nu"NS"$ usando una fuente de piones usando un cristal centelleador CsI[Na]. Posteriormente se detecto un $"CE"nu"NS"$ en un detector de fase liquida de Ar (_single-phase liquid detector argon target_).

La deteccion de estos $"CE"nu"NS"$ son fuente de inspiracion para los fisicos teoricos, capaces de constrÑir la fisica BSM. Tambien ha motivado la apariciÓn de grandes detectores y tecnologia para disminuir la sensibilidad hasta unas centenas de "eV". 

Ademas de proveer un nuevo canal para la deteccion de neutrinos, existen varias aplicaciones de los detectores $"CE"nu"NS"$. El primero de ellos es por ejemplo la busqueda de particulas de materia oscura de baja masa ($< "GeV"$) como WIPMs. Experimentos de $"CE"nu"NS"$ pueden dar nuevos metodos en la busqueda de estas particulas de baja masa. Mas alla de la materia oscura, tambien pueden ayudar al estudio de de partÍculas como axiones. 

= $"CE"nu"NS"$ en el Modelo Estandar

$"CE"nu"NS"$ es un proceso de corriente neutra que aparece cuando la trasferencia de momento en la colision neutrino-nucleo es menor que la inversa del tamaÑo del nucleo. En el SM, la itneracciÓn es mediada por el boson Z, con su componente vectorial llevando al proceso coherente. La seccion eficaz tiene la forma

$ 
  derivative(sigma, T) = (G_F^2 M)/(4 pi) (1 - (M T)/(2 E_nu^2)) Q_w^2 [F_w(q^2)]^2 
$ <Ec:cs_CEvNS_1>


siendo $G_F$ la constante de Fermi, $T = E_R = q^2 / (2 M) = E_nu - E_nu '$ la energia que se lleva el nucleo,, $F_w (q^2)$ el factor de forma debil, $M$ la masa del nucleo y $E_nu(E_nu ')$ la energia inicial(final) del neutrino. La caga debil responsable de esta interaccion se define como

$ 
  Q_w = Z ( 1 - 4 dot sin^2 theta_w) - N
$
siendo $Z$ el numero de protones, $N$ el numero de neutrones y $theta_W$ el angulo de mezcla debil. El factor de forma debil, $F_w(q^2)$ depende de la distribuciÓn de densidad nuclear de protones y neutrones. En el limite coherente $q^2 arrow 0$ tenemos $F_w(q^2 )= 1$. De este modo la dependencia de la seccion eficaz es con $N^2$, ya que la dependencia con los protones se ve fuertees prinimente suprimida dado que $Q_w^p << 1$. Consecuentemente  #cevens es sensible principalmente a la distribuciÓn de neutrones en el nÚcleo. 

== Estructura de la contribucion del Modelo Estandar

Las interacciones al nivel quark en el SM dependen del lagrangiano

$ Lcal^("SM") = - sqrt(2) G_F sum_(q=u,d,s) (C_q^V dash(nu) gamma^u P_L nu dash(q) gamma_mu q + C_q^Lambda dash(nu) gamma^mu P_L nu dash(q) gamma_mu gamma_5 q) $ <Ec:Lagrangiano_nu_quark>

siendo $P_L = (1-gamma_5)/2$ y los coeficientes de tercer nivel de Wilson: 

$ C_u^V = 1/2 (1-8/3 sin^2 (theta_W)), \ C_d^V = C_s^V = -1/2 (1-4/3 sin^2 (theta_W)),    \ C_u^Lambda = - C_d^Lambda  = -C_s^Lambda = -1/2 $

El operador vector nos da la contribución coherente a la sección eficaz, mientras que el operador vector-axial nos da una contribución no coherente. Incluyendo todos las correciones cinemáticas, la sección eficaz puede ser escrita de la siguiente forma: 


$
  derivative(sigma, T)  = & (G_F^2 M)/(4 pi) dot  (1 - (M T)/(2 E_nu^2) - T/E_nu) Q_w^2 [F_w(q^2)]^2 \ + & (G_F^2 M)/(4 pi)  dot  (1 + (M T)/(2 E_nu^2) - T/E_nu) F_A (q^2)  
$ <Ec:cs_CEvNS_2>

siendo el factor procedente del vector-axial $F_A(q^2)$. Esta contribución se cancela en el caso de un núcleo con un número par de protones y neutrones, debido a que estos tienen espín cero en el estado fundamental. 
Para pasar de la interacción neutrino-quark @Ec:Lagrangiano_nu_quark a la sección eficaz de la ecuación @Ec:cs_CEvNS_1, el cálculo se realiza en dos etapas. En primer lugar, se evalúan los elementos de matriz de las corrientes de quarks entre estados de nucleón, parametrizados mediante factores de forma vectoriales y axiales. En el sector vectorial, las normalizaciones a momento transferido nulo están determinadas por el contenido de quarks de valencia del protón y del neutrón. Con la convención adoptada para los coeficientes y a nivel árbol en el Modelo Estándar, las cargas débiles son:

$ Q_w^p = 2 (2 C_u^V + C_d^V) = 1 - 4 sin^2 theta_W, $
$ Q_w^n = 2 (C_u^V + 2 C_d^V) = -1. $

Las correcciones dependientes del momento transferido, expresadas a bajo momento en términos de radios y momentos magnéticos nucleónicos, se incorporan posteriormente en el factor de forma débil nuclear $F_w (q^2)$. De manera análoga, las cargas y los radios axiales del nucleón intervienen en la respuesta axial nuclear $F_A (q^2)$, que también depende de la estructura de espín del núcleo.

En segundo lugar, se calculan los elementos de matriz de los operadores nucleónicos entre estados del núcleo y se organizan las respuestas nucleares mediante una expansión multipolar. La contribución vectorial coherente dominante puede interpretarse en términos de las distribuciones espaciales de protones y neutrones, ponderadas por sus respectivas cargas débiles.

Una forma alternativa de escribir las ecuaciones @Ec:cs_CEvNS_1 y @Ec:cs_CEvNS_2 se hace teniendo en cuenta también la dirección del retroceso nuclear, tal que podamos pasar a una sección eficaz angular. En la práctica, un detector debería ser capaz de medir la energía de retroceso y el ángulo de retroceso simultáneamente, tal que el _scattering_ (dispersión) podrá ser expresado en función de ambas variables, $"d"^2sigma slash "d"E_R"d"Omega_R$, donde los angulos del núcleo se miden en funderivativeción el angulo de incidencia del neutrino. Esta antidad se refiere en la literatura como el *Espectro de Momento* o *Espectro de Retroceso Direccional*, tal que 


$
  dv(""^2 sigma, E_R dd(Omega) )  = 1/(2pi) evaluated(dv(sigma,E_R))_(E_nu = varepsilon) varepsilon^2/E_v^min evaluated(dv(Phi,E_v))_(E_nu = varepsilon)
$ <Ec:cs_CEvNS_3>
 
donde $dd(Phi) slash dd(E_nu)$ es el flujo diferencial de neutrinos y $E_nu^min = sqrt(M  E_R slash 2)$, tal que 

$ 1/varepsilon = cos(theta_R)/E_nu^min - 1/M $

Para intercmabiar las variables directamente a $E_R $ y $Sigma_R$ se usa la siguiente relación y el Jacobiano asociado: 

$ E_R = (2 M E_nu^2 cos^2 theta_R)/((E_nu + M)^2 - E_nu^2 cos^2 theta_R) $

La sección eficaz doblemente difernecial puede ser escritos en térinos únicamente angulares (integrando sobre la energía total de retroceso) tal que

$ dv(sigma,Omega_R) = (G_F^2)/(16 pi^2) Q_w^2 E_nu (1+cos theta_R) [F_w (q^2)]^2 $

Dado que la sección eficaz angular es simétrica en el angulo azimutal $phi$ respecto la dirección del flujo de neutrinos, en realidad podemos escribir 

$ dd(Omega_R) = 2 pi cos theta_R dd(theta_R) $

siendo $theta_R$ el angulo que hay entre la dirección del neutrino incidente y el neutrino saliente. 

== Física nuclear y hadrónica

Debido a la supresión del término de protones por la propia carga débil de estos, la respuesta nuclear más relevante a la hora de interpretar los  experimentos $"CE"nu"NS"$ es la distribución de neutrinos. Mientras que la densidad de carga de los núcleos es y ha sido estudiada extensivamente por experiemntos de dispersión elástica de electrones, la distribución de neutrones es dificil de medir. Existen medidas precisas para observables sensibles a la distribución de neutrones, tales como el dipolo de polarización nuclear, pero los esfuerzos usando medidas hadronicas requieren un analisis eestadístico muy complejo en las incertidumbres dependientes de los propios modelos. 

Al contrario, procesos electrodébiles tales como la violación de paridad vía sacterring electrónico (PVES) y #cevens han sido considerados como las pruebas más limpias de las densidades neutrónicas. Ambas han sido consideradas durante mucho tiempo medidas _difíciles_, pero se han hecho una realidad en los años más recientes.

La observación de los #cevens entonces puede aportar una información sobre la estrucutra uclear muy importante, a través de la determinación del _factor de forma débil_, que constriñe la densidad de neutrones y, por tanto, el radio neutrónico y la piel de neutrones (densidad superficial de neutrones), al menos a bajas transferencias de momento, donde el proceso permanece coherente. Estas medidas complementarían los experimentos PVES aportando no solo nuevos datos, sino datos en diferentes rangos de energía y con diferentes núcleos. Además, las mejoras en las medidas de la piel de neutrones serían fundamentales para la ecuación de estado neutrónica en núcleos con un alto número de neutrones, que además juega un papel fundamental en el entendimiento de la estructura y evolución de las estrellas de neutrones. 

Sin embargo, el aspecto más interesante de #cevens en cuanto a la estrucutra nuclear está relacionado con las búsquedas de física más allá del modelo estándar. Sin medidas independientes de las respuestas neutrónicas, las cuales, obviando PVeS, son difíciles de  obtener, la sección eficaz de #cevens constreñiría fuertemente esta combinación de efectos nucleares y BSM. 

Para poder extraer la información BSM de la estructura neutrónica evitando aquella relacionada con efectos de estructura nuclear, se tiene que hacer un análisis combinado a múltiples blancos y con diferentes transferencias de momento. Esta sería la manera de poder distinguir la estructura y posibles contribuciones BSM. Por lo tanto, se necesita un detallado entendimiento de las respuestas nucleares antes de analizar estas contribuciones BSM.

Tradicionalmente, el factor de forma débil

$ F_w (q^2) = 1/Q_W [Z Q_W^p F_p(q^2) + N Q_W^n F_n(q^2)] $

ha sido modelado en términos de las densidades protónicas y neutrónicas:

$ F_n (q^2) = (4 pi)/N integral (sin^2(q r))/(q r) rho_n(r)   r^2  dd(r),
\ F_p (q^2) = (4 pi)/Z integral  (sin^2(q r))/(q r) rho_p(r) r^2  dd(r),  $

donde $rho_n(r)$ y $rho_p(r)$ las densidades neutrónicas y positrónicas normalizadas al número de neutrones y protones respectivamente. Los factores de forma fenomenológicos están basados en ajustes empíricos a datos de dispersión de electrones, y se asumen parametrizaciones similares para el factor de forma neutrónico. Por ejemplo, la _parametrización de Helm_ dice que la distribución de nucleones viene dada por la convolución de una densidad uniforme con radio $R_0$ y un perfil gaussiano con anchura $s$, el grosor de la superficie, tal que: 

$ F_"Helm"  (q^2) = (3 j_1(q R_0))/(q R_0) e^(- q^2 s^2 slash 2) $

donde $j_1(x)$ es la función de Bessel de orden uno. Otro ejemplo es la _parametrización de Klein-Nystrand_, que se basa en una distribución de superficie difusa que se puede deducir a partir del potencial de corto alcance de Yukawa con rango $a_k$ sobre una distribución esférica dura de radio $R_A$, tal que 

$ F_("KN") (q^2) = (3 j_1(q R_A))/(q R_A) [1/(1+q^2 a_k^2)]$

En ambos casos, es remarcable que las parametrizaciones necesitan asumir un valor para el radio neutrónico ($R_0, R_A$) y solo tratan de capturar la tendencia principal. siendo la distribución neutrónica poco constreñida. En realidad los métodos de cálculo de la estructuras nucleares se basan en métodos de campo medio, funcionales de densidad-energía no relativistas, método de capas y, por ejemplo, para argon, un cálculo de primeros principios mediante la teoría de cústeres acoplados.

Conservando todas las respuestas que al menos muestran cierto grado de mejora coherente, el factor de forma débil recibe contribuciones adicionales, i.e. relacionado con el efectos de tamaño finito e interacciones espín-órbita. Se esperan correcciones a la teoría relacionados con corrientes de dos cuerpos, pero para los procesos realmente relevantes tales contribuciones aparecen junto los _loops_ en la expansiones quirales. 

= Fuentes terrestres de neutrinos

En esta sección visitaremos las principales fuentes de neutrinos para #cevens. 

== Hazes de frenado de piones

Las fuentes de espalación (_spallation_) producen tanto $pi^+$ como $pi^-$ a través de colisiones de protones con núcleos. La mayoría de los $pi^-$ que se producen son capturados por los núcleos y por tanto no son capaces de producir neutrinos. Sin embargo, los $pi^+$ pierden energía y decaen a través de $pi^+ arrow mu^+ nu_mu$, produciendo anti-muones y neutrones muónicos monoenergéticos con una energía de 30 MeV. Después, los $mu^+$ deccaen a $dash(nu)_mu$, $nu_e$ y  $e^+$, con el llamado _espectro de energía de Michael_. Debido al tiempo de vida medio, los neutrinos $dash(nu)_mu$ y $nu_e$ están retrasados respecto a los neutrinos $nu_mu$ de 30 MeV producidos por el decaimiento del pion. Las líneas espectrales son: 

$ F_(nu_mu) (E_nu) = (2 m_pi)/(m_pi^2 - m_mu^2) delta(1-(2E_nu m_pi)/(m_pi^2 - m_mu^2)) $
$ F_(nu_e) (E_nu) = (192)/(m_mu) (E_nu/m_mu)^2 (1/2 - E_nu/m_mu) $
$ F_(dash(nu)_mu) (E_nu) = (64)/(m_mu) (E_nu/m_mu)^2 (3/4 - E_nu/m_mu) $

#let m_pi = 139.6
#let m_mu = 105.66

// Energía del neutrino del decaimiento del pión en reposo.
#let e_prompt = (m_pi * m_pi - m_mu * m_mu) / (2 * m_pi)

// Espectros normalizados, en MeV⁻¹.
// Son cero fuera de 0 ≤ E ≤ m_mu/2.
#let f_nu_e(e) = {
  if e < 0 or e > m_mu / 2 {
    0
  } else {
    (192 / m_mu) * calc.pow(e / m_mu, 2) * (1/2 - e / m_mu)
  }
}

#let f_anti_nu_mu(e) = {
  if e < 0 or e > m_mu / 2 {
    0
  } else {
    (64 / m_mu) * calc.pow(e / m_mu, 2) * (3/4 - e / m_mu)
  }
}
#let e_max = m_mu / 2
#let energies = lq.linspace(0, e_max, num: 400)

// Repetimos el extremo para dibujar el corte vertical.
// Después prolongamos ambos espectros, nulos, hasta 60 MeV.
#let xs = energies + (e_max, 60)
#let ys_e = energies.map(e => f_nu_e(e)) + (0, 0)
#let ys_mu = energies.map(e => f_anti_nu_mu(e)) + (0, 0)


#figure(
lq.diagram(
  
  xlabel: [Energía [MeV]],
  ylabel: [$F_nu (E_nu)$],

  lq.plot(
    xs, ys_e,
    color: blue,
    mark: none,
    label: $nu_e$,
  ),
  lq.plot(
    xs, ys_mu,
    color: orange,
    mark: none,
    label: $overline(nu)_mu$,
  ),

  // Delta de Dirac: posición física, altura ilustrativa.
  lq.plot(
    (e_prompt, e_prompt),
    (0, 0.045),
    color: green,
    stroke: 1.5pt,
    mark: none,
    label: $nu_mu$,
  ),
  
) ,
caption: "Distribuciones de energía de los neutrinos.",
)

// Tiempos en microsegundos.
// Densidades de probabilidad en microsegundos⁻¹.
#let tau_pi = 0.026033
#let tau_mu = 2.1969811

// Componente prompt: pi+ -> mu+ + nu_mu
#let f_prompt(t) = {
  if t < 0 {
    0
  } else {
    calc.exp(-t / tau_pi) / tau_pi
  }
}

// Componentes retardadas:
// pi+ -> mu+ -> e+ + nu_e + anti_nu_mu
// Convolución analítica de las dos exponenciales.
#let f_delayed(t) = {
  if t < 0 {
    0
  } else {
    (
      calc.exp(-t / tau_mu)
      - calc.exp(-t / tau_pi)
    ) / (tau_mu - tau_pi)
  }
}

// Evitamos t = 0 porque f_delayed(0) = 0,
// que no puede representarse en escala logarítmica.
#let ts = (
  lq.linspace(0.0001, 0.3, num: 800)
  + lq.linspace(0.301, 10, num: 1200)
)

#figure(
lq.diagram(
  xlabel: $t" "["μs"]$,
  ylabel: $f(t)" "["μs"^(-1)]$,

  xlim: (0, 2),
  ylim: (0.1, 50),
  yscale: "log",

  lq.plot(
    ts,
    ts.map(t => f_prompt(t)),
    color: green,
    stroke: 1.5pt,
    mark: none,
    label: $nu_mu$,
  ),

  lq.plot(
    ts,
    ts.map(t => f_delayed(t)),
    color: blue,
    stroke: 1.5pt,
    mark: none,
    label: $nu_e$,
  ),

  lq.plot(
    ts,
    ts.map(t => f_delayed(t)),
    color: orange,
    stroke: (thickness: 1.5pt, dash: "dashed"),
    mark: none,
    label: $overline(nu)_mu$,
  ),
),
caption: "Distribuciones temporales de los neutrinos.",
)

== Reactores Nucleares

Los reactores nucleares han sido propuestos desde hace tiempo como fuentes de antineutrinos electrónicos. Los neutrinos procedentes de reactores han sido detectados usando el decaimiento beta inverso $dash(nu)_e + p arrow e^+ + n $, observando el positrón coincidente con el neutrón. Hay 4 isótopos cuya fisión produce un flujo de neutrinos: $""^235"U", ^241"P", ^239"P" " y " ^238"U"$. Los flujos de neutrinos se determinan a partir de la potencia generada en el reactor, con una incertidumbre ya estimada en @Huber2011 @Mueller2011.

La energía característica de estos neutrinos es de $<= 1 "MeV"$, que es de un orden de energía menor que los neutrinos producidos por los aceleradores. Debido a estas bajas energías, la condición de coherencia para el retroces se mantiene, en general, para todo el rango de energía del reactor, de tal modo que no hay ninguna dependencia de la propia estructura interna del núcleo.

== $""^51"Cr"$

El $""^51"Cr"$ es un isótopo que captura electrones mediante decaimiento, con una vida media de 27.7 días. El espectro de neutrinos producidos consiste en 4 líneas monocromáticas, siendo las más energéticas la de 747 keV (81%) y 752 (9%).

== Geo-neutrinos

Los geo-neutrinos provienen de la emisión de los isótopos $""^238"U", " "^232"Th" "y " ^40"k"$, que la Tierra puede proveer desde su interior. Mientras que el flujo de geo-neutrinos es suprimido, los #cevens tienen el potencial de explorar el más allá del límite cinemático de 1.8 MeV basado en la señal IBD.    

== Futuros haces de neutrinos

La _Long Baseline Neutrino Facility_ (LBNF) en Fermilab puede ser ustada para #cevens. La LBNF produce neutrinos en una escala energética completamente diferente a neutrinos de reactores. Esto aporta una nueva escala de energía en la que la sección eficaz de los #cevens puede ser estudiada. 

= Fuentes astrofísicas de neutrinos

== Neutrinos solares

El campo de los neutrinos solares lleva siendo estudiado más de 50 años. El primer objetivo de estos estudios era medir las diferentes componentes del flujo de neutrinos, y suar estas medidas para entender la física en el interior del Sol. Los primeros experimentos usaron capturas de neutrinos en Cl, Ga, con la intención específica de estudiar la cantidad de neutrinos electrónicos en el haz. Experimentos basados en radiación cherenkov de una tonelada de agua miden el scattering elástico neutrino-electrón, con sensibilidad tanto a los sabores electrónicos y muónicos. El flujo total del boro $""^8"B"$ se contabilizo por $5.25 times 10^6 " cm"^(-2)" s"^(-1)$. 

Borexino @Alimonti2009Borexino midió las componentes de baja energía del flujo de neutrinos solares de las reacciones $p + e^- + p$ (pep),  $""^7"Be"$, $p + p$ (pp) y ciclos CNO. La combinación de todos los datos de flujos de neutrinos, tanto del Sol como de la Tierra, apoyó la solución LMA-MSW al problema de la transformación de sabor de los neutrinos que venían del Sol. A bajas energías $(<5" MeV")$ oscilaciones de vacío describen esta transformación de sabor, con una supervivencia del neutrino electrónico $>50%$. A energías altas $(>5" MeV")$ es la masa de los neutrinos la que describe esta transofrmación, con una supervivencia de $>1 slash 3$. 

Incluso con la tremenda cantidad de progreso tanto experimental como teórico en el campo de neutrinos solares, existen todavía preguntas abiertas en el campo, como por ejemplo que los 3 principales experimentos sensibles al retroceso de los electrones de la dispersión electrón-neutrino  en la escala de unos pocos MeV (Super-Kamiokande, SNO y Borexino) tengan datos incompatibles en $tilde 2 sigma$ relativo a la mejor predicción de la solución LMA-MSA. Esto puede indicar nueva física. Además, las medidas recientes de la _diferencia de masas cuadrática_ de los neutrinos en particular de los datos día-noche de Super-Kamiokande y KamLAND discreptan en un $tilde 2 sigma$, de nuevo, indicativo de nueva física. 

Aún hay mas preguntas en lo correspondiente a como se miden los flujos del interior solar. Los modelos de absorción solar y heliosismología sugieren una abundacia baja de metales en el núcleo del sol, i.e. un SSM (_Standar Solar Model_) de bajo Z, a diferencia del anteriormente establecido SSM de alto Z. Sin embargo, algunos de los conjuntos de datos aun están a favor de estos últimos, por tanto el análisis global del flujo de neutrinos solares está inconcluso. 

== Neutrinos de supernovas

== Neutrinos atmosféricos

= Física Más Allá del Modelo Estándar

Usando tanto fuentes terrestres como astrofísicas, los #cevens pueden ser usados para descubrir física BSM. En particular dos escenarios BSM son explorados: los neutrinos estériles y nuevas interacciones (NSI, del inglés _No-Standard Interactions_). 

== Neutrinos estériles

Nuevos fermiones de un gauge singlete serían una extensión mínima del SM. Dado que no hay neuvas simetrías que prohiban dicho término, las invariancias gauge y de Lorentz permitirían escribir un nuevo término en el lagrangiano: 

$ Lcal supset gamma N H L $

Donde $y$ sería el acople de Yukawa, $H$ y $L$ los dobletes de Higgs y leptónicos, mientra que $N$ sería este nuevo gauge singlete de fermiones, mas comunmente denominado "neutrino estéril" o "leptón pesado neutro". Aqui uno puede darse cuenta que tras la ruptura de la simetría $N H L arrow <H> N nu$, la masa de los neutrinos no estériles y la del neutrino estéril se mezclan. La existencia de estos estados BSM podrían explicar la observación de las masas de los neutrinos. 

Dependiendo del modelo, el neutrino estéril \(N\) puede tener también una masa de Majorana, es decir, puede ser su propia antipartícula.
A diferencia de lo que ocurre con otras partículas del Modelo Estándar, la teoría no nos obliga a que existan exactamente tres neutrinos estériles, ni uno, ni ningún número concreto. No hay una condición tipo “cancelación de anomalías” que fije cuántos debe haber. Y tampoco sabemos qué masa deberían tener. La teoría permite construir modelos razonables donde esos neutrinos estériles son extremadamente ligeros, por debajo del eV, pero también modelos donde son enormemente pesados, incluso por encima de la escala de gran unificación (GUT).

Los neutrinos estériles descritos arriba pueden ser buscados en varios tipos de experimentos. La mayoría de estos caen en dos categorías: oscilaciones de neutrinos o producción directa. La segunda categoría explora la posibilidad de que estos neutrinos estériles hereden una porción de la interacción débil debido a su mezcla con los neutrinos activos (electrónico, muónico, tauónico). Esto permitiría su producción en decaimientos mesónicos o en neutrino _scattering_.

En la búsqueda por indicios de los neutrinos estériles, parece que la forma mas sencilla de interpretar los datos experimentales es la llamada "imagen de dos neutrinos". Esta imagen aproxima la diferencia cuadrática de masas entre los neutrinos activos por cero, y que las oscilaciones vengan precisamente de una diferencia de masas grande entre los activos y los estériles. Dependiendo de la fuente, los experimentos serían capaces de demostrar la aparición de un flujo de neutrinos nuevo ($nu_mu arrow nu_e, dash(nu)_mu arrow dash(nu)_e$) o su desaparición ($nu_mu arrow nu_mu, dash(nu)_e arrow dash(nu)_e$).

Dado que los experimentos de #cevens serían sensibles al flujo total de neutrinos activos, estos se encuentran en una posición en la búsqueda de neutrinos estériles. A una distancia fija del lugar de origen de los neutrinos se podría percibir perfectamente una variación significativa del flujo de un tipo de neutrinos esperado por el SM (lo que sería una señal de neutrinos estériles). Sin embargo esto implica directramente conocer con precisión las incertidumbres sistemáticas del flujo de neutrinos de la fuente. Los neutrinos estériles podrían ser identificadps, por ejemplo, comparando el espectro de energía del retroceso de los núcleos a diferentes distancias de la fuente. Esta técnica sería directamente independiente de las incertidumbres sistemáticas asociadas al flujo de neutrinos, auqnue requiere detectores con suficiente resolución energética. 

Los detectores #cevens en un detector de frenado de piones podría ser usado precisamente para la búsqueda de estros neutrinos estériles. Además, la sensibilidad a los neutrinos estériles es maximizado colocando múltiples detectores a distancias de 20 a 40 de la fuente. Colocados cerca de reactores a unos 2-20 m podría también ver el estado de mezcla con neutrinos estériles, pero en este caso solo de los neutrinos electrónicos.


== Interacciones fuera del Modelo Estándar

En esta seción podemos ver las diferentes implicaciones fenomenológicas que se deducen de la adicción de operadores adicionales o modificcaiones de las interacciones vectoriales y axio-vectoriales en el SM con una estrucutra de sabor no trivial. También veremos como se aplican nuevos operadores con una diferente estructura de Lorentz (escalar o tensorial), y 

=== NSI: interacciones vectoriales y axial-vectorial

=== Nuevas interacciones de neutrinos en modelos $U(1)'$


=== Propiedades electromagnéticas


=== Otras NSI

= Esfuerzos experimentales

== Hazes de frenado de piones
== Reactores
== Materia oscura y detección de #cevens

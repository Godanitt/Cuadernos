// =====================
// Configuración básica
// =====================
#import "@preview/cetz:0.4.2": *
#import "@preview/physica:0.9.7": *
#import "auxiliar.typ": *
#import "comandos.typ": *
#import "@preview/inknertia:0.1.0": feynman
#import feynman: *
#import "@preview/unify:0.7.1": num,qty,numrange,qtyrange

#let color1 = rgb("#2C3D94")
#let color2 = rgb("#2C3D94")
#let color3 = rgb("#2C3D94")
  
#show link: set text(fill: color1)  
#show cite: set text(fill: color2)
#show ref: set text(fill: color3)

#set page(
  margin: 1.8cm,
  footer: context [
    
    #set align(right)
    #set text(10pt)
    #counter(page).display(
      "1 de 1",
      both: true,
    )
  ]
)
#set text(
  size: 11pt,
  lang: "es"
)


#set par(
  justify: true,
  
)

#set enum(
    numbering: "1.a.i.", 
    body-indent: 0.5em,
    indent: 1.5em)

#set list(
    indent: 1.5em,
    spacing: 1em,
    marker: (
      [#move(dy:-0.5mm)[#text(size: 1.1em)[$bullet$]]],
      [#text(size: 0.9em)[$bullet$]],
      [#text(size: 0.8em)[$bullet$]],
    )
  )
  
  
#set math.equation(numbering: num =>
    numbering("(1.1)", counter(heading).get().first(), num)
  )
// =====================
// Estados y colores
// =====================

#let main-color-state = state("main-color", black)
#let language-state   = state("language", "en")

// =====================
// Entorno theorem
// =====================

#let exercise(name: none, body) = {
  context {
    let language   = language-state.at(here())
    let main-color = main-color-state.at(here())

    thmbox(
      " ",
      stroke: 0.5pt + main-color,
      radius: 0em,
      inset: 0.75em,
      namefmt: x => [*--- #x.*],
      separator: h(0.2em),
      titlefmt: x => text(weight: "bold", fill: main-color, x),
      fill: black.lighten(90%),
      base_level: 1
    )(name: name, body)
  }
}

#set heading(
  numbering: "1.1.1"
)


// =====================
// Título del documento
// =====================

#let titulo = "Particle Physics I  - Quantum Chromodynamics"
#let autor  = "Daniel Vázquez Lago"
#let fecha  = datetime.today().display()

#align(center)[
  
  #text(
  weight: "bold",
  size: 30pt
  )[Centelleo primario y secundario \ en mezcla $"Ar-CF"_4$  ]

#text(size:15pt)[#autor]  
#text(size:15pt)[#fecha]
]

#outline(title:"Indice", depth: 3, indent: 1em)

#pagebreak()

= Introducción

== Motivación

Las TPCs han sido una de las tecnologías revolucionarias de la física de partículas y nuclear. Lo que hace brillar a las TPCs es, sin duda, la capacidad de reconstruir trayectorias de las partículas. El funcionamiento básico de una cámara de proyección temporal es bastante intuitivo: una partícula deposita la energía en el medio, lo que produce (bien de manera primaria o secundaria) una ionización del gas contenido en la cámara. Esta ionización se podría recoger mediante un campo eléctrico, arrastrándolos hacia un ánodo donde a través de electrónica podremos obtener una señal. La señal será proporcional a la cantidad de electrones. Si además, fuéramos capaces de poner varios detectores (con señales independientes) podríamos obtener incluso la posición donde se produjeron los electrones, "reconstruyendo" la traza de la partícula, e incluso si pudiéramos obtener la señal en función del tiempo, hacer una "reconstrucción temporal" sería posible.  

No es ninguna locura decir que las cámaras de proyección temporal son una de las tecnologías más interesantes que hay, no solo por sus capacidades técnicas, si no por su mezcla de diferentes aspectos de la física. Obviamente podríamos hacer un trabajo enteramente hablando de las TPCs, de cómo funciona la ionización en los gases, las avalanchas... Además de que existen varias clases de TPCs, véase ACTAR TPC, Dual-Phase TPC, MPGD TPC, OTPC... cada una centrándose en una característica

Las OTPC, de _Optical Time Proyection Chamber_ son un tipo de TPC que en vez de recoger electrones recoge fotones. Lógicamente, no se habrían creado las OTPCs si no tuvieran algún tipo de ventaja. Esta reside en que los fotones, a diferencia de los electrones, no experimentan difusión, lo que permite una mejor resolución espacial, además de que hoy en día existen cámaras capaces de detectar unos pocos fotones, mientras que la detección de electrones carece de esta capacidad. Si alguien, por ejemplo, quisiera detectar eventos raros, con depósitos de energía extremadamente pequeños, esta característica sería algo a explotar, tal y como hacen los experimentos DUNE y NEXT entre otros. 

Sin embargo, para que una OTPC funcione hace falta precisamente un elemento que genere fotones, que sea capaz de centellear cuando se deposita energía, como los gases nobles. Los gases nobles son excelentes centelladores, al no presentar grados de libertad rotacionales y vibracionales. Pese a ser excelentes centelladores, la longitud de onda en la que se emite, el llamado _vacuum ultraviolet_ ($lambda tilde $ 120-180 nm) no es exactamente ideal para medir fotones, ya que por ejemplo los PMTs responden mejor en longitudes del visible, o por ejemplo la _Timepix3 Optical Camera_, con una eficiencia alta entre 400-1000 nm #cite(<Fisher-Levine_2016>). 

Si no queremos renunciar a una OTPC, necesitaremos algún modo de hacer que la longitud de onda se convierta al visible, lo que se hace a través de ciertos compuestos, como por ejemplo el $"CF"_4$, $"CO"_2$, $"N"_2$... Estos compuesto, llamados _wavelength shifters_, a través de diferentes reacciones, hace que se emitan en longitudes de onda diferentes. Nosotros, tal y como dice el título del trabajo, nos centraremos en el estudio del centelleo de una de las mezclas más usadas, que es el #ArCF4. 

El #CF4 es una molécula pesada, que contiene elementos con un $Z$ pequeño, por lo que tiene una gran poder de frenado, una velocidad de deriva alta con difusión baja. Además, un punto de operación realmente estable y muy poco envejecimiento #footnote[también por esto es un gas extremadamente contaminante, y la búsqueda de aditivos que lo puedan sustituir van por estos derroteros. Algunos ya se están probando, como el $"N"_2$, aunque con peores resultados.]. Su emisión espectral es ancha, teniendo lineas en el ultravioleta y en el visible, siendo un gas trasparente para su propia emisión y con una emisión rápida (por debajo de los 20 ns, un factor muy importante). Estas propiedades son fundamentales, y nos pueden ayudar a comprender porque es un aditivo tan usado en detectores gaseosos. Por eso precisamente es fundamental tener un buen modelo capaz de describir correctamente el #CF4 y el #ArCF4. 

== Centelleo primario y secundario

En este contexto, resulta esencial distinguir entre los distintos mecanismos responsables de la producción de luz en detectores gaseosos. Como se ha mencionado previamente, la deposición de energía por parte de una partícula cargada conduce tanto a procesos de ionización como de excitación del medio. La radiación emitida como consecuencia directa de estas excitaciones inducidas por la partícula primaria se conoce como centelleo primario, y constituye la base del funcionamiento óptico de las OTPCs. Este centelleo está íntimamente ligado al poder de frenado de la partícula en el gas y a las propiedades intrínsecas del medio, y puede utilizarse como señal inicial para la reconstrucción temporal y espacial del evento.

No obstante, en la mayoría de aplicaciones prácticas, especialmente cuando se requiere amplificación de la señal, los electrones primarios generados por la ionización son transportados por campos eléctricos hacia regiones de mayor intensidad de campo. En estas condiciones, los electrones adquieren suficiente energía cinética entre colisiones como para producir nuevas ionizaciones del gas, dando lugar a procesos de multiplicación por avalancha electrónica. Durante la evolución de estas avalanchas no solo se generan nuevos pares electrón–ión, sino también un número significativo de excitaciones atómicas y moleculares adicionales. La desexcitación radiativa de estos estados excitados es responsable del denominado centelleo secundario, o electroluminiscencia asociada a la avalancha.

El centelleo secundario presenta una relevancia particular en detectores donde la amplificación ocurre en regiones muy localizadas y con campos eléctricos intensos, como es el caso de los detectores gaseosos de microestructura (MPGDs). Dispositivos como los GEMs o los Micromegas permiten controlar con gran precisión el proceso de avalancha, limitando la extensión espacial de la multiplicación electrónica y reduciendo la probabilidad de descargas. En estos sistemas, la producción de fotones durante la avalancha puede convertirse en un observable adicional de gran interés, tanto para la caracterización del detector como para aplicaciones de lectura óptica acoplada.

Por otro lado, en detectores como las RPCs, que operan en regímenes de avalancha o de descarga controlada dependiendo de las condiciones de trabajo, el estudio de los mecanismos de producción de luz resulta igualmente relevante. El centelleo asociado a las avalanchas electrónicas puede proporcionar información detallada sobre la dinámica de los procesos microscópicos, la estabilidad del detector y el papel de las mezclas gaseosas en la supresión o desarrollo de descargas.

En mezclas basadas en argón y #CF4, como la estudiada en este trabajo, el centelleo secundario está fuertemente condicionado por la interacción electrón–molécula. El #CF4 introduce nuevos canales de excitación y desexcitación, modificando tanto el rendimiento luminoso como el espectro de emisión. Además, la elevada velocidad de deriva y la baja difusión electrónica asociadas a este gas influyen directamente en la evolución espacial y temporal de las avalanchas, afectando de manera indirecta a la distribución de fotones emitidos. Comprender estos procesos a nivel microscópico resulta clave para interpretar correctamente las señales ópticas y optimizar el diseño de detectores basados en lectura por fotones.

En este trabajo se aborda el estudio del centelleo, tanto primario como secundario, en mezclas #ArCF4 desde un punto de vista microscópico, analizando la producción de excitaciones durante la evolución de avalanchas electrónicas en campos eléctricos intensos. Mediante simulaciones detalladas es posible correlacionar la dinámica de los electrones, los distintos tipos de colisiones y la emisión de fotones, proporcionando un marco coherente para la interpretación de detectores gaseosos con capacidad de lectura óptica y para el desarrollo de modelos realistas del comportamiento del #CF4 y sus mezclas.


= Objetivos del trabajo 

Una vez hemos entendido las razones por la cual esta mezcla es de interés, podemos plantear los objetivos. Sin embargo hay que tener una cosa en cuenta: el objetivo principal siempre será estudiar el centelleo de las mezclas #ArCF4. En este contexto, los objetivos son: 


- Simulación de la interacción de un rayo X con mezclas de #ArCF4. El objetivo de la simulación será obtener el número y tipo de excitaciones (por fotón) resultantes para un rayo X. Para ello un breve repaso sobre las interacciones fotón - materia será realizado. 

- Simulación de la interacción de un electrón con mezclas #ArCF4 en el contexto de MPGDs (avalanchas). El objetivo de la simulación será obtener el número y tipo de excitaciones (por electrón) resultantes. 

- Creación de un modelo microscópico fenomenológico sobre la emisión de luz para mezclas #ArCF4 en OTPCs. 

- Aplicación de los estados obtenidos en la simulación para obtener la cantidad de fotones por rango de emisión producido. Comparación con experimento, y ajuste para obtener parámetros. Comparación con modelos fenomenológicos anteriores. 

- Aplicación del nuevo modelo con los parámetros obtenidos para la predicción de  centelleo en GEMs (centelleo secundario). 

/*
En relación con la asignatura: 

 - Estudio de diferentes modelos de interacción fotón-materia y electrón-materia. Relación entre la física atómica de la interacción radiación materia. 
 - Compresión del funcionamiento de software Degrad/Garfield++/Magboltz, especializado en la simulación de la interacción radiación materia en detectores gaseosos y de silicio. 
 - Compresión del centelleo en gases _state of the art_ en las que la emisión observable resulta de la competencia entre procesos radiativos y colisiones no radiativas. 

*/

= Simulaciones e interacciones $gamma,e^(-)$ con mezclas #ArCF4  <Sec:simulaciones>


== Interacciones rayo X $-$ átomo

Las interacciones de los fotones con menos de 100 keV con la materia se pueden resumir en: 

- *Efecto Compton y Rayleight*. El efecto Rayleight es la dispersión elástica del fotón con un átomo/electrón. El efecto Compton se define como la interacción inelástica del fotón con un electrón de una capa externa del átomo. Resulta en la modificación de la longitud de onda del fotón, trasferiendo momento al átomo/electrón. Ambos casos están modelados por la sección eficaz de Klein-Nishina (QED). 

  $ gamma + X arrow.long X + gamma^((*))  $
  
- *Efecto fotoeléctrico*. El que el fotón es absorbido por un electrón de una capa (fotoabsorción). Dentro del efecto fotoeléctrico tenemos varios fenómenos: 

  - _Shake off_. Es el efecto fotoeléctrico por antonomasia, en el que tras la aborción, el electrón sale despedido dejando un ion (a veces excitado) 
    $ gamma + X arrow.long X^(+,(*))  + e^- $
    llamando al electrón generado _fotolectrón_. Es el único proceso que ocurre como un único paso #cite(<x-ray-spectroscopy>). 
  - _Auger_. Tras la emisión del electrón por efecto fotoeléctrico, la vacante creada debe ser llenada por un electrón de una capa superior. Cuando el electrón de la capa superior finalmente cae de capa, interacciona con otro electrón, eyectando a este último. Así pues, Se genera un átomo doblemente ionizado.
  
    $ gamma + X arrow.long X^(+,(*))  + e^- arrow.long X^(++,(*))  + 2 e^- $ 
    Evidentemente características energéticas diferencian un electrón Auger de un fotoelectrón.  Los electrones emitidos tienen energías discretas; sin embargo, debido a la naturaleza estocástica del proceso de relajación, el número y las energías de los electrones emitidos varían para cada vacante inicial creada en una subcapa determinada (es decir, K, L1, L2, etc.). La mayoría de estos electrones Auger presentan energías muy bajas ($tilde$20–500 eV). 

    Cabe destacar que los eventos Auger realidad pueden ser mucho más complicados, ya que se pueden emitir varios electrones Auger (hasta 4) #cite(<multipleAugerDecay>). En la línea procesos Coster–Kronig y Súper Coster–Kronig, en el que se especifican las capas de emisión.
    
  - _Fluorescencia_. Es un proceso similar al efecto Auger, de hecho compite directamente con él. La diferencia es que cuando el electrón cae de la capa, emite un fotón.
  
    $ gamma + X arrow.long X^(+,(*))  + e^- arrow.long X^(+,(*))  +  gamma + e^- $ 

El modelado de la fluorescencia y de la emisión Auger está extremadamente relacionado con la física atómica. No es muy difícil darse cuenta por qué. Ambos procesos ocurren cuando un electrón realiza una transición entre _niveles atómicos_. De igual manera el centelleo en los gases está relacionado con la emisión de fotones debido a las desexcitaciones. Por tanto, si nosotros queremos estudiar el centelleo de gases nos tendremos que preocupar de que tipo de excitaciones ocurren debido a la interacción entre el rayo X y el #Ar/#CF4. Tratar de obtener las diferentes secciones eficaces para cada una de las excitaciones o emisiones teóricamente es extremadamente complejo, ya que implica usar funciones de onda de los electrones (usar la función de onda de un electrón individual es una simple aproximación, la manera más genérica y realista sería usar la función de ondas global), y aplicarlo en el modelo de Bohr (por lo que aproximaciones en función de la energía incidente de la partícula son necesarias). 


#columns(2)[

  Aunque todo esto es interesante, la interacción de un rayo X con la materia va mucho más allá de las interacciones individuales de un fotón con un átomo. Los fotoelectrones y electrones Auger producidos poseen energías suficientes como para inducir nuevas ionizaciones y excitaciones, dando lugar a cascadas electrónicas secundarias. En determinados casos, los fotones de fluorescencia emitidos también pueden ser reabsorbidos y producir ionizaciones adicionales, aunque este proceso depende fuertemente del material y de la energía del fotón. En la figura @Fig:foton podemos ver como estas interacciones secundarias pueden producir neuvos fotones y electrones.  

 #colbreak()
  
  #v(-0.9em)
  #figure(image("Imagenes/foton-materia.png",width: 88%),
    caption: [Interacción fotón-materia#cite(<Podgorsak2016RadiationPhysics>).]
  ) <Fig:foton> 

] 


Por tanto, una simulación realista no solo debe considerar las secciones eficaces de interacción fotón–átomo y registrar la energía depositada, sino que también debe describir el transporte y la interacción de las partículas ionizantes secundarias. Esto requiere un conocimiento detallado de las energías de los electrones Auger y fotones fluorescentes, lo que a su vez implica identificar las capas electrónicas implicadas y los procesos de relajación atómica asociados.

Como ya hemos dicho, nosotros necesitamos una simulación que nos de el número de excitaciones/iones finales, cuando ya no se produce más ionización (primaria, debido al rayo X incidente, o secundaria, producida por los fotoelectrones). Dado que las simulaciones de la interacción radiación materia se basan fundamentalmente en las secciones eficaces, lo que queremos nosotros es las secciones eficaces de que el fotón interaccione con determinado/a electrón/capa de un átomo de la mezcla, que además incluya la posterior emisión de fotones/electrones, y que calcule sucesivamente las ionizaciones hasta que finalmente nos de el número de iones/excitacioens y tipo del átomo. En este contexto, el modelo PAI/PAIR aparece como un claro candidato. 



== Modelo PAI y PAIR 

#v(0.6em)

#columns(2)[

  El modelo PAI (_Photon Absortion Ionization_) y sus evoluciones PAIR (_Photon Absortion Ionization and Relaxation_) #cite(<SMIRNOV2005474>) son dos de los modelos más potentes a la hora de describir la interacción entre partículas cargadas (electrones, piones, muones...)  @Fig:PAI y fotones con la materia, ya que no solo nos permite estudiar la energía depostida por la partícula en la materia, si no que nos permite ver diferenciar las interacciones con diferentes niveles atómicos.
    
  Por un lado  modelo PAI original contiene únicamente las secciones eficaces entre la partícula incidente y el átomo como un conjunto,  lo que no permite estudiar los fenómenos de Auger y de fluorescencia. 

  #colbreak()
  
  #v(-0.9em)

  #figure(
  image("Imagenes/PAI.png",width: 105%),
  caption: [Modelo PAI para la interacción de una partícula cargada con un átomo. El mecanismo de interacción a través de un fotón virtual..]
  ) <Fig:PAI>
] 

Por otro lado, el modelo PAIR calcula las secciones eficaces parciales de interacción con las diferentes capas. La ventaja de PAI y PAIR es que tiene en cuenta no solo la interacción de un fotón con un electrón individual de una determinada capa, si no que también tiene en cuenta la constante dieléctrica $epsilon = epsilon_1 + i epsilon_2$ en el que participarían todos los electrones del átomo. La sección eficaz para un cierto átomo $n_a$ y capa $n_s$, viene dada por 

$ (dif sigma_i (E,n_a, n_s))/(dif E)  = & alpha/(beta^2 pi) (f(n_a) sigma_(gamma,i) (E,n_a,n_s))/(E|epsilon|P 2) ln((2m_e c^2 beta^2) /(sqrt((1-beta^2 epsilon_1)^2 + beta^4 epsilon_2^2)))  \ + &  alpha/(beta^2 pi)   H ( E - I_min) (f(n_a) sigma_(gamma,i) (E,n_a,n_s))/(dash(sigma)_gamma(E)) 1/(N hbar c) (beta^2 - epsilon_1/(|epsilon|^2)) theta \ +  & alpha/(beta^2 pi) H((E-I(n_a))) R(E) integral_0^E f(n_a) sigma_gamma(E_1,n_a,n_s) dif E_1  $ 
donde $dash(sigma)$ es la media de la sección eficaz de fotoabsoción, $H(x)$ la función escalon de Heavside, $I$ es el potencial de ionización, y $f(n_a)$ es la fracción de dichos átomos en el gas. El término $sigma_(gamma,i)$ denota la sección eficaz de fotoionización.

Las secciones eficaces de fotoabsorción y fotoionización son bien conocidas (véase #cite(<atomicPhotoabsortion>) por ejemplo). Conociendo las energías de cada nivel atómico, y las transiciones de Auger/Fluorescencia podemos obtener además las emisiones de fotoelectrones/electrones Auger/fotones fluorescentes, lo que permitiría calcular la cascada de eventos posterior hasta que las ionizaciones producidas ya no fueran capaz de generar nuevos procesos ionizantes, tal y como queríamos. 

== Softwares de interacción fotón $-$ gas: PAI vs Degrad


Pese al poder de PAI y PAIR, y sus implementaciones en software (Heed en Garfield++, G4PAI y G4PAIPhotonModel en Geant4) son realmente interesantes, no tienen en cuenta efectos como las disociaciones neutras (por ejemplo la separación $#CF4 arrow #CF3 + "F"$), las excitaciones moleculares y vibracionales. Esto en principio no sería un problema para estudiar el Argón, pero sí para estudiar el #CF4 (además tal y como veremos serán fundamentales para estudiar el centelleo). 

Por otro lado, Degrad, un software desarrollado por Steve Biagi, si que contiene las secciones eficaces tanto de las disocaiciones neutras, excitaciones moleculares y vibracionales. Además, incluye modelos de cascadas Auger para interacciones de fotones y electrones ionizantes; así como fotoabosciones, scattering de Compton/Thomson y producción de pares, subsecuentemente es capaz de simular Auger, procesos de _shake-off_ y fluorescencia, incluso fenómenos de Bremmstrahlung. Y todo además incluyendo la capacidad de hacer la simulación en presencia de campos eléctricos y magnéticos, lo que es fundamental en el contexto de MPGDs y RPCs. En este contexto, Degrad es, probablemente, el software de interacción fotón/electrón en gases más poderoso que hay actualmente, y por tanto el que usaremos para la simulación del rayo X con las mezclas #ArCF4. Además incluye secciones eficaces de interacción electrón-gas, lo que le convierte también en un software completo, tal y como PAI.  Véase  #cite(<Pfeiffer:2018yam>) para interfaz Degrad-Geant4-Garfield++.


Degrad entonces hace una simulación completa de la interacción, siendo el producto de la simulación una la lista de eventos que han ocurrido. Es decir, Degrad nos dice cuantas interacciones elásticas han ocurrido, cuantas ionizaciones del Argón han ocurrido (y cuantas del tipo $Ar^(++)$ y $Ar^(+++)$)... Para el #Ar  incluye hasta 53 interacciones, entre las que encontramos: excitaciones, ionizaciones, colisiones elásticas, _attachment_ y bremmstralungh. Para el #CF4 incluye 62, desde excitaciones vibracionales, ionizaciones, disocaciones neutrales, disociaciones cargadas (disociación de iones), _attachment_ y bremmstralungh. En las figuras @Fig:Ar_levels y @Fig:CF4_levels vemos el _output_ de Degrad (obviado las colisiones elásticas ya que el su orden es de $10^3$ o $10^4$). Con esto  ya habríamos cumplido uno  de los objetivos. 

#pagebreak()

#columns(2)[
#figure(image("Imagenes/ar_degrad_output_80Ar_20CF4.pdf",width: 100%),
  caption: [Eventos por ionización primaria para el #Ar en una mezcla del 80% Ar y 20% #CF4.]
) <Fig:Ar_levels> #colbreak()
#figure(image("Imagenes/cf4_degrad_output_80Ar_20CF4.pdf",width: 100%),
  caption: [Eventos por ionización primaria para el #CF4 en una mezcla del 80% #Ar, 20% #CF4.]
) <Fig:CF4_levels>

]



== Software de interacción electrón $-$ gas: Garfield++ y Magboltz

Garfield++ (C++) es un software que permite la simulación detallada de detectores de partículas basadas en ionizaciones en gases o semiconductores #cite(<GarfieldPPUserGuide>). Garfield++ está optimizado para el transporte de electrones de baja energía ($lt.eq$ 100 eV) en geometrías  gracias a la interfaz la base de datos Magboltz que contiene las secciones eficaces electrón-átomo/molécula #cite(<BIAGI1999234>). Además, a través del otros programas/modelos (Heed,  PAI, PAIR #cite(<pair_model>))  y bases de datos (SRIM, TRIM), también es capaz de simular la ionización por parte por ejemplo de fotones (aunque sin interfaz a Degrad, por lo que no será usado en nuestro caso), iones pesados...  Magboltz (diseñado también por Steve Biagi) usa la misma base de datos de secciones eficaces electrón-átomo que Degrad, por lo que usar Garfield++ junto con Magboltz tiene las ventajas de usar Degrad, y al ser un programa C++, es un programa mucho mas _user friendly_ que Degrad (Fortran 77). En las figuras @Fig:Ar_cs y @Fig:CF4_levels podemos ver las secciones eficaces para cada interacción (elástica, ionización, _attachment_ e inelśaticas). Tanto en las excitaciones como en las inelśaticas tendríamos varios términos en función de cual se genera. 


#columns(2)[
#figure(
  image("Imagenes/cs_Ar.pdf",width: 100%),
  caption: [Sección eficaz para el $e^- -$ #Ar.]
) <Fig:Ar_cs>#colbreak()
#figure(
  image("Imagenes/cs_CF4.pdf",width: 100%),
  caption: [Sección eficaz para el $e^- -$ #CF4.]
) <Fig:CF4_cs>

]

La ventaja de Garfield++ es que es capaz de simular la _ionización primaria_ (interfaz con Heed, Degrad, SRIM y TRIM) y el transporte de los electrones e iones generados (ecuaciones de transporte de Boltzman y Magboltz). Esto extremadamente interesante, porque cuando una partícula ioniza un gas, los detectores gaseosos deben recoger esa ionización y producir una señal, algo que Garfield++ es capaz de simular. Así, Garfield++ es fundamental para estudiar las avalanchas producidas en MPGDs y RPCs. 

Para reproducir de manera realista la señal inducida en detectores gaseosos, no basta con conocer el número total de electrones producidos, sino que es necesario describir su dinámica microscópica en el gas. Garfield++ aborda este problema mediante una simulación de transporte electrónico basada en secciones eficaces dependientes de la energía, permitiendo seguir electrón a electrón su evolución entre colisiones sucesivas.

Así pues, realizaremos una simulación de un GEM mediante la aproximación de _campo uniforme_ (básicamente supondremos que el campo eléctrico de un GEM es uniforme). La intención será obtener el número de excitaciones e interacciones (exactamente igual que con el rayo X) generado por un solo electrón. 

== Simulaciones en GEMs para el centelleo secundario


#columns(2)[

  #v(0.9em)

  Garfield básicamente hace un _seguimiento microscópico_ (@Fig:drift) de los electrones en el gas, basado en métodos de Monte Carlo, lo cual es relativamente costoso. Partiendo de un electrón, con una posición y velocidad determinada, debido a la presencia del campo eléctrico, el $e^-$ comenzará a derivar en la dirección contraria al mismo. Entre una colision y otra colisión, el electrón es trazado en una trayectoria clásica (ecuaciones de transporte de Boltzman) de acuerdo con el campo eléctrico/mangético presente. Durante este vuelo de tiempo $Delta t$, cada paso estará controlado por $tau^(-1) (epsilon) = sum_i tau_i^(-1) (epsilon)$. 


  #colbreak()
  
  #v(-0.6em)

  #figure(
    image("Imagenes/drift.pdf",width: 90%),
    caption:[Avalancha de electrones generada por garfield++. Nótese el seguimiento microscópico.  ]
  ) <Fig:drift>

] 

La generación de $Delta t$ vendrá dado por #cite(<Skullerud_1968>), el cual permite obtener el cambio de energía del electrón durante el paso. Tras cada paso, la energía, dirección y posición será actualizado, y el proceso de dispersión tendrá lugar. Cual se decidirá en función de los ratios de colisión $tau$ a la nueva energía $epsilon'$. La energía y dirección volverán a ser actualizado de acuerdo al tipo de colisión. 

Tras las simulaciones podemos obtener los eventos (@Fig:Ar_levels2 y @Fig:CF4_levels2) por avalancha, en el caso que podemos obtener el número de estados exactamente igual que lo haríamos en el caso de Degrad, aunque en este caso usamos la propio histograma de Cern Root para graficarlo. Cabe destacar que el bin 53 de la  @Fig:CF4_levels2 corresponde a los _eventos elásticas_. 

#columns(2)[
#figure(image("Imagenes/ArLevels.png",width: 100%),
  caption: [Eventos en avalancha del GEM para el #Ar en una mezcla del 90% Ar y 10% #CF4.]
) <Fig:Ar_levels2> #colbreak()
#figure(image("Imagenes/CF4levels.png",width: 100%),
  caption: [Eventos en avalancha del GEM para el #CF4 en una mezcla del 90% #Ar, 10% #CF4.]
) <Fig:CF4_levels2>
]

 
= Modelo microscópico

Una vez se producen todas las excitaciones e ionizaciones de una mezcla, las posibilidades son tremendas, ya que no solo se producen las correspondientes desexcitaciones, si no que estas _pueden interaccionar entre sí_. Incluso es posible que se acaben formando nuevas especies, como son los excímeros, un tipo de diméro con un tiempo de vida determinado que no es estable (i.e. no existe) cuando ambos monómeros están en su estado fundamental. 

La emisión de luz (en el espectro que sea), por otra parte, corresponde siempre a decaimiento de determinadas excitaciones. Si uno quiere optimizar el aditivo molecular que añadir al argón obviamente necesitará conocer el origen de dichas excitaciones, tratando de maximizar la interacción entre los precursores y el aditivo molecular. Por otro lado, añadir un aditivo molecular trae consigo muchas mas interacciones que las deseadas, aunque no tienen que ser necesariamente problemáticas.acarrean una complicación en el modelado. 

La forma de trabajar en esto es a través de modelos microscópicos. Los modelos microscópicos usan directamente las interacciones entre los elementos del medio, usando parámetros efectivos como tiempos de vida medio ($tau$), ratios de interacción ($K$). Y el primer paso para desarrollar un modelo microscópico, en particular de  #ArCF4, es realizar una descripción coherente de los estados excitados e ionizados de cada componente. 

No vamos a analizar profundamente la notación espectroscópica, no por que no sea relevante, si no porque no es de nuestro interés. Si usamos la notación es simplemente por completitud. Recordamos que lo que queremos es ver _cuales estados son los que generan luz_, y cuales son las interacciones que ocurren entre los estados de interés y los precursores de estos de un modo fenomenológico, esto es, poder describir los resultados experimentales. Además querremos relacionar de alguna manera los estados emisores de luz con los obtenidos en las simulaciones anteriores. 

== Estados del Argón

El argón por ser un gas noble no posee, por ejemplo, grados de libertad vibracionales. Esto hace que las posibles estados que podamos encontrar el argón dentro del medio serán

- Excitaciones . Lo que normalmente se denota como $Ar^*$. Cuando se conoce el electrón (capa) que está excitado se le asigna un símbolo espectroscópico, véase $Ar^*(s_4)$. Cuando queremos denotar una excitación genérica o incluso desconocida usamos la notación $Ar^(**)$.
- Ionizaciones. Las ionizaciones denotadas  como $Ar^+$, también pueden tener estados excitados, tal que es posible encontrar $Ar^(+,*)$ que también puede recibir símbolos espectroscópicos.
- Excímeros. Los excímeros de argón son básicamente moléculas formadas por un argón excitado y otro argón que puede estar excitado o no. Se denota como $Ar_2$, con un símbolo espectroscópico asociado, como puede ser $Ar_2 (¹Sigma_g)$ (excímero fundamental) 

Nuevas posibilidades son barajadas (moléculas de tipo $Ar_3$ o más) tal y como sugiere #cite(<Santorelli2021>). Todavía esta en investigación. 

== Emisiones del Argón

Los primeros trabajos en los años 50 sobre plasmas de gases nobles (Ar, Kr, Xe, He, Ne) fueron estudiados ampliamente por su capacidad de producir bandas espectrales en el VUV. En los años 70 se mostraron como estos gases podrían usarse para láseres, con picos de Ar (126 nm), Kr (146 nm) y Xe (178 nm). Los primeros estudios sobre el estos gases, con un comportamiento similar, mencionan como las transiciones podrían ser descritas como la emisión de lo que se llamo un "segundo continuo", que no es más que _transiciones entre excímeros excitados y excímeros en sus estados fundamentales_. // En la imagen podemos ver como sería un _pathway_ para el Xe. La razón por la que se llama continuo es evidente, en realidad. 

Sin embargo, cuando se amplio el dominio de longitudes de onda se observaron fenómenos no asociables con este segundo continuo. A este fenómeno se le denominó *tercer continuo* (denotado como $X_(3"rd")$ ),  y ya por aquel entonces se sugería que podrían venir de transiciones del tipo $X_2^(++,*) arrow X^+ + X^+$, o de transiciones relacionadas con $X_2^(+,*)$ #footnote[aquí usamos el $X$ queriendo decir que $X$ podría ser _cualquier_ gas noble. De todos modos compre decir que la relación con $X_(+,*)$ no se tiene que dar en todos los gases. Con en el Argón si ocurre.]. Incluso relaciones con especies del tipo $X_3^(++,*)$ podrían llegar a estar relacionadas. El tercer continuo se mostró inmediatamente como un fenómeno importantísimo en el campo espectral, con un FWHM de 10 a 100 nm en un rango típico de 60 a 400 nm dependiendo del gas. En la @Fig:Ar_3rdContinuo podemos ver lo ancho que puede ser el espectro #cite(<ROBERT1995179>). 

#figure(
  image("Imagenes/Ar.png",width: 100%),
  caption: [Espectro del $Ar_(3"rd")$ a 1 bar #cite(<ROBERT1995179>). Eje x: longitud de onda en nm.]
) <Fig:Ar_3rdContinuo>


Además, la emisión del tercer continuo dependería de la presión de medida. En el caso del Argón el pico varía desde los 230 nm a 0.5 bar a 270 a 2 bar. Medidas más recientes hechas en la Universidad de Santiago de Compostela, para varias presiones, y comparándolo con otros resultados, pueden ser observadas en la @Fig:ArCompleted, ahora si con el _espectro completo_. Podemos ver lineas asociadas a las transiciones entre multipletes del Ar $3 p^5 4p - 3 p^5 4 s$ entorno a los 700 y 800 nm y líneas asociadas a presencias de impurezas, como el  $"H"_2"O"$ sobre los 310 nm y el $"N"_2$ sobre los 335-380 nm  #cite(<CF4WaveLenghtShifter>). 

#figure(
  image("Imagenes/ArEspectroCompleto.png",width: 105%),
  caption: [Espectro completo del Argón  #cite(<CF4WaveLenghtShifter>)]
) <Fig:ArCompleted>



== Estados del #CF4

El hecho de que pueda tener configuraciones estructurales también implica que las excitaciones son diferentes. 

- Excitaciones #CF4. Análogo al Ar, se asocia el $CF4^*$ a una excitación, con símbolo espectroscópico cuando es conocido, como $CF4^*(X)$. También existen excitaciones debido a estados vibracionales.
- Ionizaciones #CF3. Análogo, en este caso podremos tener por ejemplo $CF4^(+,*)$, incluyendo notaciones espectroscópicas, tales como $CF4^(+,*)(C)$.
- En el caso del #CF4 es posible que se desprenda un flúor creando #CF3. Es posible tener excitaciones e iones del #CF3, con su propia notación espectroscópica. Véase por ejemplo $CF3^*(2A_2'')$. 

#pagebreak()

== Emisiones del #CF4

#v(0.5em)

#columns(2)[
  El #CF4 ha sido una molécula bien estudiada. En la @Fig:CF4-spectra podemos ver las dos bandas que mencionábamos arriba, una en el ultravioleta 210-330 nm el visible entorno a los 550-700 nm. La región del visible, con un pico de 630 nm,  está asociada típicamente a la transición $CF3^* (2A_2 '',1E') arrow CF3(1A_1')$#footnote[Que la transición $CF3^*$ al $CF3$ se de para dos excitaciones diferentes, la $2A_2 ''$ y la $1 E '$ se debe a que ambas tienen una energía muy similar, y no se puede distinguir cual es la que realmente domina, o sin son ambas las que se producen y decaen. Véase #cite(<whasidaCF3Radicals>) para más información.] #cite(<whasidaCF3Radicals>). Por otro lado, las emisiones en el la zona ultravioleta (230 y 290 nm) están asociadas al $CF4^(*,+)$, desde los estados $tilde(C)$ hacia los estados $tilde(A), tilde(X)$, mientras que un pequeño pico en 364 nm puede asociarse a $tilde(D) arrow tilde(C)$. En cualquier caso, este último se puede ignorar. Se puede observar una clara dependencia con la presión por parte de los espectros. Véase más en #cite(<CF4WaveLenghtShifter>).

  #colbreak()
  
  #v(-0.9em)

  #figure(
  image("Imagenes/CF4-general.png",width: 105%),
  caption: [Espectro del #CF4 #cite(<MOROZOV20101456>)]
  ) <Fig:CF4-spectra>
] 
  
== Mecanismos de interacción #ArCF4

En los anteriores apartados hemos visto cuales son los estados/especies que emiten luz de los compuestos Ar y #CF4 por separado. Los estados que emiten luz en las mezclas por separado deben ser los mismos que emitan luz en la mezcla, por eso hemos hecho dicha presentación. Sin embargo no debe cumplirse necesariamente que la producción de dichos estados sea la misma, es más, es esperable que el comportamiento del espectro en la mezcla tenga comportamientos diferentes. Sin embargo estudiar una mezcla entraña decisiones más complicadas, ya que un estudio completo necesitará una gran cantidad de medidas en función de la concentración.  


#columns(2)[ #v(0.3em)
#figure(
  image("Imagenes/ArCF4_Primario.png",width: 110%),
  caption: [Espectro primario de la mezcla a 80% Ar y 20% #CF4 #cite(<PrimaryAndSecundaryArCF4>).]
) <Fig:ArCF4-primary-spectra>#colbreak()
#figure(
  image("Imagenes/Ar-CF4.png",width: 110%),
  caption: [Espectro secundario de la mezcla a 80% Ar y 20% #CF4 #cite(<PrimaryAndSecundaryArCF4>)]
) <Fig:ArCF4-second-spectra>
]

En las @Fig:ArCF4-primary-spectra y @Fig:ArCF4-second-spectra se observan dos cosas muy importantes. La primera, que el espectro depende bastante de la presión. La segunda, que depende de la energía depositada en el medio por parte de la partícula que sea, ya que la principal diferencia entre la primera imagen (centelleo primario) y la segunda imagen (centelleo secundario) es la cantidad de energía que se deposita. El centelleo primario en este caso es el producido por un rayo X, mientras que el secundario está asociado a los electrones generados por la avalancha en un GEM #cite(<PrimaryAndSecundaryArCF4>). 

Aunque que dependa de la energía depositada, en principio esto no debería ser algo realmente de interés, ya que en principio lo único que implica es que con más energía depositada podemos llegar a excitaciones mayores, y aquellos excitaciones de interés cuyos precursores sean más energéticos abundarán más. En ambos casos los estaos producidos serán los mismos, al menos según las simulaciones, solo diferirán en la abundancia. 

Los resultados experimentales de la @Fig:ArCF4-spectra (y las anteriores) por p presentan una evidentísima capacidad de transformar la longitud de onda. Fijémonos como en el argón @Fig:ArCompleted y el #CF4 @Fig:ArCompleted hay un dominio claro del ultravioleta (excepto a presiones altas en el #CF4, a partir de 3 bar), mientras que en el caso de la mezcla el espectro del visible y el ultravioleta tiene una intensidad similar (a partir del 0.5% #CF4). 


Como podemos ver en las imágenes la emisión del visible 630 nm es debida puramente al $CF4$, por lo que una presencia observable en concentraciones realmente bajas como puede ser 0.2% o 0.5% (de #CF4) hace patente que _hay un mecanismo de interacción entre los precursores del $CF3^*$ y el $Ar$_.  Así mismo, también podemos observar como aparecen los dos picos característicos del $CF4^(+,*)$ a concentraciones bajas como 1% o 2%, por lo que _también tiene que haber un mecanismo de interacción entre los precursores del $CF4^(+,*)$ y el $Ar$_. 



Una vez hemos entendido esto vamos a deducir la expresión de la probabilidad de emisión $P_gamma$ en función de las probabilidades de que se produzcan determinados compuestos, a saber, $P_(Ar_("3rd"))$ es la probabilidad de que se forme el $Ar_("3rd")$. El estudio que vamos a hacer es a continuación es similar al que se hace en #cite(<CF4WaveLenghtShifter>), que actualmente es el modelo fenomenológico más completo. Sin embargo nosotros vamos a introducir unas pequeñas mejoras. Sea $f$ la *concentración de* $CF4$ y sea $n$ la *presión normalizada* a 1 bar ($n=p slash p_0$ donde $p_0 =$ 1 bar), veamos que

#figure(
  image("Imagenes/ArCF4-Abosuluto.png",width: 105%),
  caption: [Espectro de emisión del #ArCF4 a diferentes concentraciones y presiones . Resultados realizados con fuente primaria de rayos X. Imagen tomada de #cite(<CF4WaveLenghtShifter>).]
) <Fig:ArCF4-spectra>

- La emisión del visible por parte del #CF4 viene dada por la transición  $CF3^* (2A_2 '',1E') arrow CF3(1A_1')$, por lo que nos interesan los precursores $CF3^* (2A_2 '',1E') $. Habrá $CF3^* (2A_2 '',1E') $ que se exciten procedentes de las excitaciones que deja a su paso la partícula ($e⁻,gamma$), que es el mecanismo que domina en $CF4$ puro. Por otro lado, el mecanismo de interacción podrá ser entre algún elemento excitado del Argón, sin decidir cual, denotándolo entonces como $Ar^(**)$: 
  $ Ar^(**) + CF4 arrow.long^(K_(Ar^(**) arrow CF3^*)) Ar + CF3^* $
  Sin embargo también es posible que el $Ar^(**)$ interaccione con otro argón, tal que 
  $ Ar^(**) + Ar arrow.long^(K_(Ar^(**) arrow Ar^*)) Ar^* + Ar $
  por lo que habrá una competencia entre ambos fenómenos. Como los $K$ son ratios, su unidad es $"s"^(-1)$. Además dado que son colisiones a dos cuerpos los términos serán proporcionales a la presión y a la concentración. Por ejemplo $K_(Ar^(**) arrow CF3^*)$ irá con $f dot n$, ya que una vez se produce el $Ar^(**)$ (parametrizado por $P_(Ar^(**))$, la probabilidad de que se produzca), lógicamente el ratio depende de la concentración de $CF4$ ($f$) y de la presión ($n$) por ser una colisión a dos cuerpos. Por otro lado $K_(Ar^(**) arrow Ar^*)$ irá con $1-f$ y con $n$. Así pues
  
  $ P_(gamma,"vis" CF3) = f dot P_(gamma,CF3^* "dir")  + [(1-f) dot P_(Ar^(**)) dot p_(CF3^*(2A_2')) dot (f dot K_(Ar^(**) arrow CF3^*))/(f dot K_(Ar^(**) arrow CF3^*) + (1-f) dot K_(Ar^(**) arrow Ar^*))  ] $
  siendo además $p_(CF3^*(2A_2 '))$ la probabilidad de que la excitación del $CF3^*$ sea la deseada. En esta ecuación hemos asumido que _todos los $CF3  (2A_2 '',1E')$ que se producen en emiten_. Si por ejemplo hubiera _selfquenching_ u otros mecanismos habría que añadir factores (por ejemplo, probabilidad de que emita una vez se llega a dicho). La ecuación de arriba lo que nos viene a decir es que "la probabilidad de emisión del #CF3 en el visible viene dada por la suma de la probabilidad de que se produzcan excitaciones que finalmente lleguen al $CF3  (2A_2 '',1E')$, y la probabilidad de que se produzca el $CF3  (2A_2 '',1E')$ por la interacción del #CF4 con un estado del Ar". Cabe destacar que todavía no se sabe exactamente cuales son los estados del $Ar^(**)$ que se producen. 
- La emisión del ultravioleta por el #CF4 viene dada por $CF4^(*,+)$. Como hemos visto, hay interacciones con el $Ar^(+,*)$ o $Ar^(++)_(n=2,3)$ (con excímeros), que pueden ser: 

  $ underbrace(Ar^(+,*)_(n=2,3) (Ar^(++)_(n=2,3)),Ar_("3rd"))  + CF4 arrow.long^(K_(Ar_("3rd") arrow CF4^(+*))) Ar + CF4^(+*)  $ <Eq:competencia1>
  mientras que por otra parte también existe la posibilidad 

  $ Ar_("3rd")  + CF4 arrow.long^(K_(Ar_("3rd") arrow Ar)) "estados no radiativos"  $ <Eq:competencia2>
  además de la probabilidad de que el $Ar_("3rd")$ también decaiga emitiendo luz #cite(<Santorelli2021>)

  $ Ar^(+,*)_(n=2,3) (Ar^(++)_(n=2,3))   arrow^(tau_Ar_("3rd")) Ar + Ar + (Ar) + h nu (180-300 "nm")  $ <Eq:competencia3>
  
  Si supusiéramos que todos las interacciones con el argón llevan al estado $CF4 (tilde(C))$, y que una vez se produce este, la única posibilidad es la emisión de luz, tendríamos la siguiente fórmula de la probabilidad de centelleo: 
  
  $ P_(gamma,"uv" CF4) = f dot P_(gamma,CF4^(+,*) "dir")  + [ (1-f) dot P_(Ar_("3rd")) dot (f dot n dot K_(Ar_("3rd") arrow CF4^(+,*)))/(n f dot (K_(Ar_("3rd") arrow Ar) + K_(Ar_("3rd") arrow CF4^(+,*))) + tau_("3rd") )  ] $
  
  que sería precisamente el modelo usado en #cite(<CF4WaveLenghtShifter>). Sin embargo podemos observar en la @Fig:CF4-spectra como existe una clara dependencia con la presión del pico de las emisiones,  dependencia que no es modelada por esta probabilidad de centelleo, ya que la dependencia de la presión en la fórmula aparece en la presencia de $Ar$, pero si $f=1$ (100\% #CF4) vemos que desaparece. 
  
  Es decir, existen mecanismos que no estamos teniendo en cuenta, que además aparece tanto a 100%  de #CF4, por lo que podemos suponer que la interacción que esté sucediendo tiene que ver con el $CF4 (tilde(C))$. Por un lado hemos asumido que todo $CF4^(*,+)$ precursor acaba en el $CF4 (tilde(C))$, cuando  esto no tiene por qué ser así. Una posibilidad es que algunos de los $CF4^(*,+)$ en colisiones con otros $CF4$ acaben produciendo efectivamente el estado deseado, tal que 

   $ CF4^(*,+) + CF4 arrow.long^(K_("kool")) CF4^(*,+)(tilde(C)) + CF4^* $

   y que por otra parte

   $ CF4^(*,+) arrow.long^(tau_1) " estados no radiativos" $
  lo que modelaría con un nuevo producto del tipo

  
   $ (n dot f dot K_("kool"))/(n dot f dot K_("kool") + tau_1 ) $
  
  Y otra posibilidad podría ser el llamado _autoquenching_, es decir, que en la interacción con otro $CF4$ se desexcite. Este mecanismo vendría regulado por

  $ CF4 (tilde(C)) + CF4 arrow.long^(K_("scint")) "estados no radiativos" $
  mientras que 
  $ CF4 (tilde(C))  arrow.long^(tau_2) CF4(tilde(A),tilde(X)) +  h nu  $
  lo que se modelaría con un producto tal que:

   $ (tau_2)/(n dot f dot K_("scint") + tau_2 ) $

  Siendo la nueva expresión final: 

  $ P_(gamma,"uv" CF4) =  (tau_2)/(n dot f dot K_("scint") + tau_2 )  dot  (n dot f dot K_("kool"))/(n dot f dot K_("kool") + tau_1 )  dot P_(gamma,"uv" CF4)^("old") $

- Finalmente, la emisión del  $Ar_("3rd")$ ultravioleta también persiste. Ya hemos visto como esta está controlada regulada por $tau_("3rd")$, y que compite con los procesos @Eq:competencia1 y @Eq:competencia2.  Así pues: 

  $ P_(gamma,"uv",Ar_"3rd") = (1-f) dot P_(Ar_("3rd")) dot (tau_("3rd"))/(n f dot (K_(Ar_("3rd") arrow Ar) + K_(Ar_("3rd") arrow CF4^(+,*))) + tau_("3rd") )   $

  
Por tanto la mejora que hemos hecho se hace sustancialmente en la parte de la emisión del ultravioleta del $CF4$, en particular añadiendo el comportamiento de la presión en dichos picos a 100% $CF4$. Nuestro modelo microscópico podría resumirse en la @Fig:Modelo.   


Una vez tenemos el modelo de centelleo, dado que esto es un modelo fenomenológico, habría que coger datos experimentales y ajustar a los valores. Evidentemente hay parámetros que están relacionados, como puede ser $K_("cool")$ y $tau_1$, que podría expresarse como $K_("cool") slash tau_1$. Otros por ejemplo, han sido obtenidos en otros experimentos, tales como $tau_("3rd")$. que vale 5 ns #cite(<Santorelli2021>). Sin embargo, está claro que hay una gran cantidad de parámetros a ajustar, ya que no solo tendríamos que obtener los ratios $K$ y las vidas medias $tau$, sino las probabilidades $P$ (como $P_(Ar_("3rd"))$ o $P_(Ar^**)$). 

Eso es lo que hace precisamente #cite(<CF4WaveLenghtShifter>), ajustando algunos a partir de las concentraciones a 100% de #CF4 y Ar (como puede ser $P_(Ar_("3rd"))$ o $P_(gamma,CF4^(+,*),"dir")$), y otros con los valores de las mezclas los otros parámetros. Aunque nuestro modelo sea más refinado, cabe destacar que no podría ser ejecutado con el procedimiento mencionado, ya que estaríamos sumando 2 parámetros nuevos. 

La manera de hacerlo, aunque ya se ha dicho en los objetivos, será usar un software especializado, Degrad y Garfield++ (Magboltz) junto con los resultados experimentales. Estos softwares, especializados en la simulación de experimentos en física de partículas, con el que, grosso modo, conseguiremos reducir los parámetros relacionados con la probabilidad de formación. Además de la capacidad de "verificar" la calidad del modelo (y enfrentar la versión anterior con la nueva), tendremos un modelo capaz de predecir el centelleo en las simulaciones que se hagan en #ArCF4 con dicho software, incluso con otras estructuras, tal y como vamos a ver. 

#figure(
  image("Imagenes/Modelo.png"),
  caption: [Modelo de interacciones de la mezcla #ArCF4 del #cite(<CF4WaveLenghtShifter>). Nótese que faltan las interacciones que hemos incluido nosotros.]
) <Fig:Modelo>

= Resultados y análisis


//Las secciones eficaces son, en la descripción de la interacción entre partículas, las piezas angulares. Una sección contiene toda la información requerida. Si está en su forma diferencial, podremos onocer la distribución angular tras la dispersión. Si está en su forma integrada, contiene la probabilidad de colisión cuando estamos ante un flujo de partículas. 

//Sin embargo dentro de la interacción de dos partículas, podemos tener varias secciones eficaces. Por ejemplo, en la física nuclear podemos tener una colisión elástica entre núcleos, pero también podemos tener colisiones inelásticas, y dentro de estas, podemos tener decenas de ellas (fusión, intercambio de protones, de neutrones, de $alpha$...). Pese a todo, es indudable decir que si conocemos todas las secciones eficaces de la interacción entre dos partículas conocemos toda la información acerca de la interacción. 



A partir de las simulaciones de la @Sec:simulaciones, podemos conocer exactamente el número de iones, excitaciones, estados vibracionales... que se producen. Es decir, podemos saber _exactamente que estados aparecen bajo la interacción de una partícula con el medio_. Por tanto, al tener la capacidad de simular un proceso exactamente igual que el experimental con el que podemos saber el número de procesos que ocurrieron (por ejemplo, podemos saber cuantas ionizaciones hubo del #CF4), podremos realizar relacionar el número y tipos de estados obtenidos y las probabilidades de la ecuaciones de centelleo, para luego hacer un ajuste entre las medidas experimentales del centelleo y las probabilidades obtenidas y sacar los parámetros desconocidos. 


== Relación entre las poblaciones y las probabilidades  <Subsec:poblacion-probabilidad>

Aquí describiremos como podremos relacionar la información que podemos obtener con Degrad y las probabilidades que tenemos en el modelo fenomenológico. La mejor manera de proceder es desarrollar cada uno de los términos individualmente. 

En el caso de la emisión visible del #CF4, por ejemplo, esta formada por la probabilidad de que el $CF3^(*)$ emita directamente. Con Degrad nosotros podemos saber cuantos estados del tipo $CF3$ hemos obtenido, es decir, tras el paso de la partícula cuantos #CF3 se han producido, que denotaremos por $N_(CF3)$. En particular son los llamados _neutral diss pole_ (véase más sobre esto en #cite(<CF4_Christophorou>)). No sabemos exactamente que excitaciones del $#CF3$ se han producido, por lo que estamos perdiendo información. Pese a esto, la probabilidad de emisión directa y el número de estados producidos $N_(CF3)$  están relacionados linealmente: $P_(gamma,CF3,"dir") prop N_(CF3)$. Ahora bien, podemos incluir un parámetro $f_(CF3^*,(2A_2 '))$, que sea "fracción de estados $CF3(2 A_2 ')$ se han producido de todos los generados por Degrad". Así, la relación 

$  f dot  P_(gamma,CF3,"dir") arrow.long f_(CF3^*,(2A_2 ')) dot N_(CF3) $
se cumple. Hay que tener en cuenta que las poblaciones $N$ ya incluyen una dependencia con la concentración (véase @Subsec:poblaciones_degrad y @Fig:poblaciones). Por otro lado, también tenemos que considerar el centelleo producido por el $Ar^(**)$. Aquí ocurre algo parecido. Degrad proporciona información sobre 44 estados excitados del Argón, pero no sabemos exactamente cual es el $Ar^(**)$. Sin embargo sabemos que existe una relación directa entre la probabilidad de que se produzca nuestro estado $P_(Ar^(**))$ y la cantidad de estados excitados que se producen  $N_(Ar^(*))$ tal que $P_(Ar^(**)) prop N_(Ar^(*))$. Añadiendo dos términos que constanten la relación tal que

$ (1-f) dot P_(Ar^(**)) arrow.long ( N_(Ar^(**))) (f_(Ar^(**)) p_(CF3^* (2"A"_1')) )  $

donde $f_(Ar^(**))$  será la "fracción de eventos de Degrad que corresponden a la excitación del Argón que interviene". 

En el caso la emisión ultravioleta del #CF4 tenemos el $P_(CF4^(+,*))$. Esta probabilidad podemos relacionarla con los eventos que producen iones y dobles iones de $CF4$, que denotamos por $N_(CF3^+)$ y $N_(CF3^(++))$. Sí además añadimos una fracción de estados $f_(CF4^+)$ que constante la fracción de eventos que realmente tiene que ver con las excitaciones deseadas, tenemos que: 

$ f dot  P_(CF4^(+,*)) arrow.long f dot (N_(CF3^+) + N_(CF3^(++))) f_(CF4^(+,*)) $
Mientras que por otro lado tenemos $P_(Ar_("3rd"))$. Como ya hemos mencionado, el tercer continuo está relacionado con los aquellos $Ar$ que tengan  $Ar^(++)$ y $Ar^(+++)$ (basado en @Eq:competencia3), tal que 


$ (1-f) dot P_(Ar_("3rd")) arrow.long f dot (N_(Ar^(++)) + N_(Ar^(+++)))) $
donde hemos asumido que todos los eventos que generan $N_(Ar^(++))$ están relacionados  con las $Ar_("3rd")$ y con esto podremos realizar el modelo completo. Así pues tenemos que la cantidad de fotones producidos $Y$ se puede relacionar con los _eventos_ obtenidos con Degrad de la siguiente forma (reestructurando algunos parámetros, y cambiando $p arrow P$): 

#text(size: 11pt)[$ Y_(Ar_("3rd"),"uv") =  N_(Ar^(++))((1/tau_("3rd"))/(1/tau_("3rd") +n f (K_(Ar^(++),"Q"(CF4)))))  \ 

Y_(#CF3,"vis") =  N_(CF3) dot (f_(CF3^* (2"A"_2'))) + N_(Ar^(**)) (f_(Ar^(**)) P_(CF3^* (2"A"_1')) ) dot (1/(1+(1-f)/f (K_(Ar^(**),"Q"(Ar)))/(K_(Ar^(**),"Q"(CF4)))))  \  

Y_(#CF4,"uv") =   (N_(CF3^+) + N_(CF3^(++))) dot f_(CF4^+) + (N_(Ar^(++))+N_(Ar^(+++))) ((n f K_(Ar^(++),"Q"(CF4)))/(1/tau_("3rd") +n f (K_(Ar^(++),"Q"(CF4))))) ((n f)/(n f + tau_1/(K_("cool"))) 1/(1+K_("scint")/tau_2 n f)) $]

Una vez hemos llegado a esto, el siguiente paso es casi trivial. Teniendo medidas experimentales de la cantidad de fotones por evento, y teniendo los datos de Degrad, podemos realizar un ajuste y obtener los parámetros. De este modo, por ejemplo, podremos obtener el parámetro $f_(Ar^(**)) P_(CF3^* (2"A"_1'))$ que nos dará un valor mínimo de $f_(Ar^(**))$, que al final nos permitirá dilucidar cual es el % mínimo de estados excitados que pertenecen a  $Ar^(**)$, algo que hasta ahora no se ha hecho, y que esperamos poder incluir en la conclusión del trabajo.

== Poblaciones de Degrad <Subsec:poblaciones_degrad>

La obtención de las poblaciones de Degrad/Garfield++ requiere simulaciones para una determinada concentración (no varían con la presión). Dado que no podemos realizar simulaciones infinitas, tendremos que conformarnos con realizar las simulaciones en las concentraciones donde están exclusivamente los datos experimentales. Para obtener aquellas concentraciones que están entre dos puntos, haremos una interpolación lineal. En la @Fig:poblaciones vemos claramente la interpolación y la dependencia con la concentración de las poblaciones.


#figure(image("Imagenes/Poblaciones.pdf",width: 80%),
  caption: [Poblaciones de Degrad obtenidas. Nótese la interpolación y dependencia con la concentración.]
) <Fig:poblaciones>



== Resultados experimentales y ajuste del nuevo modelo

Los resultados experimentales que tenemos nos dan la cantidad de fotones por ultravioletas y la cantidad de fotones visibles (sin distinguir los 230,260, y 290 nm de cada emisión), además de darnos unos valores normalizados por lo que si queremos ajustar tendremos que añadir un parámetro $N_("norm")$ nuevo delante de los 3 posibles _yields_, además de sumar $Y_("uv") =Y_(Ar_("3rd"),"uv") +Y_(CF4,"uv")$. Por otro lado, la cámara solo es capaz de recoger el 48.66% de la emisión ultravioleta producida por el $Ar_("3rd")$, ya que como se ha dicho tiene un ancho muy grande y parte de la emisión se pierde. Así pues, el nuevo modelo constará de: 

#text(size: 11pt)[$ Y_(Ar_("3rd"),"uv") =  0.4866 dot N_("norm") [ N_(Ar^(++))((1/tau_("3rd"))/(1/tau_("3rd") +n f (K_(Ar^(++),"Q"(CF4)))))]  \ 

Y_(#CF3,"vis") = N_("norm") [ N_(CF3) dot (f_(CF3^* (2"A"_2'))) + N_(Ar^(**)) (f_(Ar^(**)) P_(CF3^* (2"A"_1')) ) dot (1/(1+(1-f)/f (K_(Ar^(**),"Q"(Ar)))/(K_(Ar^(**),"Q"(CF4)))))] \  

Y_(#CF4,"uv") = N_("norm") [ (N_(CF3^+) + N_(CF3^(++))) dot f_(CF4^+) + (N_(Ar^(++))+N_(Ar^(+++))) ((n f K_(Ar^(++),"Q"(CF4)))/(1/tau_("3rd") +n f (K_(Ar^(++),"Q"(CF4)))))] [(n f)/(n f + tau_1/(K_("cool"))) 1/(1+K_("scint")/tau_2 n f)] $ <Eq:nuevo_modelo>] 


Los resultados experimentales constan de 6 presiones y 12 concentraciones (excepto para 2, 3 y 5 bar, que tenemos 11 concentraciones al no haber medidas a 100% #CF4 y para 2.5 bar que solo tenemos medidas a 100% #CF4). Esto nos deja 74 valores experimentales. Y así, llegamos a los siguientes ajustes, de 9 parámetros libres, que se pueden ver en las figuras @Fig:uv_fit y @Fig:vis_fit. Los ajustes nos dan un $chi^2_("red")  = 0.51$. Los parámetros obtenidos los representamos en la @tab-scint-global-params. Como podemos ver los errores relativos no son extremadamente grandes, siendo el más grande el que da un 55%. 

#pagebreak()

#v(-1em)

#columns(2)[
#figure(image("Imagenes/Ajuste_UV_GlobalNorm.pdf",width: 120%),
  caption: [Ajuste de _yield_ uv. normalizado.]
) <Fig:vis_fit> #colbreak()
#figure(image("Imagenes/Ajuste_VIS_GlobalNorm.pdf",width: 120%),
  caption: [Ajuste de _yield_ visible normalizado.]
) <Fig:uv_fit>

]
#v(-0.1em)
#figure(
 table(
    columns: (auto,auto,auto,auto),
    inset: 7pt,
    
    stroke: (_, y) => (
      x: 0pt,
      top: if y <= 1 { 0.8pt } else { 0pt },
      bottom: 0.8pt,
    ),

    align: (x, y) => (
      if x > 0 { center }
      else { left }
    ),

    table.header(
      [*Parámetro*],
      [*Valor*],
      [*Error (%)*],
      [*Error (abs.)*],
    ),

    [$N_("norm")$],
    [$num("7.637e-3")$],
    [$num("4.531")$],
    [$num("3.460e-4")$],

    [$f_(#CF3^* (2A_1'))$],
    [$0.09625$],
    [$6.383$],
    [$num("6.144e-3")$],

    [$f_(Ar^(**))\, P_(CF3^*(2A_1'))$],
    [$0.2056$],
    [$5.493$],
    [$0.01129$],

    [$K_(Ar^(**),Q(Ar)) slash K_(Ar^(**),Q(CF4))$],
    [$0.03753$],
    [$5.572$],
    [$num("2.091e-3")$],

    [$tau_1 slash K_("cool")$],
    [$0.02596$],
    [$29.73$],
    [$num("7.716e-3")$],

    [$K_("scint") slash tau_2$],
    [$0.07010$],
    [$40.71$],
    [$0.03015$],

    [$f_(CF4^+)$],
    [$0.2905$],
    [$6.396$],
    [$0.01858$],

    [$K_(Ar^(++),Q(CF4))$ [$"ns"^(-1)$]],
    [$6.238$],
    [$55.32$],
    [$3.451$],

    [$P_(CF4^(+,*) (C,D))$],
    [$0.6706$],
    [$12.95$],
    [$0.08683$], 
  ),
  caption: [Resultados del ajuste, @Fig:uv_fit y @Fig:vis_fit.],
) <tab-scint-global-params>


== Análisis de los resultados <Subsec:analisis_resultados>

Como podemos ver, en la tabla @tab-scint-global-params hemos puesto todos los resultados de los parámetros. Una vez obtenidos estos, podemos hacer una interpretación de los resultados y conclusiones más relevantes. 

En la @Subsec:poblacion-probabilidad, hemos mencionado que el parámetro $f_(Ar^(**))$ nos daría información acerca del % de los estados excitados del #Ar que participan en la interacción a dos cuerpos 

$ Ar^(**) + CF4 arrow.long^(K_(Ar^(**) arrow CF3^*)) Ar + CF3^* $
Dado que Degrad contiene información acerca de 40 excitaciones del #Ar, cada una con un número de eventos, sabiendo el % podemos extraer diferentes conclusiones: ¿Son acaso los $f_(Ar^(**))$%  excitaciones más energéticas los que participan en la reacción?¿O las menos energéticas? Sin embargo, no podemos obtener una conclusión sobre el valor de $f_(Ar^(**))$, ya que el parámetro que realmente obtenemos en el ajuste es $f_(Ar^(**))\, P_(CF3^*(2A_1'))$. Lo que si podemos decir es que al ser ambos parámetros probabilidades y fracción tenemos que $f_(Ar^(**)) in [0,1]$ y  $ P_(CF3^*(2A_1')) in [0,1]$. Es decir, podemos obtener un _valor mínimo de la fracción de estados de $f_(Ar^(**))$_, aunque implica asumir que $P_(CF3^*(2A_1'))=1$ (i.e. que todos los estados producidos por dicha interacción acaban en el estado deseado). 

Podemos decir entonces que la cota mínima de % estados $Ar^(**)$ que interaccionan con el #CF4 según nuestro ajuste es el 20.56%. Si asumiéramos que esto es así, y que solo las excitaciones más energéticas del $Ar$ son las que participan, tendríamos que las excitaciones con 14.304 eV o más serían los que interaccionan con el #CF4. El resultado coincide con la concepción de que el _threshold_ de #CF3 está en 12.5 eV (energía de su estado fundamental). Un fotón de 630 nm lleva una energía de 1.97 eV, lo que implicaría que el estado de $CF3^*(2A_2 '', 1E')$. Exactamente, el valor que más se aproxima es el $Ar^*(14.304 "eV")$, con un 21.86% de estados si sumamos los eventos del mismo y aquellos más energéticos, tal que: 

$ (sum_(E >= 14.304) N_(Ar^* (E)))/ (N_(Ar^(**)))  =  21.86% $

Esta estimación es consistente con el rango energético de las excitaciones altas del #CF4 identificadas como relevantes. 

Otras conclusiones relevantes que podemos hacer es que los valores del ajuste $ tau_1 slash K_("cool") = 0.02596 quad quad K_("scint") slash tau_2 = 0.07010 $ 
parecen mostrar que las interacciones de _autoquenching_ y otras de dos cuerpos ocurren, al menos según nuestros resultados. 

Por ejemplo, el resultado

$ K_(Ar^(**),Q(Ar)) slash K_(Ar^(**),Q(CF4)) = 0.03753 $ 
nos dice que la interacción del $Ar^(**)$ con el #CF4 es 37.5 veces más probable que la interacción con otro argón. Esto es un resulado que ya se ve en #cite(<CF4WaveLenghtShifter>), en el que dan un resultado de $36.5 plus.minus 7.9$, compatible con el nuestro. 

= Comparación con modelos anteriores
== Resultados y ajuste del anterior modelo

Podemos hacer un ajuste con el modelo más reciente #cite(<CF4WaveLenghtShifter>), para comprobar la diferencia entre ambos. En las @Fig:vis_fit_pablo   y @Fig:uv_fit_pablo podemos comprobar como el modelo sigue funcionando pero sin describir el comportamiento de la presión en el ultravioleta tal y como habíamos dicho. Con un $chi^2_("red")=0.67$ de valor, podemos ver que el nuevo modelo también es capaz de describir los datos aunque un poco peor que el anterior. Este recordamos que sigue teniendo 7 parámetros libres. 

#v(-1em)

#columns(2)[
#figure(image("Imagenes/Ajuste_UV_GlobalNorm_pablo.pdf",width: 120%),
  caption: [Ajuste de _yield_ uv. normalizado.]
) <Fig:vis_fit_pablo> #colbreak()
#figure(image("Imagenes/Ajuste_VIS_GlobalNorm_pablo.pdf",width: 120%),
  caption: [Ajuste de _yield_ visible normalizado.]
) <Fig:uv_fit_pablo>
]

== Comparación entre ambos modelos 

Recordamos que el $chi^2_("red")$ del nuevo modelo tiene 0.51 y del anterior 0.67. Pese a que hallá una diferencia de los $chi^2_("red")$, ambos modelos si que describen correctamente los datos (y ambos revelan un sobreestimamiento de las incertidumbres experimentales). En cualquier caso, la diferencia más notable sigue estando en la capacidad de describir mejor el comportamiento de la presión, como se puede observar en la diferencia de las imágenes @Fig:uv_fit y @Fig:uv_fit_pablo. La diferencia clave se puede ver en la figura @Fig:comparacion_fits es la capacidad describir un poco mejor la tendencia de que a altas presiones el _yield_ ultravioleta disminuye, así como el comportamiento a bajas presiones y baja concentración. Sin embargo, la descripción de los datos por parte de ambos modelos es similar. 


#figure(image("Imagenes/n1bar_comparacion.pdf",width: 110%),
  caption: [Comparación de los modelos @Eq:nuevo_modelo y @CF4WaveLenghtShifter.]
) <Fig:comparacion_fits>


= Predicción del centelleo secundario

Evidentemente en número de ionizaciones y excitaciones producidas para la simulación de GEMs frente a la simulación de ionización primaria. No solo que son partículas diferentes las que producen, si no que la energía de las partículas es completamente diferente. Mientras que el centelleo primario viene producido por un rayo X de 14 keV, el centelleo secundario viene producido por electrones en avalancha cuya energía máxima son 50 eV (y la media 25 eV). De este modo, evidentemente las distribuciones de eventos no serán similares. Así nos aseguramos por un lado estudiar el centelleo secundario en otras condiciones. 

Tal y como mencionamos en @Subsec:analisis_resultados, nuestros resultados muestran que al menos los estados con 14.304 eV o más del $Ar^*$ son los que interaccionan con el #CF4. Claro que esto no implica que estados excitados del Argón con menos energía que 14.304 eV no participen, solo que implicará que $ P_(CF3^*(2A_1')) < 1$. Recordamos que lo que da nuestro ajuste es el producto $f_(Ar^(**))\, P_(CF3^*(2A_1')) = 20.56%$. Así pues, hacemos el estudio de los fotones por electrón en el secundario. En la  @Fig:secundario vemos como nuestras predicciones no se alejan demasiado del resultado experimental, ya que cada punto experimental tiene un 20% de incertidumbre, al menos en orden de magnitud. Cabe destacar que las simulaciones se han hecho suponiendo el _campo uniforme_, lo que es una aproximación bastante ruda respecto el campo real de un GEM. Mejores simulaciones deberían hacerse en pos de aproximarse al campo del experiemnto.

Para la selección del valor del #CF4 que interviene 


#figure(image("Imagenes/Secundario.pdf",width: 70%),
  caption: [Centelleo del secundario experimental más predicciones según nuestro modelo.]
) <Fig:secundario>


= Conclusiones

En este trabajo hemos realizado un exhaustivo estudio sobre el centelleo en mezclas #ArCF4, partiendo del centelleo individual de #Ar y #CF4, apoyado por resultados experimentales, hasta llegar a un modelo microscópico-fenomenológico que es capaz de describir el centelleo para cualquier concentración y presión completo, mejorando los previamente existentes. Para esto hemos combinado resultados experimentales y simulaciones de Degrad/Garfield++ con el fin de ver la capacidad de descripción de nuestro modelo. Además hemos realizado  una comparación con los modelos más refinados previos. 

Las conclusiones que podemos obtener es: 
- En la emisión del visible, los resultados sugieren que existe un dominio de la interacción $Ar^(**) - CF3$. La emisión directa es residual y menos potente, alcanzando el máximo de luminosidad en el visible en la mezcla a concentraciones 80%-90% $Ar$ y 20%-10% $CF4$. Esto muestra como el $#CF4$ es un _wavelenght shifter_ resultado en la línea de #cite(<CF4WaveLenghtShifter>).

- Respecto la emisión ultravioleta, lo resultados indican que la inclusión de mecanismos adicionales de _autoquenching_ e interacciones a dos cuerpos son fenómenos relevantes para la descripción del comportamiento de la presión del ultravioleta. 

- El ajuste aporta una cota mínima de la cantidad del % eventos de los estados excitados que contribuyen a la transición $Ar^(**) - CF4$ al $CF3 (2A_2 '', 1E ')$ que sería del 20.56%, lo que implicaría que al menos los estados $Ar^(*)$ con 14.307 eV o más participan en la reacción . Esto coincidiría con los argumentos energéticos sobre que el estado que participe tendría que tener 14.47 eV. 

- Las mismas predicciones en el caso del centelleo secundario parecen demostrar que la cota mínima debería estar entorno a los 14 eV para el $Ar^(*)$, según nuestro modelo. En cualquier caso coinciden en el orden de magnitud. También hay que tener en cuenta que las simulaciones realizadas en el secundario son en campo uniforme. Existe una posibilidad de margen de mejora si incluyéramos campos eléctricos mas realistas. 

En cualquier caso, el trabajo arroja una perspectiva positiva, ya que los resultados son estadísticamente aceptables. En un futuro se espera hacer medidas espectrales más finas para discriminar canales individuales, poder separar las componentes de las longitudes de onda y conocer sin normalización los _yields_ evitando incluir un factor de normalización. 

En conjunto, este trabajo contribuye a una compresión más detallada del centelleo en mezclas #ArCF4, combinando de forma coherente modelos microscópicos, simulación Monte-Carlo y datos experimentales. El modelo propuesto no solo mejora la descripción ya existente, sino que proporciona una herramienta para el diseño y optimización de detectores gaseosos ópticos de nueva generación. 




#bibliography("sample.bib",
style: "apa",)

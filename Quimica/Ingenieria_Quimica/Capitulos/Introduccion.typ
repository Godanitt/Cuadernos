#import "../../../plantilla.typ": *

== Origen y concepto de la industria química

La industria química es la industria que se ocupa de trasformar mediante procesos químicos y físicos meterias primas en otros productos de mayor interés, valor añadido y utilidad. Las transformaciones suelen implicar cambios de composición y/o contenido energético. Tras estas transformaciones podemos obtener varios tipos de productos denominados como *producto, subproducto y residuo*.

- Producto: producto objetivo del proceso, de alto valor o interés.
-Subproducto: producto secundario de una reacción química, generalmente no deseado, por su menor interés o por la complicación que puede ocasionar en el proceso.
- Residuo: subproducto o material residual de un proceso, sin valor o interés, que ademas puede representar un riesgo para el medio ambiente, para su eliminación tendrán que ser tratados para reducir su impacto a la hora de eliminarlos.
- Coproducto: subproducto con interés comercial, para vender a otra industria química o de alto valor.


También podemos distinguir distintos tipos de materias primas. Por un lado pueden ser provenientes de la naturaleza llamadas naturales o pueden ser provinientes de un proceso anterior de una industria química llamadas materias primas intermedias (productos intermedios).

== Esquema general de la industria química

Un proceso industrial se basa en la obtención de un producto químico (o varios) con determinadas especificaciones. Podemos ver en la Figura @fig:industria un esquema simplificado de lo que implica un proceso químico en la industria.

#figure(
  image("../Imagenes/Introduccion/Imagen-01.jpeg", width: 75%),
  caption: [Esquema de la industria química.],
) <fig:industria>


Dentro de la industría química encontramos diferentes subgrupos de los que se indican los más importantes:

- Química Básica
- Petroquímica
- Fertilizantes
- Solventes
- Plásticos 

En esta industría los productos se obtienen en grandes cantidades y estos tienen gran interes comercial. El proceso químico consiste en una serie de transformaciones químicas y/o físicas interconectadas dando lugar al producto de interes. El proceso químico se puede subdividir en e tres etapas principales: 

+ Preparación de los reactantes
+ Transformación o reacción química
+ Separación de los productos



== Las operacíones unitarias

Una operación unitaria o básica es cada una de las operaciones individuales con una función especifica diferencida que, coordinadas, permiten llevar a cabo un proceso químico. Sus principales caracteristicas son:


- Fundamentos, desarrollos y técnicas comunes en cada una de ellas independientemente de industria o proceso.
- Cada operación tiene una función especifica.
- Modifican las condiciones de la materia en forma más útil:
    - Su masa o composición:
        - Separación de fases.
        - Mezcla
        - Reacción química
    - El nivel o calidad de energía que posee:
        - Enfriamiento
        - Vaporización
    - Condiciones de movimiento: aumentando o disminuyendo su velocidad, dirección...
    


Teneniendo en cuenta que hay tres leyes por las que se rigen estos procesos:
- Ley de conservación de la materia.
- Ley de conservación de la energía.
- Ley de conservación de la cantidad de movimientos.


== Operaciones continuas y discontinuas

Según el modo en el que corrientes de alimento y producto enetren y salgan del equipo a lo largo del tiempo, pueden distinguirse tres tipos de operaciones básicas:
- Continuas
- Discontinuas
- Semicontinuas

=== Opeaciones continuas 

Operacion que transcurre continuament, sin etapas de carga y de descarga, por lo que las corrientes entran y salen permanentemente del equipo en el que se produce la transformación. Suelen transcurrir en régimen estacionario, es decir, el tiempo no influye sobre valores de las variables intensivas características del proteso (P,T, etc). El comportamineto del sistema es el mismo en cualquier instante lo que se conoce como *régimen estacionario promedio*.

=== Discontinuas

Operación que consta de una fase inicial (carga), una fase de transformación y una fase final (descarga), que transcurra en régiman no estacionario. También se denomina operación por cargas o intermitente. El tiempo influye y de manera decisiva. El tiempo será una variable clave para determinar el tamaño de los equipos que operan en discontinuo. El régimen de operación es no estacionario. Las variables modifican sus valores desde un valor inicial hasta uno final.

=== Semicontinuas

Operación en la que unos componenetes siguen el proceso de una operación discontinua (carga, tranformación y descarga) mientras que otros entran y salen en una corriente permanente durante la transformación, como en una operación continua. Son operaciones características intermedias. Operan en régimen no eztacionario, puesto que los valores de la variables evolucionan a lo alrgo del tiempo.\\


La productividad normalmente es mayor en las operaciones continuas, por lo que en los procesos industriales es más económicamente rentable operar en continuo. Estas tienen ventajas en la escala de operacón, eficiencia energética y automatización con repecto a las discontinuas. También presentan desventajas como la falta d eversatilidad y requerimientos de uniformidad de las materias primas.

== Régimen estacionario y régimen no estacionario

=== Régimen estacionario

Régimen de funcionamiento en el que las variables no dependen del tiempo, manteniéndose los valores constantes durante el proceso. Es característico de las operaciones continuas a escala industrial. En este régimen se cumple que en cada punto las condiciones no varías a lo largo del tiempo y que las condiciones no tienen porque ser iguales en todos los puntos.\\

#v(1em)

#align(center)[
#diagram(
  spacing: (18mm, 0mm),
  node-stroke: 1.2pt,

  node((0, 0), name: <entrada>,    fill: rgb("9adcf5"))[
    Entrada
  ],
  edge(<entrada>, <funcionando>, "-|>"),

  node((1, 0), name: <funcionando>,  fill: rgb("9df59a"))[
    FUNCIONANDO
  ],
  edge(<funcionando>, <salida>, "-|>"),

  node((2, 0), name: <salida>,  fill: rgb("ffc58a"))[
    Salida
  ],
)
]



=== Régimen no estacionario

Régimen de funcionamiento en el que las variables dependen del tiempo, modificando sus valores durante el transcurso del proceso. Es característico de las operaciones discontinuas. En este régimen se cumple que las condiciones varían a lo largo del tiempo, las variables modifican su valor desde el inicial hatsa el final y las condiciones no tienen por qué ser iguales en todos los puntos. Este tipo de régimen, por ejemplo, se produce:

- Llenando o vaciando de un recipiente (tanques).
- Arranques y paradas de un proceso continuo.
- Desviaciones transitorias de un proceso continuo.
- Procesos _batch_ o semicontinuos.

#align(center)[
#diagram(
  spacing: (0mm, 6mm),
  node-stroke: 1.2pt,

  node((0, 0), name: <carga>, shape: parallelogram, fill: rgb("9adcf5"))[
    Llenado de carga
  ],
  edge(<carga>, <parada1>, "-|>"),

  node((0, 1), name: <parada1>, shape: ellipse, fill: rgb("9df59a"))[
    Parada
  ],
  edge(<parada1>, <funcionando>, "-|>"),

  node((0, 2), name: <funcionando>, shape: parallelogram, fill: rgb("ffc58a"))[
    FUNCIONANDO
  ],
  edge(<funcionando>, <parada2>, "-|>"),

  node((0, 3), name: <parada2>, shape: diamond, fill: rgb("b6ffb6"))[
    Parada
  ],
  edge(<parada2>, <descarga>, "-|>"),

  node((0, 4), name: <descarga>, shape: parallelogram, fill: rgb("fff2a6"))[
    Vaciado/Descarga
  ],
)
]

== Modos de contacto entre fases

EL contacto entre dos fases inmiscibles se puede clasificar en dos tipos:

- Contacto continuo: el contacto entre las fases inmiscibles en el que estan en contacto permanente sin interrupción, por lo que no llegan a separarse en el interior del equipo utilizado. En operaciones de transferencia de materia se lleva a cabo, por ejemplo, en columnas de relleno.
- Contacto discontinuo (intermitente o por etapas): modo de contacto entre las fases inmiscibles en el que éstas se separan y se vuelven a mezlar en etapas de contacto sucesivas, a lo largo del equipo utilizado. En las operaciones de transferencia de materia se lleva a cabo, por ejemplo, en columnas de platos, con flujo en contracorriente.


Cuando las corrientes se mueven en la misma dirección y sentido, se denomina *flujo en paralelo o contacto en corriente directa*, y en el transporte máximo de propiedad que puede producirse está limitado por las condiciones de equilibrio termodinámico entre las fases a su salida del equipo. Las corrientes entran juntas por un extremo del equipo y salen juntas, por el extremo contraeio. Es poco frecuene por su menos eficacia.

Si las corrientes se desplazan en la misma dirección, pero en sentidos opuestos, será posible alcanzar mayores transportes de propiedad extensiva y superar por tamto el límite anterior, independientemente de si el contacto es continuo o intermitente. La entrada de una corriente y la salida de la otra corriente se encuentran en el mismo extremo del equipo. Es muy frecuente, por su mayor eficacia respecto a otro tipos de flujos.

Se conoce como *flujo cruzado* cuando las corrientes se mueven en direcciones diferentes, perpendicularmente entre si. El transporte está limitado por las condiciones de equilibrio entre las diferentes corrientes de salida, pero en cada zona del equipo. Suele ser una alternativa al flujo en contracorriente, cuando una de las fases es gaseosa.


== Clasificación de las operaciones unitarias

Las operaciones unitarias se clasifican en dos tipos:

- Químicas: provocan rescciones químicas $arrow$ Reactores químicos.
- Físicas: provocan un cambio en las características físicas:
    - Materia ($Delta$ Concentración): transferencia de materia entre fases o a través de una barrera. Se produce un cambio en la masa o composición. Por ejemplo en separación de fases y/o componente o mezcla de corrientes.
    - Energía ($Delta$ Temperatura): transferencia de energía calorífica entre fluidos o entre sólido y fluido. Cambio en la cantidad, calidad: enfriamiento, vaporación o cambio de presión.
    - Cantidad de movimiento ($Delta$ Velocidad):transferencia de calidad de movimiento a fluidos y material particulado. Velocidad, dirección: Conducciones, fluidación.


=== Clasificación de operaciones básicas físicas

==== Gas-líquido y líquido-vapor

En este tipo de operaciones encontramos la *absorción* que consiste en cuando se ponen en contacto una fase gaseosa y una fase líquida que contiene un soluto volátil y soluble cuya concentración en ambas fases no se corresponde con la del equilibrio, se produce su transporte desde la fase gaseosa a la líquida o de la líquida a la sólida (desorción), hasta llegar al equilibrio. Un buen absorbente se caracteriza por ser un buen disolvente del soluto, poco volátil, barato, no corrosivo, estable, con baja viscosidad, no espumante y no inflamable. 

==== Líquido-Líquido

Este tipo de operación se conoce como extración. Se trata de una operación de separación por transferencia de materia en las que se ponen en contacto mezclas líquidas inmiscibles con objeto de transferir uno o varios componentes (soluto) de una fase a otra. 

Normalmente se añade un disolvente selectivo a la mezcla líquida original cuyos componentes se deseean separa. El disolvente es inmiscible con ella, y actua como agente extractor. Las corrientes líquidas obtenidas se denominan refinado (mezcla de la que han extraido los solutos) y extracto (mezcla de disolvente y solutos).

==== Sólido-Líquido

Es análoga a la extracción líquido-líquido. Se denomina lixiviación y consiste en la separación de uno o varios solutos contenidos en una fase sólida mediante su contacto con un disolvente liquido selectivo. Permite separar los productos deseados del conjunto de la estructura sólida original.  

==== Sólido-gas

Se denomina adsorción y consiste en que uno o más componentes de una mezcla, gaseosa o líquida, se adsorben preferentemente sobre la superficie de un sólido, separándose así del resto de componentes. Los componentes (adsorbatos) se incorporan solamente a la suoerficie de la fase receptora (sólido adsorbente) denominada fase adsorbida. Es un fenomeno de superficie, y una de las propiedades más valoradas es la superficie específica de los adsorbentes comerciales (slímins, sílice, carbón activado, zeolitas).

==== Gas-líquido

Se conoce como destilación y consiste en la separación de una mezcla líquida por evaporación parcial y condensación. Se pueden separar componentes con diferente volatilidad (tendencia de una sustancia a pasar a la fase vapor).


Existen otro tipo de operaciones como aislamiento térmico, intercambio de calor, impulsión de fluidos, flujo de fluidos, transporte de sólidos, tritiración y molienda, tamizado, almacenamiento y operaciones de menbrana (ósmosis, pervaporación).


==== Líquido-Líquido

Este tipo de operación se conoce como extración. Se trata de una operación de separación por transferencia de materia en las que se ponen en contacto mezclas líquidas inmiscibles con objeto de transferir uno o varios componentes (soluto) de una fase a otra. 

Normalmente se añade un disolvente selectivo a la mezcla líquida original cuyos componentes se deseean separa. El disolvente es inmiscible con ella, y actua como agente extractor. LAs corrientes líquidas obtenidas se denominan refinado (mezcla de la que han extraido los solutos) y extracto (mezcla de disolvente y solutos).

==== Sólido-Líquido

Es análoga a la extracción líquido-líquido. Se denomina lixiviación y consiste en la separación de uno o varios solutos contenidos en una fase sólida mediante su contacto con un disolvente liquido selectivo. Permite separar los productos deseados del conjunto de la estructura sólida original.  

==== Sólido-gas


Se denomina adsorción y consiste en que uno o más componentes de una mezcla, gaseosa o líquida, se adsorben preferentemente sobre la superficie de un sólido, separándose así del resto de componentes. Los componentes (adsorbatos) se incorporan solamente a la suoerficie de la fase receptora (sólido adsorbente) denominada fase adsorbida. Es un fenomeno de superficie, y una de las propiedades más valoradas es la superficie específica de los adsorbentes comerciales (slímins, sílice, carbón activado, zeolitas).

==== Gas-líquido

Se conoce como destilación y consiste en la separación de una mezcla líquida por evaporación parcial y condensación. Se pueden separar componentes con diferente volatilidad (tendencia de una sustancia a pasar a la fase vapor).


Existen otro tipo de operaciones como aislamiento térmico, intercambio de calor, impulsión de fluidos, flujo de fluidos, transporte de sólidos, tritiración y molienda, tamizado, almacenamiento y operaciones de menbrana (ósmosis, pervaporación).

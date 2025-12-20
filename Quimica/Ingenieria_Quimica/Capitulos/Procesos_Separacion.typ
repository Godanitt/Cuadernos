
== Introducción

=== Conceptos Básicos

Existen dos tipos de mezclas: *mezcla heterogénea* y *mezcla homogénea*. Para separar una mezcla heterogénea se utilizan operaciones de separación mecánicas (filtración, decantación, centrifugación, sedimentación... ). En cambio, para separar mezclas homogéneas se utilizan operaciones de separación por transferencia de materia a nivel molecular. (Destilación, evaporación, extracción, absorción, intercambio iónico...).

#v(1em)

Una extracción por transferencia de materia es la extracción *sólido-líquido* en la cual los componentes de la fase sólida pueden separarse por disolución selectiva de la parte soluble (soluto) contenida en el sólido en un disolvente adecuado (solvente). También recibe el nombre de *lixiviación*. 

#v(1em)

Las operaciones básicas de transferencia de materia tienen como objetivo separar componentes de una mezcla monofásica en dos o más corrientes/productos de diferente composición. Un contacto adecuado que puede ser continuo o intermitente. En función de como sea el contacto, el método de estudio y diseño del equipo de separación es diferente. En el *contacto continuo* se integra del flujo de materia en toda el equipo (columna de relleno). En el *contacto discontinuo* se hace la separación por etapa.

#v(1em)


En estas operaciones básicas de transferencia de materia, su actuación se produce sobre una *columna de alimento* formada por una mezcla de compuestos en una fase única, con el objetivo de separar _dos o más corrientes de diferente composición_. Para ello es necesario  la presencia de una segunda fase inmiscible con el alimento que actúe como receptora de alguno de los compuestos que desean separar. En algunos casos esta segunda fase _se genera a partir de la inicial_, por evaporación o condensación, al cambiar las condiciones de presión o temperatura (destilación, recirculación, evaporación). En otros casos la segunda fase _aparece por adición}_ sin proceder de la mezcla original, es decir, añadiendo un disolvente adecuado (extracción, absorción).

#figure(
  caption: "Clasificación de operaciones básicas físicas.",
  table(
    columns: 4,
    stroke: 1pt,

    table.header[
      *Fases*
    ][
      *Transf. materia*
    ][
      *transf. materia y transf. calor*
    ][
      *Trans. calor*
    ],

    [G-L], [Destilación o absorción], [Humidificación], [Evaporación],
    [L-L], [Extracción L-L],          [],               [],
    [L-S], [Extracción S-L, filtración, adsorción], [cristalización], [],
    [G-S], [Adsorción],               [Secado, Liofilización], [],
  ),
) <tab-placeholder>


== Relaciones de equilibrio

 La destilación es una operación de separación en donde, mediante vaporización y condensación de una mezcla, se pueden separar componentes en función de su volatilidad. En mezclas binarias la destilación es una de las operaciones básicas más importantes. El objetivo de del diseño de las columnas de destilación es conseguir un producto de calidad requerida a un coste mínimo y producir dicho producto con un grado de pureza constante, aunque se produzca alguna variación en la composición de la mezcla de partida.

#v(1em)

 Los *diagramas de equilibrio* se representan las composiciones del líquido frente a las de vapor en equilibrio a presión total constante.

#v(1em)

 Si una *mezcla binaria* se encuentra en el interior de un recipiente cerrado a una *presión constante P* y esa mezcla se encuentra a una *temperatura* $T_o$ y tiene una fracción molar  $x_A$ _del componente más volátil_, estará representada en un diagrama de equilibrio por un punto A (ver figura @fig:diagrameq.

#figure(
  image("../Imagenes/ProcesosSeparacion/07.png", width: 75%),
  caption: "Diagrama de equilibrio líquido-vapor.",
  
)<fig:diagrameq>


 Si un vapor y un líquido de un componente puro están en equilibrio se denomina *presión de vapor*, la presión de vapor de una sustancia aumenta exponencialmente con la temperatura. A una temperatura dada, solo hay una presión en la que las fases L y V de una sustancia están en equilibrio. La *temperatura de ebullición* es la temperatura a la que hierve una sustancia, denominamos _temperatura de ebullición "normal"_ cuando la presión es $1$ $"atm"$.

#v(1em)

 Cuando se trata de disoluciones ideales, se pueden determinar los datos para la construcción de los diagramas de equilibrio a partir de las tensiones/presiones de vapor de los componentes puros según la *ley de Raoult*. 


#v(1em)

 
 La presión de vapor parcial de cada componente de una mezcla ideal de líquidos es igual al producto de la fracción molar de dicho componente en la mezcla líquida (disolución) por la presión de vapor del componente puro a la misma temperatura.

$ p_A=x_A dot P_A $

La *ley de Dalton*  o *ley de las presiones parciales* ($p=p_A+p_B$), la presión $p$ necesaria para que la mezcla hierva será:

$ P=x_A dot P_A+(1-x_A) dot P_B $

 Como la _la fracción molar en la fase de vapor_ es la relación entre la presión parcial y la presión total, tenemos:

$ 
     y_A=p_A/P quad  quad
     y_B=p_B/P $

 Se denomina *volatilidad absoluta* de un componente en una mezcla a la relación entre su presión parcial de vapor y su concentración de la fase líquida, es decir:

- Volatilidad de A: $alpha_A=p_A/x_A$
- Volatilidad de B:$alpha_B=p_B/x_B$


Al cociente de las volatilidades del componente más volátil (A) y el menos volátil (B) se denomina *volatilidad relativa* (de A respecto a B) $alpha_(A B)$.

$ 
alpha_(A B) = (p_A \/x_A)/(p_B \/x_B) = (P_A)/(P_B) = (y_A dot.op x_B)/(y_B dot.op x_A) $

 El valor de volatilidad relativa nos indica como vamos a poder separar ambos componentes:

- $alpha_(A B)>>1 arrow (y_A)/(y_B)>>(x_A)/(x_B)$ por lo que puede ser separado por destilación.
- $alpha_(A B) approx 1$ La separación es difícil.
- $alpha_(A B)=1$ la separación imposible por  destilación simple (azeotropo).



== Destilación 

La destilación es una operación básica con la que se puede separar mezclas líquidas homogéneas. El proceso aprovecha las diferentes volatilidades de los componentes de la mezcla a separar. Se conoce como volatilidad a la tendencia de una sustancia a pasar de fase líquida a la gaseosa. Ejemplos de líquidos muy volátiles son la acetona, el alcohol y la gasolina.

#v(1em)

 
 La *destilación simple* consiste en la _destilación parcial_ de una mezcla con _producción de vapor más rico en componentes más volátiles_ que la mezcla inicial, quedando un residuo líquido más rico en componentes menos volátiles.


#v(1em)

 La *rectificación* es una operación (una forma de destilación) que consiste el hacer circular a contracorriente el vapor de una mezcla con el condensado procedente del mismo vapor, en un equipo denominado columna de rectificación. Las partes esenciales de una columna de rectificación son: la _columna_ en sí, que es en donde se verifica el contacto íntimo ente el líquido y el vapor; el _calderín_, situado en la base de la columna en donde se hace hervir la mezcla a separar; y el _condensador de reflujo_ situado en la cúspide de la columna, que se encarga de suministrar el líquido descendente para su contacto.

#v(1em)
 
#figure(
  image("../Imagenes/ProcesosSeparacion/08.jpg", width: 75%),
  caption: "Columna de destilación y sus partes.",
  
)<fig:p>
 
 También debemos conocer el concepto de platos de borboteo. Estos retienen el líquido a través del cual se ve obligado a pasar el vapor.\\

#figure(
  image("../Imagenes/ProcesosSeparacion/09.png", width: 50%),
  caption: "Platos de una columna de destilación.",
  
)<fig:platos>


Los *cuerpos de relleno* llenan el interior de la columna, verificándose el contacto entre fases sobre la superficie de estos cuerpos de relleno.
#v(1em)

#v(1em)

El vapor, a medida que asciende, se enriquece en el componente más volátil. El líquido, a medida que desciende, aumenta su concentración en el componente menos volátil. El punto de ebullición disminuye de abajo hacia arriba. Parte del vapor (V) que llega al condensador sale de la columna como destilado (D) y otra parte retorna a la columna como reflujo (L). En una columna de platos sobre los platos existe un equilibrio, por eso se denominan platos de equilibrio consiguiendo así los enriquecimientos mencionados. Podemos la relación de reflujo ($R$) como:
 
 $ R = L/D $

 Parte del líquido que llega al calderín ($dash(L)$) sale. de la columna como producto de colas o residuo ($B$) y otra parte se devuelve al vapor recirculado ($dash(V)$). Cuanto mayor es el vapor que se devuelve a la columna, más puro sale el residuo en el componente pesado menos volátil, pero se necesita mucha más energía.

 $ R B = dash(V)/B  $

 Vamos a plantear los balances a las columnas. Balamence de materbashia global:

$ F = D + B $

 Balance de materia de componente:
 
 $  
F dot.op x_F = D dot.op x_D + B dot.op x_B $

Y el balance de energía, teniendo en cuenta que el calderín (reboiler) consume energía y en el condensador se libera energñia ($C$) :

$ 
F dot.op h_F -(D dot.op h_D + B dot.op h_B) + Q_R - Q_C = 0
$

De tal modo que:
$ 
F dot.op h_F + Q_R = D dot.op h_D + B dot.op h_B + Q_C $

Balance al condensador:
- Global de materia: $V=L+D$
- Global de componente: $V dot y_1=(L+D)x_D arrow y_1=x_D$
- Balance de energía: $V dot h_V=(L+D)h_D+Q_C$
- Relación de reflujo $R=L/D$.

- Global de materia: $L = overline(V) + B$
- Global de componente: $dash(L) x_N = dash(V) y_B + B x_ arrow dash(L) = L + F arrow dash(V) = V$
- Balance de energía: $dash(L) h_N + Q_R = dash(V) h_(B, "vapor") + B h_(B, "Liq")$


=== Balance al calderín:

El *método Shortcut* es un método aproximado para el diseño de columnas de destilación, es la combinación de tres métodos: _fernske, Underwood y Gilliland_. Permite determinar el número de etapas mínimas requeridas para la operación, el reflujo mínimo y de operación y el plato de alimentación.

#v(1em)

En cada una de las etapas hay equilibrio entre el líquido vapor. Si se aumenta el númera de etapas, se mejora la separación pero se aumenta el coste de construcción de la columna. Es fundamental determinar el número de etapas para conseguir la sepración deseada, esto se obtiene con la ecuación de *ecuación de Fenske*.

$ 
    N_(min) = (log [ ((x_A)/(x_B))_("dest") ] - log [((x_A)/(x_B))_("res") ])/(log alpha_(A B))  $

Donde $N_(min)$ indica la cantidad de contactos de equilibrio, incluyendo al vaporizador parcial neceario a reflujo total. En un sistema binario (AB) $x_B=1-x_A$ siendo $x_A=x$ la fracción molar del componente más volátil. Siendo la $alpha_{A B}$ la volatilidad relativa promedio $alpha_{A B}=sqrt(alpha_("dest") dot alpha_("res"))$

$ 
    N_(min) = (log [ ((x)/(1-x))_("dest") ] - log [((x)/(1-x))_("res") ])/(log alpha_(A B))  $
    

$N_(min)$ es el número mínimo de etapas en el equilibrio, equivalente a una producción nula de Destilado y Residuo. El número real puede ser estimado como una aproximación por criterios económicos.

$    N=2 dot N_(min) $

Aumentar la relación de reflujo $R=L/D$ conlleva mejorar la separación de la mezcla, aumento de los flujos en el interior de la columna, columna de mayor diámetro y mayor intercambio energético tanto en el calderín como en el condensador. La *ecuación de Underwood* permite calcular la relación mínima de reflujo necesaria. Para una mezcla binaria:

$ 
L_(m i n) = (F [(D x_D)/(F x_F) - alpha_F (D(1 - x_D))/(F(1 - x_F))])/(alpha_F - 1) $

Donde $L_(min)$ es el caudal mínimo de reflujo y $alpha_F$ es la volatilidad relativa promedio medida en las condiciones de alimentación.

#v(1em)

Para el *reflujo mínimo* implicaría un número infinito de etapas de equilibrio. El reflujo real requiere de una corrección empírica considerando costes de operación y de construcción}.

$ R = 1,3 dot R_(min) quad quad L = 1,3 dot L_(min) $



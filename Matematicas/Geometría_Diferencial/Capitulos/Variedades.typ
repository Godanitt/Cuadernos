#import "../../../plantilla.typ": *

== Topología 

Conceptos como _continuidad_, _diferenciabilidad_, son parte de una de las ramas más importantes de las matemáticas, el análisis, y sin embargo son esenciamente geometricos, y requieren el uso de *topología* para una _definición rigurosa_. La topología es la estrucutra que se impone en un conjunto de elementos/objetos que nos permiten desarrollar los términos de _convergencia_ y _límite_. Un espacio con una topología definida podrá ser llamado *espacio topológico*, y un _mapa continuo_ entre esapcios topológicos es aquel que preserva los puntos límites de los subconjuntos. La mejor manera de aproximarse a esta materia es a través de los _conjuntos abiertos_. 

#v(1em)

Consideremos entonecs un espacio dos dimensional $S$ insertado en un espacio tres dimensional euclídeo $RR^3$. En este caso podemos entender intuitivamente lo que es una "deformación continua", siendo una aplicación de la superficie que no implica ningún desgarro. La topología básicamente maneja estas propiedades que son invariantes bajo _deformaciones continuas_. 

=== Topología Euclideana

Resúmase capítulo 10.1 de #cite(<Szekeres_2004>).

=== Espacios Topológicos Genéricos

#definition(name:"Topología")[
  Dado un conjunto $X$, una topología en $X$ consiste en una famlia de subconjuntos $Ocal$, llamados _conjuntos abiertos_ que siguen la siguientes condiciones:
  + El conjunto vacío $emptyset$ es abierto y el espacio $X$ es abierto ${emptyset,X} subset Ocal$.
  + Si $U$ y $V$ son conjuntos abiertos, entonces su intersección $U inter V$, $ U in Ocal " y " V in Ocal arrow.long.double U inter V in Ocal $
  + Si ${V_i | i in I}$ es una familia de conjuntos abiertos entonces su unión $union.big_(i in I) V_i$ es abierto. 
]

Curiosamente, la definición de "topología" inlcuye la definición de abierto. Un abierto es _cualquier conjunto de conjuntos_ que verifique dichas condiciones. Por ejemplo, una *bola abierta* en un espacio euclídeo $RR^n$ cumple esas condiciones, y por eso se llama abierto. Sin embargo no hace falta definir "distancias" (i.e. tener un espacio métrico) para definir un abierto, por eso decimos que _un espacio métrico es siempre topológico pero un espacio topológico no tiene que ser necesariamente métrico_. 

#v(1em)

Redactar Ejemplos 10.2 #cite(<Szekeres_2004>).

/*
#example()[
  Definimos $Ocal$ como la colección de subconjuntos de $U$ de $RR$ tal que para cada $x in U$ existe un intervalo abierto ($x - epsilon, x + epsilon) subset.eq  U$) para un $epsilon>0$. El conjunto vacío $emptyset$ y el $RR$ son trvialmente abiertos (cada punto de $x in RR$ cae en un abierto: $RR$). Sea entonces $U$ y $V$ dos conjutnos abiertos tales que $U inter V eq.not emptyset$.]
*/

#definition(name:"Espacio Topológico")[
  El par $(X,Ocal)$ donde $Ocal$ es una _topología_ en $X$ se llama espacio topológico. Muchas veces se dice que $X$ es el espacio topológico cuando $Ocal$ está entendido. Los elementos de $X$ se suelen llamar puntos.   
] 

Se dice que un conjunto $A$ es *vecindario* de $x in X$ si existe un conjunto abierto $U$ tal que $x in U subset A$. Decimos que un espacio topológico $X$ es *primer contable* para todo punto de $x in X$ tenemeos un una colección de vecestáindarios de $x$ abiertos $U_1(x),U_2(x)...$ tal que cada vecindario abierto de $x$ $U$ contenga a esta colección $U_n(x) subset U$.

#v(1em)

Sean $X$ e $Y$ espacios topológicos. Una función $f:X arrow Y$ entre espacios topológicas es *continua* si la imagen inversa $f^(-1)(U)$ de cada abierto $U$ en $Y$ es abierto en $X$. Si $f$ es 1 a 1 (biyectiva) y $f^(-1):Y arrow X$ es continua, entonces decimos qeu $f$ es un *homeomorfismo* y los espacios $X$ e $Y$ son *homeomórficos* (topológicamente equivalentes) y se denotan como $X tilde.equiv Y$. 

#v(1em)

El punto principal de la topología es encontrar *invariantes topológicos*, propiedades que se preservan en bajos homeomofismos. El objetivo último de la topología es estudiar los invariantes que caracterizan une esapacio topológico. 

=== Espacio Métrico

La idea de esapcio métrico viene a generalizar la idea de distancia, que está implícita en un epacio euclídeo. 

#definition(name:"Espacio Métrico")[
  Definimos como espacio métrico a un conjunto de elementos $M$ con una *función distancia* o *métrica* $d: M times M arrow RR$ tal que 
  + $d(x,y) gt.eq 0$ para todo $x,y in M$.
  + $d(x,y) =  0$ sí y solo sí $x=y$.
  + $d(x,y) = d(y,x)$.
  + $d(x,y) + d(y,z) gt.eq d(x,z)$.

]

Para cada punto $x$ en un espacio métrico ($M,d$) y un número real $a>0$, deifnimos una *bola abierta* $B_a(x) = {y|d(x,y)<a}$. 

#v(1em)

Acabar de redactar 10.3 #cite(<Szekeres_2004>)

=== Espacio de Hausdorff 

En algunas topologías, existen conjuntos abiertos cuyos puntos no pueden ser separados por vecindarios que no intersecan. Para remediar esto, se crean oos llamados axionmas de separación. Uno de los más usuale es la *condición de Haussdorff*. Esta nos dice que para cada par de puntos $x,y in X$ existen conjuntos abiertos $U$ de $x$ y $V$ de $y$ tales que $U inter V = emptyset$. Un espacio topológico que cumpla esta propiedad se llama *espacio de Hausdorff*. Una idea intuitiva de este tipo de espacios es esta: "no todos los pares de puntos de un espacio de Haussdorff están arbitrariamente cerca". 

#v(1em)

#theorem()[
  Cada espacio métrico $(X,d)$ es un espacio de Hausdorff. 
]


Redactar 10.5 #cite(<Szekeres_2004>)

=== Espacios Compactos




== Variedades Diferenciables

=== Introducción

Para muchos físicos y matemáticos el concepto de "mapa" dado por la topología no es suficiente. Y para un español más, ya que, las traducciones, no juegan a nuestro favor. Cuando hablamos de mapa hablamos de mapa hablamos de _relaciones entre espacios_, incluso espacios no euclídeos (como por ejemplo la superficie de una esfera). Los conceptos que nos permiten relacionar espacios no euclídeos (el caso paradigmático siempre será la superficie de la esfera, aunque también vale la superficie de una hipérbole, toroide...) con, de hecho, espacios "localmente euclidéanos" son lo que llamamos _variedades diferenciables_. La geometría diferencial es precisamente el área que estudia estas estrucutras, y sus aplicaicones son abundantes, la mayor es la Relatividad General. La geometría diferencial alcanza su expresión más bella en la Relatividad General, lo que con un poco de suerte alcanzaremos a ver.   

#v(1em)

Pensemos en la superficie de la Tierra. Dado que es una esfera, no es ni métricamente ni topológicamente un espacio euclídeo plano $RR^2$. Sin embargo hay formas de representar la tierra en uno o varios planos. Un atlas consistirá en diferentes planos o _cartas_, cada uno representando diferentes partes de la Tierra. Supongamos por ejemplo que tenemos un mapa de Francia. Es evidente que habrá regiones donde esta carta se concectará con otras cartas, aunque sean en pequeñas regioens (véase el norte de España comprenderá parte del sur de Francia, y la parte sur del mapa de Francia comprenderá una pequeña parte del Norte del España). La correspondencia entre estas regiones de las cartes, esta región superpuesta será continua y suave, y exisitirá una correspondencia 1 a 1. Algunas cartas incluso se podrán encontrar dentro de otras (véase una carta de España y una carta de Europa). 

#v(1em)

Los puntos de $RR^n$ serán denotados como $xn = (x^1,x^2,...,x^n)$. Una función $f:RR^n arrow R$ será de tipo $C^r$ si todas sus derivadas parciales existen: 


$ (partial^s f(x^1,x^2,...,x^n))/(partial x^(i_1) partial x^(i_2) ... partial x^(i_s)) $

existe y son continuas para $s=1,2,...,r$. Una función $C^0$ es aquella simplemente continuam nnuebtras que a $C^infinity$ será una *función diferenciable*. 

#definition(name: "Mapa")[
  Definimos un *mapa* como una función $phi:RR^n arrow RR^m$ que es un conjunto de funciones $phi_i: RR^n arrow RR$. Se dirá que es de tipo $C^r$ cuando todas sus $phi_ i$ son de tipo $C^r$. 
]

=== Variedades Diferenciales

#definition(name:"Variedad topológica")[
  Una variedad topológica es un espacio de Hausdorff $M$ en el que cada punto $x$ tiene un vecindario homeomórfico a un conjunto abierto $RR^n$. Como sabemos, todo espacio métrico (como $RR^n$) es de Hausdorff, por lo que para que $M$ sea localmente homeomórfico a $RR^n$ debe de ser de Hausdorff. 
]

#definition(name:"Carta de Coordenadas")[
  Sea $p$ un punto cualquiera de la variedad topológica $M$. Entonces la *carta de coordendas* en $p$ es el par $(U,phi)$ donde $U$ es un subconjunto abierto de $M$ llamado _dominio de la carta_  y $phi$ una función tal que $phi:U arrow phi (U) subset RR^n$ es un homeomorfismo entre $U$ y su imagen $phi (U)$. Por otro lado, $phi (U)$ es un subconjunto abierto de $RR^n$. 
]

En muchas ocoasiones se le llama a $U$ el *vecindario* y a $phi$ el *mapa*. Las funcioens $x^i = phi^i: U arrow R$ ($i=1,...,n$). En libros como el #cite(<Szekeres_2004>) usan lo que llamamos los _mapas de proyección_ $"pr"_i: RR^n arrow R$, que se usa como $x^i = phi^i = "pr"_i compose phi$ donde $compose$ implica composición $"pr"_i compose phi = "pr"_i (phi)$. 

#v(1em)

Para un par de coordenadas $(U,phi';x^i)$ y $(U',phi',x^(prime j))$ tal que $U inter U' eq.not emptyset$, se definen las *funciones de transición*:

$ phi' compose phi^(-1): phi (U inter U') arrow phi' (U inter U') $
$ phi  compose phi^(prime -1): phi'(U inter U') arrow phi (U inter U') $

Las funciones de transición muchas veces se denotan como


$ x'^j = x'^j (xn) quad quad x^j = x^j (xn') $ <eq:transicion>

que es la manera abreviada de escribirlo con los _mapas de proyección_. Decimos que las dos cartas son $C^r$-compatibles cuando las  @eq:transicion son de tipo $C^r$ (obviamente $r={ZZ^+,infinity}$). 


#definition(name:"Atlas")[
  Un atlas en $M$ es una familia de cartas $Acal = {(U_alpha,phi_alpha)|alpha in A}$ tal que los $U_alpha$ cubren completamente $M$, y todos los pares de cartas son $C^infinity$-compatibles. Si $Acal$ y $Acal'$ son dos atlas de $M$, la unión también es atlas de $M$. 
]

#definition(name:"Variedad Diferenciable")[
  Cualquier atlas $Acal$ puede exterderse a un _atlas maximal_ añadiendo todas las cartas $C^infinity$-compatibles con $Acal$. Un atlas maximal es llamada la _estructura diferenciable_ de $M$. Un par $(M,Acal)$, donde $M$ es una variedad topológica $n$-dimensional y $A$ es la estructura diferenciable de $M$, es llamado *variedad diferenciable* denotado como una variedad topológica: $M$.
]

Una matriz Jacobiana $J = [partial x^(prime k) \/ partial x^j]$ es no singular dado que su inversa existe tal que  $J J^(-1) = J^(-1) J = 1$. Por definición $det J eq.not 0$.

=== Ejemplos


== Mapas y curvas diferenciables 

== Espacio tangente, contangente y tensorial
=== Espacio tangente
=== Espacio cotangente y tensorial
=== Campos vectoriales y tensoriales
=== Cambios de coordenadas
=== Fibrados Tensoriales

== Mapa tangente y subvariedades 
=== Mapa tangente y pullback
=== Subvariedades

== Conmutadores, corrientes y derivadas de Lie
=== Conmutadores 
=== Derivada de Lie

== Distribución y Teorema de Frobenius
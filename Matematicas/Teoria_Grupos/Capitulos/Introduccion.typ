#import "../../../plantilla.typ": *

== Definición de Grupo 

#definition(name: "Grupo")[
  Un grupo es un conjunto de elementos ${g_1,g_2}$ dotados de una ley de composición (multiplicación) que a cada par ordenado $g_i,g_j in G$ le asigna otro elemento $g_i g_j$ de forma que se satisfacen las siguientes propiedades: 
  
  - *Cierre*: la ley de composición es interna, es decir, si $g_i,g_j in G$, entonces $g_i dot g_j in G$

  - *Asociatividad*: la ley de composición es interna, es decir, si: 
  
  $ g_i dot (g_j dot g_k) = (g_i dot g_j) g_k $

  - *Elemento Unidad*: existe un único elemento, denotado usualmente $e$, con la propiedad de que $forall g_i in G$: 
  
  $ e g_i = g_i e = g_i $

  - *Elemento Inverso*: para cada $g_i$ existe un único elemento $g_i^(-1)$ tal que 

  $ g_i^(-1) g_i = g_i g_i^(-1) = e $

]

En general la multiplicación no es _conmutativa_, tal que $g_i dot g_j eq.not g_j dot g_i$. Cuando es conmutativa, decimos que el grupo es *abeliano*. El número de elementos de $F$ se denomina _orden_ de $F$, y se designa como $cal(O) (G)$. Si el orden es finito, decimos que $G$ es un _grupo finito_. 

#v(1em)

Dado un grupo, podemos ampliar siempre a un álgebra. Un álgebra es un conjunto de elementos que forman un espacio vectorial sobre un cuerpo (como $RR$ o $CC$), de forma que, junto a la edición se define una operación de multiplicación que verifica los postulados que definen un grupo, excepto que el cero del álgebra no tiene inverso. Así por ejemplo, dado un grupo $G$ con elementos $g_i(i=1,...,h)$ las combinaciones lineales $sum_(i=1)^h c_i g_i$, de elementos del grupo con coeficientes en el cuerpo, forman el álgebra del grupo. El producto se define por distributividad como 

$ (sum_(i=1)^h c_i g_i) (sum_(j=1)^h c_j g_j)  = sum_(i=1)^h sum_(j=1)^h c_i c_j g_i g_j $

que por ser $g_i g_j$ un elemento del grupo, es un nuevo elemento del álgebra. 

=== Ejemplos 

Vamos a enucniar algunos ejemplos a título ilustrativo.

+ $Q_+$, El conjunto de todos los números reales estricatavemnte positivos con la ley de composición siendo la multiplicación ordinaria forma un grupo. Este grupo es abeliano y de orden infinito.
+ $S_n$. Permutaciones de $n$ objetos donde la multiplicación es la simple composición de permutaciones sucesivas. Es uno de los grupos más importantes, y es no abeliano.
+ $ G L (N,"R")$. El grupo lineal $G L (N,"R")$ tiene por elementos todas las matrices de orden $N times N$ con valores reales y deeterminante no nulo. Análogamente, se define el grupo $G L (N,"C")$ como el grupo de matrices complejas. 


== Clase de Conjugación

#definition(name: "Elementos Conjugados")[
  Dos elementos $g_1$ y $g_2$ de un grupo $G$ son conjugados si existe un tercer elemento tal que $g_2 = g g_1 g^(-1)$. Decimos entonces que $g$ es el elemento conjugante.
]

En los casos en que se definen los elementos de un grupo como transformaciones lineales sonbre un cierto espacio vectorial, la equialencia bajo conjugación surge de la ambigüedad que existe a la hora de escoger la base de dicho espacio vectorial. Precisaremos este comentario en el capítulo siguiente, con un ejemplo explícito en el grupo $S_n$.

#v(1em)

La relación de conjugación entre dos o más elementos es una relación de equivalencia $tilde$. Se verifican las siguietnes propiedades: 

+ Reflexiva: $a tilde a$, ya que $a = e a = a e$.
+ Simétrica: $a = g b g^(-1)  arrow.r.double b = g a g^(-1)$.
+ Transitiva: $a = g b g^(-1)$, $b = h c h^(-1)$, $arrow.r.double a = (g h) c (g h)^(-1)$

Dada una relación de equivalencia, la _clase de equivalencia_ (conjunto de elementos con relación de equivalencia) de un elemento $a$ escrita como $(a)$ se define como:

$ (a) = {b|b tilde a} $

de las propiedades de $tilde$ se sigue que la subdivisión de un conjunto en clases de equivalencia es una _partición en subconjuntos disjuntos_, ya que todo elemento pertenece a alguna calse de equivalencia por la propiedad reflexiva $a tilde a arrow.r.double (a) = {a}$. Además, si dos clases $(a)$ y $(b)$ tuvieran algún elemento en común $a tilde c$ y $b tilde c$, por transitividad se verifica que $a tilde b$ y por tanto $(a)=(b)$. Como sabemos, que la propiedad de conjugación es una relación de equivalencia, todo grupo $G$ admite una descomposición en _clases de conjugación_:

$ (g_i) = { g_i | g_j = g g_i g^(-1), "para algún" g in G} $

Lógicamente el número de claes de conjugación es menor que el orden del grupo. Sólo es un grupo abeliano, cada elemento es a la vez toda una clase de conjugación que $a = g b g^(-1) = g g^(-1) b = b$.


== Subgrupos

#definition(name: "Subgrupos")[
  Un subgrupo $H$ de un grupo $G$ es un subconjunto de $G$ que a su vez forma un grupo bajo la misma ley de composición de $G$.
]

Cuando $G$ es finito, una definición equivalente afirma que $H$ es un subgrupo de $G$ cuando es cerrado (el producto de dos elementos de $H$ generá otro elemento de $H$) bajo la ley de composición de $G$:

$ forall h_1, h_2 in H subset G arrow.r.double h_1 dot h_2 in H $
¿Por qué basta con que se verifique esto? Es obvio que la asociatividad es una propiedad heredada de $G$, y la existencia de identidad y de inverso en $H$ se heredan también. El elemento identidad $e$ debe pertenecer necesariamente a cualquier subgrupo. De hecho, en todo grupo $G$ hay dos ejemplos triviales, a saber, $H={e}$ y $H=G$. Cualquier subgrupo que no sea estos dos se llama *subgrupo propio*.

=== Coset

Dados un elemento $g in G$ y un subgrupo $H = {h_1,h_2,...}$, de un grupo $G$ el *coset* por la izquierda de $g$ se escribe como $g H$ y consiste en el conjunto de elementos obtenidos al multiplicar $g$ por todos los elementos de $H$:

$ g H equiv {g h_1,g h_2, ...} $
Análogamente se define el coset por la derecha. La pertenencia de dos elementos al mismo coset define una relación de equivalencia 

$ a tilde b "si" b in a H  $
y se verifican reflexividad, simetría y transitividad: 

+ Reflexiva: $a in a H$, ya que $a = a e$.
+ Simétrica: $b in a H  arrow.r.double b = a h  arrow.r.double a = b h^(-1)  arrow.r.double a in b H$.
+ Transitiva: $b in a H$, $c in a H$, $b = a h$, $c = a h'$ así que $c = b h^(-1) h' = b h''$, i.e. $c in b H$.

En consecuencia, los cosets son _clases de equivalencia_, lo que implica automáticamente que la división en costest es una partición disjunta de $G$. Si $G$ es un grupo finito, podemos enumerar los cosets _distintos_ de la forma $G / H = {g_1 H = e H, g_2 H, ..., g_s H}$.

#v(1em)

En un grupo finito $G$ de orden $cal(O)(G)$, cada coset $g H$ contiene el mismo número de elementos $r$ que conicide con el orden $cal(O)(H)$ del subgrupo $H$, lo que es evidente ya que $g  h_1 = g h_2$ implica necesariamente que $h_1 = h_2$. Como hemos visto que la relación que definen los cosets, produce una partición disjunta de $G$, los elementos de éste se agrupan en $s$ cosets, todos del mismo orden $cal(O)(H)$. Es decir, 

$ cal(O) (G) = s cal(O) (H) $
llegando al siguiente teorema: 

#theorem(name:"Teorema de Lagrange")[
  En un grupo finito $G$ el orden de cualquier subgrupo $H subset G$ es un divisor del orden de $G$.
]

=== Subgrupos Normales

#definition(name: "Subgrupo Normal")[
  Un subgrupo normal es un subgrupo $H$ que verifica 
  
  $g H g^(-1) = H quad forall g in G $ <eq:01.11> 
]

A los subgrupos también se les llama _auto-conjugados_. Una definición alternativa es decir que los subgrupos normales están compuestos de _clases de conjugación completas_, ya que $forall h in H arrow.r.double g h g^(-1) = h' in H$. También se puede decir que un subgrupo normal tiene la propiedad de que sus _cosests por la izquierda y derecha coinciden_:

$ g H = H g $

Cada elemento de un grupo abeliano es una clase de conjugación, lo que nos lleva a decir que todo grupo formado por ${e,h,h^(-1)}$ es un subgrupo normal de $G$ ($h in G$). 

#definition(name: "Grupo Simple")[
  Decimos que un grupo es simple si no posee ningún subgrupo normal propio. Si ungrupo no posee ningún subgrupo normal aveliano, decimos que es semisimple. Evidentemente todo grupo simple es semisimple. 
]

=== Grupo Cociente

Como sabemos, el _conjunto coset G/H_ define una partición disjunta de $G$ cuyos elementos (cosets) denotamos simbólicamente mediante un representatne $g_i H$.Una pregunta natural que podríamos hacernos es si $G/H$ es a su vez un grupo. Para ello debemos diseñar una operación interna que satisfaga los aiomas de grupo $(g_1 H)dot (g_2 H) = g_e H$. Si empezamos probando con la simple multiplicación definida en $G$ tal que $(g_1 H) dot  (g_2 H) = g_1 H g_2 H = g_3 H $ (lógiacamente cada vez que pongamos $H$ nos referimos a cualquier elemento $h in H$. En general esto no será cierto, salvo en el caso de que $H$ sea un subgrupo normal, ya que entonces por la propia definición de subgrupo normal @eq:01.11 se verifica que

$ (g_1 H) dot  (g_2 H) = g_1 H g_2 H = g_1 g_2 H H = g_3 H $

(aunque no parezca obvio $H H = H$ implica que el producto de _cualquier_ elemento de por otro elemento de $H$ lleva a un elemento de $H$, por definición). En consecuencia, podemos concluir que el conjunto de cosets ${g_i H}$ admite una estructura de grupo cuando $H$ es un subgrupo normal. Llamamos a este grupo _grupo cociente G/H_.

=== Producto Directo

#definition(name: "Producto Directo")[
  Decimos que un grupo $G$ es el producto directo de dos subgrupos $A$ y $B$, $G=A #sym.times.circle B$, cuando 
  + Todos los elementos de $A$ conmutan con todos los de $B$.
  + Todo elemento de $G$ admite una expresión única en forma de $g=a b$ donde $a in A$ y $b in B$. 
]
De esta definición se generaliza directamente el producto de $n$ subgrupos $G = A #otimes B #otimes ... #otimes J$.

- El único elemento que tienen en común $A$ y $B$ es el elemento neutro/identidad.
- El producto de dos elementos $g_1 = a_1 b_1$ y $g_2 = a_2 b_2$ implica:
  $ g_1 g_2 = (a_1 b_1)(a_2 b_2) = a_1 a_2 b_1 b_2  = (a_1 a_2)(b_1 b_2) $
  donde hemos aplicando la conutación $b a = a b$. 
- Los grupos $A$ y $B$ son subgrupos normales. Que sean subgrupos es trivial (ya que $a$/$b$ puede ser el elemento neutro). Que sean subgrupos normales, no es tan trivial, aunque se pueden ver de que al ser $g = a b$:
  $ g A g^(-1) = (a b) a_i (a b)^(-1) = a  b a_i a^(-1) b^(-1) = a a_i a^(-1) $ 
  y como $a a_i a^(-1) in A$, queda demostrado. 
- Los grupos cocientes $G/B$ y $G/A$ son isomorfos a $A$ y $B$ respectivamente. Esto es trivial si pensamos que $G/B = {g_i B quad forall g_i in G}$, que al ser $g=a b$, $G/B = {a_i B quad forall a_i in A}$. Evidentemente todos los cosets son distintos, ya que si suponemos que $a_1 b_1 = a_2 b_2$, entonces estaríamos violando la definición de _producto directo_. Entonces es evidente que existe una aplicación 1:1 entre $G/B$ y $A$, tal que $a_i B arrow.r.long.bar a_i$ es un _homomorfismo_, y esto se basa en la propiedad de subgrupo normal de $B$, que implica la ley de multiplicación $(a_1 B)(a_2 B) = a_1 a_2 N arrow.r.long.bar a_1 a_2$. 

Con frecuencia haremos también el producto directo de dos grupos $G #otimes G'$. Para obtenerlo basta con formar todas las parejas posibles de la forma ($g,g'$). Si $e$ y $e'$ son las identidades respectivas, $(e,e')$ es la identidad del producto directo. Vemos por tanto, qeu el orden del producto directo es el producto de los órdenes. El producto de pares se define mediante

$ (f,f')(g,g') = (f g,f'g') $
Los elementos $(g,e')$ forman un subgrupo $Gamma$ que es isomorfo a $G$, y lo mismo de $(e,g') in Gamma' tilde G$. Entonces el grupo de pares de elementos definido es el producto directo de $Gamma$ y $Gamma'$.

=== Centro de un grupo

#definition(name: "Centro")[
  El centro $Z$ de un grupo $G$ se define como el subconjunto de elementos $z$ que conmutan con todos los elementos del grupo 
  $ Z = {z in G  quad | z g = g z quad forall in G}$
]
Claramente $Z$ es un subgrupo abeliano; además la propiedad que define el centro implica que es un subgrupo normal, puesto que cada elemento $z in Z$ es una clase de conjugación completa $z = g z g(-1)$.
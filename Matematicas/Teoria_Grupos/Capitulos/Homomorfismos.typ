#import "../../../plantilla.typ": *

== Homomorfismos

Un homomorfismo es una aplicación $f$ de un conjunto $A$ en otro $B$ (escribimos $f: A arrow.r.long.bar B$) que preserva alguna estructura interna. En particular estamos interesados en la estructura de grupo de $A$ y $B$. 

#definition(name: "Homomorfismo")[
  sean $A$ y $B$ dos grupos y $f:A arrow.r B$  una aplicación. Decimos enton es que $f$ es un homomorfismo cuando verifica que para cualesquiera $a_1, a_2 in A$:
  
  $ f(a_1 a_2)= f(a_1) f(a_2) $ <ec:02.01>
]

Cuando $B$ coincide con $A$ decimos que $f$ es un *endomorfismo*. Recordemos la definición de imagen y kernel de una aplicación:

$ "Im" f := { b in B | b = f(a) "para algún" a in A } $
$ "Ker" f := { a in A | f(a) = e_B in B } $

Una aplicación es *inyecta* cuando $"Ker" f = e_A$. Si además $"Im" f = B$, $f$ es *suprayectiva*. Si es biyectiva y suprayectiva a la vez decimos que es la aplicaicón es *biyectiva* o 1:1.  Si además $f$ es un homomorfismo (@ec:02.01) es decimos que constituye un _isomorfismo_. Un _isomorfismo_ $f:A arrow.r.long.bar A$ de un grupo en sí mismo se llama _automorfismo_. 

== Representaciones

=== Generalidades

#definition(name:"Representación")[
  Una represetnación de dimensión $n$ de un grupo abstracto $G$ es un homomorfismo $D: G arrow G L(n,CC)$ el grupo de matrices $n times n$ invertibles con coeficientes complejos.
]

En otras palabras, se trata de una aplicación $g  arrow D(g)$  que preserva la estructura de grupo en el sentido de que 

$ D(g_1 g_2) = D(g_1) D(g_2) $
donde en el miembro derecho el producto indica la multiplicación matricial. En virtud de homomorfismo tenemos que $D(g^(-1))=(D(g))^(-1)$

Deceimos que una representación es _fiel_ si la aplicación es un homomorfismo inyectivo. Es decir, si cada elemento distinto $g$ le corresponde una matriz distinta $D(g)$. EN particular, este hecho impone que $"Ker"(D) = e in G$, de donde se deduce que el único elemento representado por la matriz unidad es el elemento identidad de grupo. 

#definition(name:"Equivalencia entre Representaciones")[
  Dos representaciones n-dimensionales $D^(1)$ y $D^(2)$ de un grupo $G$ son equivalentes si $forall g in G$ las matrices $D^1(g)$ y $D^2(g)$ son similares, esto es, están relacionadas por una conjugación en $G L (n,CC)$, lo que implica que existe una matriz $S$ independiente de $g$ tal que 

  $ D^1 (g) = S D^2 (g) S^(-1) $
]
De nuevo, esta  es una relación de equivalencia, por lo que estamos interesados en la clasificación de clases equivalentes. De forma implícita, a partir de ahora cuando hablemos de una representación, incluiremos todas sus equivalentes; es decir la consideraremos como una representación de la clase. 

#v(1em)

Todo grupo admite una representación trivial unidimensional  en la que todo elemento viene representado por el número 1, aunque no es fiel, por razones evidentes.

== Reducibilidad 

#definition(name:"Reducibilidad")[
  Decimos que una representación de dimensión $n+m$ es *reducible* si $D(g)$ admite la forma en bloques siguiente:
  $ D(g) = mat( A(g), C(g); 0, B(g)) forall g in  G $
  donde $A(g)$ y $B(g)$ son matrices cuadradas de dimensiones $n times n$ y $m times m$ respectivamente. 
]

Por tanto, automáticamente ${A(g)}$ y ${B(g)}$ constituyen representaciones de $G$ de $n$ y $m$ dimensiones. Además también funciona a la inversa, dadas dos representaciones $A$ y $B$ siempre podemos formar una mayor mediante la suma directa:

$ D(g) = mat(A(g),0;0,B(g)) $
que en este caso escribimos como $D=A oplus B$, siendo la dimensión de $D$ la suma de las dimensiones de $A$ y $B$. 

#definition(name:"Completamente Reducible")[
  Una representación que admite (algún representante con) la forma dimensional de bloques 
  $ D(g) = mat(A(g),0;0,B(g)) $
  se dice que es *completatmente reducible* y se denota como $D = A oplus B$.
]

#definition(name:"Completamente Irreducible")[
  Una representación que _no_ admite (algún representante con) la forma dimensional de bloques 
  $ D(g) = mat(A(g),C(g);0,B(g)) $
  y que no admite ninguna transformación de equivalencia se dice que es *completatmente irreducible*.
]

Las representaciones irreducibles de un grupo son las "piedras angulares" en el estudio de la teoría de represetnaciones de grupos, ya que una representación arbitraria siempre puede descomponerse en combinación lineal de representaciones irreducibles.



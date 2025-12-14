#import "../../../plantilla.typ": *


== Grupo Cíclico $C_n$

#definition(name:"Grupo Cíclico")[
  El *grupo cíclico $C_n$* es el grupo de transformaciones de simetría de un polígono regular con $n$ lados y direccionado. Por "direccionar" entendemos que el polígono lleva asociado un sentido de recorrido alrededor de su perímetro (equivalente a decir "en el sentido de las agujas del reloj"). Los elementos del grupo son rotaciones discretas del ángulo $2pi r / n$ con $r=0,1,...n-1$ alrededor de este eje de rotación, que atraversaría el "centro de gravedad" del polígono.
]



== Grupo Simétrico $S_n$

=== Definición y características

El grupo simétrico es uno de los grupos más interesantes. Desde el punto de vista de un físico, los grupos simétricos aparecen en sistemas qeu involucran conjuntos de partículas idénticas. Dentro del ámbito de la teoría de grupos es importante en virtud del teorema de Cayley. 

#definition(name:"Grupo Simétrico")[
  El *grupo simétrico* $S_n$ se define como las posibles permutaciones o sustituciones de $n$ elementos (o índices qeu los etiquetan), conteniendo por tanto $n!$ elementos, de lo que se deduce que el orden es $n!$. La _ley de composición_ es la aplicación sucesiva. De esto se deduce que el grupo es _no abeliano_ (no conmuta).
]

Existen dos represetnaciones análogas, a saber, la *forma canónica* y la *descomposición en ciclos*. La forma canónica básicamente implica que un _elemento genérico_ p se puede escribir como

$
p =
mat(
  1, 2, ..., n; 
  p(1), p(2), ..., p(n),
)
$

que nos dice que el índice $i$ es cambiado por el índice $p(i)$. Por ejemplo, 

$
mat(
  1, 2, 3;
  1, 2, 3,
)
$

nos dice que el elemento 1 corresponde con índice 1, el elemento 2 al índice 2 y el elemento 3 al índice 3. Sin embargo si nos fijamos en 

$
mat(
  1, 2, 3;
  1, 3, 2,
)
$
Vemos que lo que antes era el índice 2 ahora se denota por 3 y el elemento 3 se denota por 2, es decir, _el elemento de índice 2 y 3 se intercambian_. Esto se puede ver en la parte inferior. Así pues, la multiplicación es la aplicación sucesiva. 

Por ejemplo, el objeto resultante de la aplicación sucesiva de un primer objeto intercambia 2 y 3, y un segundo que intercambia 1 y 2, lo que ocurrirá es que en el objeto objeto resultante el elemento 1 tendrá índice 3, el elemento 2 índice 1 y el elemento 3 índice 2. Veamos que: 

$
mat(
  1, 2, 3;
  1, 3, 2,
)
mat(
  1, 2, 3;
  2, 1, 3,
) = 
mat(
  1, 2, 3;
  3, 1, 2,
)
$
Una vez se entienda lo que queremos decir el resto será un simple ejercicio abstracto sistemático más o menos complejo, pero sin misterios. Esta que hemos trabajado ahora es la _forma canónica_. 

#v(1em)

La *descompsición en ciclos* de los elementos nos dice que ($i j k l... z$) representa un elemento donde el elemento de índice $i$ se intercambia con el elemento de índice $j$, el $j$ con la del $k$... y así sucesivamente hasta que el último $z$ se intercambia por el primero $i$. Si un índice no se intercambia no aparece en la representación. Así obviamente el _elemento neutro_ (no intercambio) para cualquier grupo  es $()$. Veamos un ejemplo relacionando ambas notaciones:

$
  mat(
  1, 2, 3;
  1, 3, 2,
  ) = (23) quad quad 
mat(
  1, 2, 3;
  2, 1, 3,
) = (12) quad quad 
mat(
  1, 2, 3;
  3, 1, 2,
) = (123) 
$

#example()[
  Uno podría preguntarse cuales son los elementos del grupo $S_3$. Dado que $3!=6$, sabemos que tiene 6. Estos son: 

  $ S_3 = {(),(12),(23),(13),(123),(321)} $
  
  Es evidente que $(21)=(12)$, $(123)=(312)$... En ese sentido cada elemento tiene varias representaciones. 
]

A priori puede parecer que tiene más complicación la descomposición en ciclos, aunque es evidente que ocupan menos espacio. Veamos que: 

- Dos ciclos son el mismo si coinciden salvo permutación cíclica de sus elementos. 
- Cíclos de un elemento pueden ser omitidos.
- Ciclos disjuntos conmutan entre sí.
- Ciclos que tengan un sólo elemento en común se encadenan (1234)(43) = (12)

Independietemente de la forma que el lector considere más adecuadas, el punto más importante que queremos hacer aquí es que todo elemento $S_n$ puede escribirse en forma de un producto de ciclos disjuntos.

=== Teorema de Cayley

Ya hemos dicho que el grupo simétrico es uno de los más importantes, ¿por qué? Por el teorema de Cayley:

#theorem(name:"Teorema de Cayley")[
  El *teorema de Cayley* afirma que todo grupo $G$ finito de orden $n$ es isomofro a algún subgrupo de $S_n$. 
]
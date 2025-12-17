#import "../../../plantilla.typ": *

== Introducción

Un grupo finito de elementos se llama _grupo finito_. El número de elementos es el _orden_ del grupo. 

#v(1em)

La forma más inmediata de representar un grupo finito consiste en mostrar su tabla de multiplicación, también llamado _cuadrado latino_. Por ejemplo, el grupo cíclico $C_3$ es el conjunto de elementos ${e,b,c}$ dotados de la tabla de multiplicación: 

#align(center)[
#table(
  columns: 4,
  align: center,
  stroke: (x, y) => {
  (
    right: if x == 0 { 0.8pt } else { none },
    bottom: if y == 0 { 0.8pt } else { none },
  )
  },


  [],  "e", "b", "c",
  "e",  "e", "b", "c",
  "b",  "b", "c", "e",
  "c",  "c", "e", "b",
)
]
Aunque precisa, esta forma de caracterizar un grupo es engorrosa para grupos finitos de orden alto, por ser tan exhaustiva. Otra manera conmunmente utilizada para determinar un grupo finito consiste en especificar su _presentación_. Una presentación consiste en un conjunto de relaciones que indentifican elementos de $cal(F)_n$, el grupo libre de $n$ generadores. por ejemplo, un grupo libre abeliano es un grupo libre ordenado donde imponemos la identificación de elementos $x_i x_j = x_j x_i$ para cualquier $i,j$.

== Grupo Cíclico $C_n$

#definition(name:"Grupo Cíclico")[
  El *grupo cíclico $C_n$* es el grupo de transformaciones de simetría de un polígono regular con $n$ lados y direccionado. Por "direccionar" entendemos que el polígono lleva asociado un sentido de recorrido alrededor de su perímetro (equivalente a decir "en el sentido de las agujas del reloj"). Los elementos del grupo son rotaciones discretas del ángulo $2pi r / n$ con $r=0,1,...n-1$ alrededor de este eje de rotación, que atraversaría el "centro de gravedad" del polígono.
]

Llamando a estos elementos $c_n^r$ es evidente que podemos obtener este elemento a partir de una rotación elemental $c_n^1 = c$, es decir,

$ c_n^r = c^r $

En principio el grupo está generado por potencias arbitrariamente altas de esta operación elemental, $c$. Sin embargo, notemos que el grupo finito debido a que una rotación de ángulo $2 pi$ es equivalente a la identidad: 

$ c^n = e $

podemos por tanto definir matemáticamente el grupo cíclico de orden $n$ como el grupo de elementos _generados_ por $c$, consistente en elementos ${e,c,c^2, ..., c^{n-1}}$. 

#v(1em)

Obviamente se trata de un grupo Abeliano, ya que 

$ c^r c^s = c^(r+s) = c^s c^r $
de hecho es _isomorfo_ al grupo $ZZ_n$. La correspondencia es 1:1 tal que 

$ c^r in C_n #sym.arrow.l.r.long r in ZZ_n $ 
y esta correspondencia es un homomorfismo, lo que hace que preserve las opraciones respectivas de ambos conjuntos. Al tratarse de un grupo abeliano, cada elemento constituye su propia clase de conjugación. 

#example()[
  Vamos a representar el grupo $C_6$ como el producto directo de subgrupos. Fácilmente $C_6 = A otimes B$ implica que 
  $ A = {e,c^2,c^4} quad quad B = {e,c^3} $
]

== Grupo Dihédrico $D_n$

#definition(name:"Grupo Dihédrico")[
  El *grupo dihédrico $D_n$* es el grupo de transformaciones de simetría de un polígono regular con $n$ lados no direccionado. ]

Ahora, no solo tenemos "rotaciones", como el grupo cíclico. Este grupo contiene otras simetrías, como podrían ser las "simetrías espejo" (por ejemplo, por ejemplo cambiar el lado izquierdo y el derecho de un cuerpo humano, lo cual no se puede hacer con rotaciones). Para entenderlo estudiaremos el grupo $D_3$ y $D_4$

=== Grupo $D_3$

Este grupo contiene trivialmente los elementos ${e,c,c^2}$ del grupo cíclico. Además tendrá los elementos $x,y,z$, que serían las rotaciones de 180 grados en torno a los ejes $x,y,z$. Estas operaciones satisfacen $x^2=y^2=z^2=e$

Se puede entender el grupo $D_3$ como el _grupo de simetrías del triángulo_. Entonces 

$ D_3 = {e,c,c^2,x,y,z} $

Además como $y = c x$ y $z = c^2 x$, Entonces

$ D_3 = {e,c,c^2,x,x c,x c^2} $
Dado que $e=c^3$ o $e=x^2$, es obvio que todos los elementos de $D_3$ pueden ser construidos a partir de dos elementos $c$ y $x$. 

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

A priori puede parecer que tiene más complicación la descomposición en ciclos, aunque es evidente que ocupan menos espacio. Veamos que: 

- Dos ciclos son el mismo si coinciden salvo permutación cíclica de sus elementos. 
- Cíclos de un elemento pueden ser omitidos.
- Ciclos disjuntos conmutan entre sí.
- Ciclos que tengan un sólo elemento en común se encadenan (1234)(43) = (124)

Independietemente de la forma que el lector considere más adecuadas, el punto más importante que queremos hacer aquí es que todo elemento $S_n$ puede escribirse en forma de un producto de ciclos disjuntos.

#example()[
  Uno podría preguntarse cuales son los elementos del grupo $S_3$. Dado que $3!=6$, sabemos que tiene 6. Estos son: 

  $ S_3 = {(),(12),(23),(13),(123),(321)} $
  
  Es evidente que $(21)=(12)$, $(123)=(312)$... En ese sentido cada elemento tiene varias representaciones. 
]

=== Representación de $D_3$:

Vamos a hacer una representación de $D_3$ Obviamente ccogeremos la representación con los vectores

$ hne_1 = mat(1;0;0) quad hne_2 = mat(0;1;0) quad hne_3 = mat(0;0;1) $

Dado que todos los elementos del grupo $S_3 = {(),(123),(132),(12),(23),(13)}$ están compuestos por $(12)$ y $(123)$, basta con conocer las representaciones de $(12)$, $(123)$. Evidentemente en esta base 

$ D(()) = mat(1,0,0;0,1,0;0,0,1) = II $
y tenemos que 

$ D((12))^2 =  II quad quad D((123))^3 = II $
Podemos obviamente escribir $D((123))=D((12))=II$, obteniendo la representación trivial, o escribir $D((123)))=II$ y $D((12))=-II$. En general, podemos calcularlo suponiendo que $D((12)))$ y $D((123))$ son matrices $3 times 3$ generales y usar propiedades como la anteriores para deducir término a término. Sin embargo esto sería largo y tedioso. No es dificil ver que para llegar a la representación podemos aplicar conceptos "sencillos".

#v(1em)

Está claro que (12) representa la permutación del 1 con el 2, es decir que si $D((12))hne_1 = hne_2$, y que si $D((12)) hne_2 = hne_1$. La matriz que verifica esto es: 

$ D((12)) = mat(0,1,0;1,0,0;0,0,1)  $

Por otro lado, la matriz D(123) es aquella tal que $D((123))hne_i = hne_i+1$ (para $i=1,2,3$ y $i=4=1$). Así pues: 

$ D((123)) = mat(0,1,0;0,0,1;1,0,0)  $

Con estas dos podmeos encontrar la expresión de las demás, o seguir aplicando estos conceptos sencillos. En cualquier caso la descomposición natural:  

$ D((23)) = mat(1,0,0;0,0,1;0,1,0) quad 
  D((13)) = mat(0,0,1;0,1,0;1,0,0) quad 
  D((132)) = mat(0,0,1;1,0,0;0,1,0) $

=== Teorema de Cayley

Ya hemos dicho que el grupo simétrico es uno de los más importantes, ¿por qué? Por el teorema de Cayley:

#theorem(name:"Teorema de Cayley")[
  El *teorema de Cayley* afirma que todo grupo $G$ finito de orden $n$ es isomofro a algún subgrupo de $S_n$. 
]
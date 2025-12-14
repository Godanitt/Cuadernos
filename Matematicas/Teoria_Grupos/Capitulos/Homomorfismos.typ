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

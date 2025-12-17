#import "../../../plantilla.typ": *

== Ejercicios

//================================================
// EJERCICIO 1
//================================================
#exercise()[
  Sea $G$ un grupo y considérese el centralizador asociado a un elemento $g in G$. Demostrar que dicho centralizador es un subgrupo de $G$. 
]

Definimos un centralizador como aquel subonjunto de elementos de $G$ que conmuta con todos los elementos del grupo. Por otro lado, un subgrupo $H$ de un grupo $G$ es un subconjunto de $G$ que a su vez forma un grupo bajo la misma ley de composición $G$.  

#v(1em)

Sea $h_1,h_2 in H$, y $g in G$. Si $H$ es el centro, es obvio que se debe verificar $H = g H g^(-1)$ siendo $H$ en realidad cualquier elemento del conjunto $H$. Así pues, decir que $h in H$ es lo mismo que decir que $h in g H g^(-1)$. Veamos que $e = g e g^(-1)$, po lo que $e in g H g^(-1)$, lo que implia que contiene el elemento neutro. Otro aspecto que hay que demostrar es que $g H g^(-1)$ es cerrado. Véase que 

$ g h_1 g^(-1)  g h_2 g^(-1= = g h_1 h_2 g^(-1)$
por lo que un $h_1 h_2 = h_3 in H$.  Además 

$ g h_1 g^(-1)  g h_1^(-1) g^(-1) = g h_1 h_1^(-1) g^(-1) = g e g^(-1) $ 
por lo que se cumple que $h_1 h_1^(-1) = e$, y que además $h^(-1) in H$. La asociatividad se deduce de que $h in G$. Así pues, $H$ cumple los 4 requisitos para ser un grupo (cierre, asociatividad, elemento unidad y elemento inverso), y como $H subset G $, podemos decir que _H es un subgrupo de G_.


//================================================
// EJERCICIO 2
//================================================
// 
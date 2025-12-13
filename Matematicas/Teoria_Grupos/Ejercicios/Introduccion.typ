#import "../../../Plantilla_Cuaderno/plantilla.typ": *

== Ejercicios

//================================================
// EJERCICIO 1
//================================================
#exercise()[
  Sea $G$ un grupo y considérese el centralizador asociado a un elemento $g in G$. Demostrar qeu dicho centralizador es un subgrupo de $G$. 
]

/*
Sea $g in G$ y $h_1, h_2 in H$. Obsérvese que $e = g e g^{-1}$ y, por tanto,
$e in g H g^{-1}$. Obsérvese que $g H g^{-1}$ es cerrado, ya que

$ g h_1 g^{-1} \; g h_2 g^{-1} = g h_1 h_2 g^{-1} $

y $H$ es cerrado. Nótese que

$ g h_1 g^{-1} \; g h_1^{-1} g^{-1} = e $.

Por tanto, para todo $x in H$, se tiene que $x^{-1} in H$. Esto demuestra que
$g H g^{-1}$ es un subgrupo de $G$.
*/

//================================================
// EJERCICIO 2
//================================================
#exercise()[
  Demuéstrese que si $G=H_1 #otimes H_2$, entonces $G/H tilde.eq  H_2$ y que $G/H_2 tilde.eq H_1$ donde $tilde.eq$ significa isomorfo. 
] 
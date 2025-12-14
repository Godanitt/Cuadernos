#import "../../../plantilla.typ": *

== Introducción a grupos de Lie

En los grupos continuos los elementos pueden parametrizarse en un entorno pueden parametrizarse en un entorno de cualquier punto mediante un conjunto de variables reales. Escribimos entonces para un elemento genérico $g(x_1,x_2,...,x_d)=g(xn)$ Si $d$ es el número de mínimos parámetros necesarios para alcanzar  a cualqueir elemento, hablamos de un grupo de _dimensión_ $d$.


#v(1em)

Es evidente que no podemos escribir una tabla de multiplicar en el mismo sentido que para un grupo finito. Si el producto $g(xn)$ por ($g(yn)$) es $g(zn)$ tenemos qeu 

$ g(x_1,x_2,...,x_d)g(y_1,y_2,...,y_d) = g(z_1,z_2,...,z_d) $

entonces los parámetros $z_1,...,z_d$ son funciones de $x_i,y_i$. Es decir, la tabla de multiplicación consta de $n$ funciones reales de $2d$ argumentos, $z_i = f_i (xn,yn)$ tal que $i=1,...,d$.

#v(1em)

Las propiedades que definen un grupo imponen restricciones sobre las posibles funciones $f_i$. La más severa es la que proviene de la asociatividad: 

$(g(xn)g(yn))g(zn) = g(xn)(g(yn)g(zn)$

#definition(name:"Grupo de Lie")[
  Un *grupo de Lie* es un grupo continuo en el cual las funciones $f_i$ que expresan las multiplicaciones a parte de satisfacer los requisitos que provienen de las proviedades de grupo son $C^infinity$ (contínuas e infinitamente derivables)
]

== Represetnaciones de Grupos de Lie 

=== Grupos Unitarios 

=== Grupos Ortogonales 

== Estructura Local de los Grupos de Lie

=== Generadores Infinitesimales de un Grupo de Lie

=== Álgebras de Lie y Grupos de Lie


#definition(name:"Álgebra de Lie")[
  Un *álgebra de Lie* $cal(L)$ de dimensión $d gt.eq 1$ es un espacio vectorial real de dimensión $d$, dotado de una operación interna llamada *corchete de Lie* $[,]: Lcal times Lcal arrow Lcal$, definida para todo par $u,v in Lcal$ y que satisface las siguientes propiedades:
  - *Cierre*: $[u,v] in Lcal quad forall u,v in Lcal$
  - *Antisimetría*: $[u,v]=-[v,u]$
  - *Linealidad*: $[alpha u + beta v, w] = alpha [u,w] + beta [v,w]$ para $a,b in RR$
  - *Identidad de Jacobi* $[u,[v,w]] + [w,[u,v]] + [v,[w,u]] = 0$
]

El concepto álgebra de Lie es una definción abstracta qeu en cada caso requiere una definción para el concrete de Lie subyacente. Así pues, en la mecánica clásica tendríamos uno, al igual que en la mecánica cuántica, siendo ambos diferentes.

#v(1em)

Dada una base $L_1,..,L_d$, un álgebra de Lie viene especificada por un conjunto de $d^3$ números $f_(i j)^k$ denominados *constantes de estructura* que se definen según la siguiente expresión: 

$ [L_i,L_j] = sum_{k=1}^d f_{i j}^k L_k quad quad quad i,j = 1,...,d$

Estos números no son independientes como se deduce de las propiedades de _antisimetría e identidad de Jacobi_. 

#v(1em)

Frente a cambios de bae $L_i arrow tilde(L_i)$ con $i=1,...,d$ ... 


#theorem(name:"Tercer teorema de Lie")[
  A cada grupo de Lie lineal, $G$, le corresopnde un álgebra de Lie $Lcal$ de la misma dimensión. De forma maś precisa, si $Lcal$ tiene dimensión $d$, entonces los generadores infenitesimales $L_1,...,L_d$ forman una base de $Lcal$. 
]

== Representaciones de Grupos y Álgebras de Lie


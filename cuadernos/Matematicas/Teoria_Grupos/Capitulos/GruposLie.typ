#import "../../../../plantilla/plantilla.typ": *

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

// Ejercicios del capítulo
#pagebreak()
#import "../../../../plantilla/plantilla.typ": *


== Ejercicios

//==================================
// -- EJERCICIO 1 -----------------
//==================================

#exercise()[
  Realiza los siguientes apartados.
  + Demostrar la relación    $ mat(cos phi, sin phi; - sin phi, cos phi) = exp mat(0,phi;-phi,0) $
  + Comprobar que la matriz $3 times 3$    $ A_(i j) = delta_(i j) (e_0^2 - |e|^2) + 2 e_i e_j + 2 epsilon_(i j k) e_0 e_k  $ donde  $ e_0 = cos Phi/2 quad  quad en = un sin Phi/2 $ siendo $un$ un vector unitario, es ortogonal. 
]

El primer apartado es bastante sencillo. La función de una matriz $f(A)$ de tipo $C^infinity$, se puede expresar como (siendo $x=0$)

$ f(A) = sum_(n=0)^infinity  (A^n)/(n!)((partial f(x) )/(partial x))_(x_0)   $

Tal que, en el caso de la exponencial  

$ exp A = sum_(n=0)^infinity (A^n)/(n!) = sum_n (A^(2n))/((2n)!) + sum_n (A^(2n+1))/((2n+1)!) $ <eq:expA>

Luego, la matriz $A =  mat(0, phi; - phi, 0)$ cumple la siguiente propiedad: 

$ mat(0, phi; - phi, 0)  mat(0, phi; - phi, 0) = phi^2 mat(1,0;0,1) = phi^2 II $

es decir, se verifican las siguientes relaciones: 


$ A^(2n) = phi^(2n) mat(1,0;0,1) quad quad A^(2n+1) = phi^(2n+1) mat(0,1;-1,0) $

Si esto lo sustituimos en @eq:expA, tenemos que 

$ exp A = mat(1,0;0,1) sum_(n=0)^infinity (phi^(2n))/((2n)!) + mat(0,1;-1,0) sum_(n=0)^infinity (phi^(2n+1))/((2n+1)!) $
tal que 

$ sum_(n=0)^infinity(phi^(2n))/((2n)!) = cos phi quad quad sum_(n=0)^infinity(phi^(2n+1))/((2n+1)!) = sin phi $

de lo que se deduce  que 

$   exp A  = mat(cos phi,0;0,cos phi) + mat(0,sin phi;- sin phi,0) = mat(cos phi,sin phi;- sin phi,cos phi) $ 

tal y como queríamos demostrar. 

#v(1em)

El siguiente apartado es un poco pesado. Básicamente tenemos que demostar que la matriz $A_(i j)$ es ortogonal. Esto implica demostrar qeu $A_(i j)^(-1) = A_(j i) = A_(i j)^T$, o lo que es lo mismo, qeu $A_(i k) A_(j k) = delta_(i j)$. Teniendo en cuenta que: 


$ A_(i j) = delta_(i j) (e_0^2 - |en|^2) + 2 e_i e_j + 2 epsilon_(i j k) e_0 e_k quad e_0 = cos Phi/2 quad en = un sin Phi/n $

Veamos que 

$ A_(i k) A_(j k) = &  [delta_(i k) (e_0^2 - |en|^2) + 2 e_i e_k + 2 epsilon_(i k l) e_0 e_l][delta_(j k) (e_0^2 - |en|^2) + 2 e_j e_k + 2 epsilon_(j k m) e_0 e_m] \
 = &  delta_(i j) (e_0^2 - |en|^2)^2 + 2 e_i e_j (e_0^2 - |en|^2)  + 2 epsilon_(j i m) e_0 e_m (e_0^2 - |en|^2) \
 & + 2 e_i e_j (e_0^2 - |en|^2) + 4 e_i e_j |en|^2 + 4 epsilon_(j k m) e_i e_k e_m e_0 \
 & + 2 e_0 e_l epsilon_(i j l) (e_0^2 - |en|^2) + 4 epsilon_(i k l) e_j e_k e_l e_0 + 4 (e_0)^2 e_l e_m (delta_(i j) delta_(l m) - delta_(i m) delta_(j l))
$
Algunos términos desaparecen, como 

$ 2 e_0 e_l epsilon_(i j l) + 2 e_0 e_m epsilon_(j i m) = 0 $
lo cual es evidente si tenemos en cuenta que $e_(i j k) = - e_(j i k)$. Además, también es cero

$   epsilon_(j k m) e_i e_k e_m e_0 = epsilon_(i k l) e_j e_k e_l e_0  =0 $
ya que $epsilon_(j k m) e_k e_m = en times en = 0$.  Así pues: 

$ A_(i k) A_(j k) = &  delta_(i j) (e_0^2 - |en|^2)^2 + 2 e_i e_j (e_0^2 - |en|^2)  + 2 e_i e_j (e_0^2 - |en|^2) \ & + 4 e_i e_j |en|^2 + 4 (e_0)^2 e_l e_m (delta_(i j) delta_(l m) - delta_(i m) delta_(j l))
$


Usando que: 


$ cos Phi = (cos^2 Phi/2 - sin^2 Phi/2) quad quad sin Phi = sin Phi/2 cos Phi/2 $

y que

$ 4 (e_0)^2 e_l e_m (delta_(i j) delta_(l m) - delta_(i m) delta_(j l)) = 4 e_0^2 (delta_(i j) |en|^2 - e_i e_j) $ 

llegamos a: 

$ A_(i k) A_(j k) = &  delta_(i j) (e_0^2 - |en|^2)^2 + 2 e_i e_j (e_0^2 - |en|^2)  + 2 e_i e_j (e_0^2 - |en|^2) \ & + 4 e_i e_j |en|^2 + 4 e_0^2 (delta_(i j) |en|^2 - e_i e_j)
$
que nos lleva a: 

$ A_(i k) A_(j k) = delta_(i j) [(e_0^2 - |en|^2)^2 + e_0^2 |en|^2] + 4 e_i e_j (e_0^2 - |en|^2) + 4 e_i e_j |en|^2 - 4 e_0^ e_i e_j $

lo que nos lleva a 

$ A_(i k) A_(j k) = delta_(i j) [(e_0^2 - |en|^2)^2 + e_0^2 |en|^2] = delta_(i j) [cos^2 Phi + sin^2 Phi] = delta_(i j) $
tal y como queríamos demostrar.

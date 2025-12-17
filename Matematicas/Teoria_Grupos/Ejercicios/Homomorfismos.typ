#import "../../../plantilla.typ": *

== Ejercicios 

//==================================
// -- EJERCICIO 1 -------------------
//==================================

#exercise()[
  Demuéstrese que si $G=H_1 otimes H_2$, entonces $G/H_1 tilde.eq  H_2$ y que $G/H_2 tilde.eq H_1$ donde $tilde.eq$ significa isomorfo. 
] 

Definimos como isomorfismo a cualquier a cualquier homomorfismo biyectivo (1:1), esto es, que la aplicación $f:A arrow B$ (siendo $A$ y $B$ dos grupos cualquiera), verifique 

$ f(a_1a_2) = f(a_1) f(a_2) quad a_1,a_2 in A $

y que además sea inyectivo $f(e_A)=e_B$  y suprayectivo. La notación de nos dice que 

$ G/A = {e A,g_2 A, g_3 A,...,g_s A} $

Así pues $G/A$ representa el conjunto de cosets por la izquierda, que es grupo por ser $A$ normal (lo que viene, a su vez, del producto directo). Por otro lado, que $G = A otimes B$ implica que todos los elementos $a in A$ conmuta con $b in B$, y que 

$ forall g in G quad g = a b quad a in A quad b in B $
además $g=a b = a' b' arrow.r.double a = a', b = b'$. Resulta casi trivial entonces que es un isomorfismo. Dado que 

$ G/A = {e A,g_2 A, g_3 A,...,g_s A} $
y que $g_i = a_i b_i$. Entonces es obvio que los elementos de $G/A$ son de la forma 

$G/A = {b_1 A,b_2 A,b_3 A,...,b_s A}$
ya que $a_1 b_1 eq.not a_2 b_2 $. La aplicación $f:G/A arrow B$ es evidente:

$ f( g_i A ) = f(b_i A) = b_i A A^(-1) = b $
Veamos que: 

- Es un homomorfismo: 
  $ f(b_i A b_j A) = f(b_i b_j A) = b_i b_j quad  f(b_i A) f(b_j A) = b_i b_j  $
  donde hemos usado que $b_i A b_j A = b_i b_j A$ que se deduce de que $A$ y $B$ conmutan (sus elementos).
- Es inyectiva: 
  $ f(e_B e_A) = e_B $
  siendo obviamente $e_B e_A$ el elemento neutro de $G/A$ y $e_B$ el elemento neutro de $B$.
- Es sobreyectiva, ya que se generan todos los elementos de $B$ al hacer la aplicación $f(G/A)$. 

por lo que hemos demostrado que efectivamente $G/A tilde.eq B$. De manera análoga para $G/B tilde.eq A$. Se optó por la notación $A,B$ frente a $H_1,H_2$ por que es, para el autor, más claro. 


//==================================
// -- EJERCICIO 2 -------------------
//==================================


#exercise()[
  Considérese el conjunto de las matrices complejas de dimensión $n times n$ no singulares $G L (n)$: no singulares con determinante 1, $S L (n)$; unitarias, $U (n)$; y unitarias con determinante  1, $S U(n)$. Demuestre que $G L(n)$ es un grupo y que $S L (n)$, $U(n)$ y $S U (n)$ son subgrupos de $ G L (n)$. 
] 

Lo primero que tenemos que demostrar es que $G L (n)$ es grupo, lo que lleva a demostrar la _propieda de cierre, inversa y neutro_. Así: 

- *Cierre*. Sean $A,B in G L(n)$. Entonces $ "det"(A B) = "det"(A) dot "det"(B) != 0, $ ya que $"det"(A) != 0$ y $"det"(B) != 0$. Por tanto $ A B in G L(n) $.

- *Asociatividad*. La asociatividad del producto se hereda del producto matricial en $M_n(F)$: $ (A B) C = A (B C) quad forall A,B,C in G L(n). $

- *Elemento neutro*. El elemento neutro es la matriz identidad $I_n$, que verifica $ I_n A = A I_n = A quad forall A in G L(n), $ y además $ "det"(I_n) = 1 != 0. $ Luego $ I_n in G L(n) $.

- *Inverso*. Sea $A in G L(n)$. Como $"det"(A) != 0$, la matriz $A$ es invertible y existe $ A^(-1) in M_n(F) $ tal que $ A A^(-1) = A^(-1) A = I_n. $ Además, $ "det"(A^(-1)) = 1 / "det"(A) != 0, $ por lo que $ A^(-1) in G L(n) $.

Como se satisfacen las propiedades de cierre, asociatividad, elemento neutro e inverso,
concluimos que $G L(n)$ es un grupo.

#v(1em)

La única propiedad que tenemos que demostrar es la _propiedad de cierre_, inversa y neutro, ¿Son también subgrupos?

- El conjunto $S L(n)$. La relación de determinantes exige que $ A dot B = C quad "det"(A B) = "det"(A) dot "det"(B) = "det"(C) $ por lo que $C in S L (n)$. Luego, ¿$A^(-1) in S L(n)$? Veamos que $ "det"(A^(-1)) = 1/("det"(A)) $  y como $"det"(A)=1  arrow.r.double "det"(A^(-1)) =1$. La asociatividad se hereda, y dado que el neutro de $S L(n)$ es la matriz identidad de determinante 1, queda claro que $ S L (n)$ es subgrupo de $G L (n)$. 

- La característica de unitario implica que $ forall U in U(n) quad U U^dagger = II $. Supogamos entonces que $U,V in U(n)$, entonces  $ U V = W quad W^dagger = (U V)^dagger "tal que" W W^dagger = (U V)(U V)^dagger = (U V)(V^dagger U^dagger) = II  $ por lo que se demuestra la propieda de cierre. La inversa de $U$ sería $U^dagger$, y como $U^dagger in  U(n)$, también se verifica la propiedad de inverso. La propiedad de nuetro es trivial si recordamos que es la identidad su neutro. Es obvio que $II II^dagger = II$ ya que $II^dagger = II$.

- La característica de unitario implica que $ forall U in S U(n) quad U U^dagger = II $. Supogamos entonces que $U,V in S U(n)$, entonces  $ U V = W quad W^dagger = (U V)^dagger "tal que" W W^dagger = (U V)(U V)^dagger = (U V)(V^dagger U^dagger) = II  $ por lo que se demuestra la propieda de cierre. Por otro lado la relación de determinantes exige que, si $U,V in S U(2)$:  $ U dot V = W quad "det"(U,V) = "det"(U) dot "det"(V) = "det"(W) $ por lo que $W in S U (n)$. Luego, ¿$U^(-1) in S U(n)$? Veamos que: $ "det"(U^(-1)) = 1/("det"(U)) $ y como $ "det"(U)=1  arrow.r.double "det"(U^(-1)) =1 $.La inversa de $U$ sería $U^dagger$, y como $U^dagger in S U(n)$, también se verifica la propiedad de inverso.  Por ser la identidad $II$  eutro y unitario,  también se veriifca neutro y por la asociatividad es heredada. 
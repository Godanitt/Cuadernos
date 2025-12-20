
#import "../../../plantilla.typ": *

Las formas exteriores aparecen implicitamente en aspectos de la física y la ingeniería. Lo que se conciven como integrandos de línea, superficies, volúmenes o generalizaciones $n$-dimensionales, son formas exteriores. En este capítulo de hecho lo que vamos a cer es como nosotros _no integramos vectores, integramos formas_. Por ejemplo, la fuerza de un campo eléctrico puede ser determinado moviendo una unidad de carga "lentamente" a lo largo de un camino, es decir, una _integral de línea_. En este sentido, un campo eléctrico es una 1-forma. 


== Integración sobre un Conjunto Parametrizado

=== Integración de una $p-$forma en $RR^p$

La noción de una integral múltiple de una función $f$ sobre una región $RR^p$ es algo a lo que, en general, estamos acostumbrados: 

$ integral_U f(u) dif u^1 ... dif u^p $

Sin embargo, esta integral _no envuelve conceptos como orientación_, y no importa el orden en el que  aparece $dif u^i$. 

#definition(name:"Integral Orientada")[
Ahora definimos la integral de una $p$-forma $alpha^p = a(u) dif u^1 times ... times dif u^p$ sobre una _región *orientada*_ $(U,o) subset RR^p$ como

$ integral_((U,o)) alpha = & integral_((U,o)) a(u) dif u^1 times ... times dif u^p \ := & o(u) integral_U a(u) dif u^1 ... dif u^p $

donde la última integral es la integral múltiple usual, que integra sobre una región $U$ del espacio sin consideración en la orientación. ]

El valor $o(u)=plus.minus 1$, siendo el signo $+$ el  elegido si, y solo si, la base de coordenadas: 


$ ((partial)/(partial u^1), ... ,(partial)/(partial u^p)) $

tiene la misma orientación que el $o$ dado. Claramente, la integral de una $p$-forma cambia a su valor negativo si se ve revertido: 

$ integral_((U,-o)) alpha  = -integral_((U,p)) alpha  $

Dada esta definición pdoemos ver que de hecho es independiente de las coordenadas $u$ usadas en $RR^p$. 

=== Integración sobre Subcojuntos Parametrizados 

#definition(name: "Subconjunto parametrizado orientado")[
  Definimos como un $p-$subconjunto parametrizado y orientado de una variedad $M^n$ como $(U,o,F)$, que conssite de una región orientada $(U,o)$ en $RR^p$ y un mapa diferenciable 
  $F: U arrow M^n$
  También llamamos al conjunto de puntos $F(u) subset M^n$ como $p-$subconjunto.
]

Cuando $p=1$, tenemos simplemente una _curva_ en $M^n$ con una parametrización específica expresada localmente como $x^i=x^i (t)$, y cuando $p=2$ tenemos una _superficie_ en $M^n$ de nuevo con una parametrización específica $x^i = x^i(u,v)$. 

#v(1em)

Si $alpha^p$ es una $p$-forma de $M^n$, definida la menos en un vecindario de la imagen $F(U)$ de $U$, entonces definimos la integral de $alpha^p$ sobre el $p-$subconjunto parametrizado y orientado como

$ integral_((U,o,F)) alpha^p : = integral_((U,o)) F^* alpha^p $ 
Si ahora queremos volver a la región orientada $(U,o)$, entonces la integral 
$ integral_((U,o,F)) alpha^p : = & integral_((U,o)) F^* alpha^p  \ 
= & integral_((U,o)) (F^* alpha^p) [(partial)/(partial u^1),..., (partial)/(partial u^p)] dif u^1 times ... times dif u^p \ 
= & o(u) integral_U (F^* alpha^p) [(partial)/(partial u^1), ..., (partial)/(partial u^p)] dif u^1 ... dif u^p $

=== Integrales sobre líneas
=== Integrales sobre superficies
=== Independencia de la parametrización

=== Integrales y _pull Backs_

Sea $phi: M^n arrow W^r$ un mapeo suave de variedades, y sea $F: U arrow M^n$ un $p-$subconjunto parametrizado y orientado de $M^n$. Entonces claramente $psi = phi compose F: U arrow W^r$ es un $p-$subconjunto parametrizado y orientado de $W^r$. Entonces si $alpha^p$ es una $p-$forma de $W^r$, tenemos 

$ integral_((U,psi)) alpha^p = integral_U psi^* alpha^p = integral_U (phi compose F)^* alpha^p = integral_U  F^* compose phi^* alpha^p = integral_((U,F)) phi^* alpha^p $

Si ahora llamamos $sigma$ al subcojunto orientado $(U,F)$ de $M^n$ entonces $(U,psi) = (U,phi compose F)$ será simplemente $phi (sigma)$, subconjunto de $W^r$. De esto se deduce la *fórmula general de pull-back*, tal que 

$ phi: M^n arrow W^r quad quad quad integral_(phi (sigma)) alpha^p = integral_(sigma) phi^* alpha^p $
En palabras: una integral de una forma sobre la imagen $phi (sigma) subset W^r$ de un subconjunto $sigma subset M^n$ es la integral del pull-back de la forma sobre $sigma$.

== Integración sobre Variedades con Frontera

Ahora vamos a estudiar como integrar sobre objetos que no pueden ser cubiertos con un solo subconjunto parametrizados, por ejemplo, subvariedades $p-$dimensionales orientadas. 

=== Variedades con Frontera

Una $n-$variedad con frontera $M^n$ tiene un interior que es genuinamente una $n-$variedad, y una frontera o contorno, normalmente escrito como $partial M$. Los puntos en la frontera tienen vecinos, aunque no formen un conjunto abierto de $RR^n$. A pesar de esto los seguiremos usando cartas de coordenadas como típicamente haríamos con conjuntos abiertos. Es importante decir que $partial M$ es, siempre, una variedad $(n-1)$-dimensional, sin frontera, aunqeu no necesariamente conectado (esto es, puede ser que esté formado por varias variedades disjuntas). Por supuesto, si $partial M = phi$ (vacío), entonces $M$ es una variedad genuina.  

=== Particiones de la unidad

Un punto $x in M^n$ se dice un *punto de acumulación* de un subconjunto $A subset M^n$ si todo entorno abierto de $x$ contiene al menos un punto de $A$ distinto del propio $x$.


#v(1em)

Es un hecho que, si se añaden a $A$ todos sus puntos de acumulación, el conjunto resultante, llamado la *clausura de* $A$, es un subconjunto cerrado; su complemento es abierto. (De hecho, un subconjunto de un espacio topológico es cerrado si y solo si contiene todos sus puntos de acumulación.)

#v(1em)

Recordemos que una función real $f : M -> RR$ es continua si la imagen inversa de todo conjunto abierto de $RR$ es un conjunto abierto de $M$. Los números reales no nulos forman claramente un subconjunto abierto de $RR$, y por tanto el subconjunto de $M$ donde $f != 0$ es un conjunto abierto de $M$, siendo $ f^(-1) (RR-0)$.  La clausura de este conjunto se denomina el *soporte de* $f$. Obsérvese que $f$ puede anularse en algunos puntos del soporte de $f$. 

=== Integración sobre una subvariedad compacta y orientada

Recordamos que un espacio topológico es compacto si para cada recubrimiento podemos extraer un subrecubrimiento finito. Esto signfica que toda variedad compacta puede ser recubierta por un número finito de cartas. 

#v(1em)

Dado un conjunto de cartas finitas ${U_alpha}$ con $alpha=1,...,N$ de $M^n$, la *partición de la unidad* mostrará $N$ funciones reales y diferencialbes $f_alpha: M^n arrow RR$. Dado que cada carta es un $p$-subconjunto  orientado y parametrizado, sabenmos como evaluar $integral_(U(alpha)) f_alpha beta^n$. Entonces definimos como


$ integral_V beta^p : = sum_alpha integral_(U(alpha)) f_alpha beta^p $

Es fácil de ver qeu la integral así definida es independiente del sistema de coordenadas elegido. Por supeusto $sum_alpha f_alpha = 1$. Finalmente, si $M^n$ es una variedad y $beta^p$ es una $p-$forma de $M^n$, definimos la integral de $beta^p$ sobre _cualquier subvariedad p-dimensional orientada y compacta $V_p subset M^n$_ como 

$ integral_V beta^p := integral_V i^* beta^p $
donde $i: V^p arrow M^n$ es el mapa de inclusión (nótese qeu $i^* beta^p$ es na $p-$forma del conjunto orientado $V_p$). 


== Teorema de Stokes 

=== Orientación en la frontera

Sea $M^n$ una variedad orientada con una frontera no vacía $partial M$. Este $partial M$ es una variedad ($n-1$)-dimensional sin frontera. Dada una orientación de $M^n$, nosotros podemos orientar la frontera $delta M^n$ como sigue. Sea $en_2,...,en_n$ el _espacio tangente_ a $delta M^n$ en $x$. Sea $Nn$ el vector tangente a $M^n$ en $x$, que es transversal a $partial M^n$ y apunta _fuera_ de $M^n$. 

#v(1em)

Entonces decidimos que $en_2,...,en_n$ está orientado positivamente para $partial M^n$  , mientras que $Nn,en_2,...,en_n$ está orientado positivamente respecto a la orientación de $M^n$. 

=== Teorema de Stokes 

#theorem(name:"Teorema de Stokes")[Sea $V^p subset M^n$ una subvariedad compacta y orientada con un frontera $partial V$ en una variedad $M^n$. Sea $omega^(p-1)$ una $(p-1)$-forma continuamente diferencial en $M^n$. Entonces: 

$ integral_V dif omega^(p-1) = integral_(partial V) omega^(p-1) $]

Versiones para $p=1,2$ y $RR^3$ fueron probadas antes de la versión general, que es la que enunciamos aquí y la que vamos a probar. Sea $i: V^p arrow M^n$ un mapa de inclusión. Entonces podemos expresar: 

$ integral_V dif omega^(p-1) = integral i^* dif omega^(p-1) = integral_V dif i^* omega^(p-1) $
y también que 

$ integral_(partial V) omega^(p-1) = integral_(partial V) i^* omega^(p-1) $
Por tanto basta con demostrar qeu 


$ integral_V dif beta^(p-1) = integral_(partial V) beta^(p-1) $
donde $beta^(p-1)$ es una forma continuamente diferenciable en $V^p$, olvidándonos de $M^n$. Dado que $V^p$ es compacto podemos elegir un recubrimiento finito de $V^p$ dado por ${V(alpha)}$. Sea entonces $1 = sum_alpha f_alpha$ la partición de la unidad asociada. Podemos escribir $beta = sum_alpha beta_alpha$ tal que $beta_alpha = f_alpha beta$. Entonces: 

$ integral_V dif beta^(p-1) = integral_V dif sum_alpha beta_alpha = sum_alpha integral_(V(alpha)) dif beta^(p-1)_alpha $

y 

$ integral_(partial V) beta^(p-1) = sum_alpha integral_(partial V) beta_alpha^(p-1) $

Por tanto solo tenemos que probar que

$ integral_(V(alpha)) dif beta^(p-1)_alpha = integral_(partial V) beta_alpha^(p-1) $ <ec:Stokes-01>
para la forma $beta_alpha^(p-1)$ cuyo soporte está contenido en $V(alpha)$. Para demostrar que esto se cumple tenemos dos casos: 

- *Caso 1)* $V(alpha)$ es una carta de coordenadas que está contenido en el interior de $V$, es decir, que es _disjunto_ de la frontera de $V$. Entonces, cuando expresamos todo en función de los términos de la parematrización $phi$ tal que $U(alpha) arrow V(alpha)$:  $ integral_(V(alpha)=phi U(alpha)) dif beta_alpha = integral_(U(alpha)) phi^* dif beta_alpha = integral_(U(alpha)) dif (phi^* beta_alpha) $ Denotamos $phi^* beta_alpha$ como $gamma^(p-1)$: $ phi^* beta_alpha equiv gamma^(p-1) = sum_i (-1)^(i-1) gamma_i dif u^1 times ... times hat(dif u^i) times ... times dif u^p $ a partir lo cual podemos expresar $ integral_(U(alpha)) dif gamma^(p-1) = & sum_i (-1)^(i-1) integral_(U(alpha)) dif (gamma_i dif u^1 times ... times hat(dif u^i) times ... times dif u^p) \ = & sum_i(-1)^(i-1) integral_(U(alpha)) ((partial gamma_i)/(partial u^r)) (dif u^r times dif  u^1 times ... times hat(dif u^i) times ... times dif u^p)  \ = & sum_i integral_(U(alpha)) ((partial gamma_i)/(partial u^i)) (dif u^1 times ... times dif u^p) $ Podemos asumir que la carta de coordenadas $V(alpha)$ está positivamente orientada, arrastrandola de $V$. Entonces la última integral _se convierte en una integral múltiple_, y dado que el sporte de $dif phi^* beta_alpha$ está complemtamente contenido en $U(alpha)$, podemos remplazar $U(alpha)$ en la integral de la derecha por una integral sobre todo $RR^p$, tal que $ integral_(U(alpha)) dif gamma^(p-1) = & sum_i integral_(RR^ r) ((partial gamma_i)/(partial u^i)) dif u^1 ... dif u^p \ = & sum_i integral_(RR^(p-1)) dif u^1 ... hat(dif u^i) ... dif u^p integral_(- infinity)^(infinity) ((partial gamma_i)/(partial u^i)= dif u^i = 0 $ y dado que $gamma^i$ es cero fuera de $U(alpha)$, entonces la parte izquierda de la @ec:Stokes-01 se hace cero, y como el lado derecho también se anula dado que $partial V$ no es compatible con el soporte de $beta_alpha$, hemos demostrado este caso. 

- *Caso 2)* Supongamos que $V(alpha)$ es una carta de coordenadas que coincide con la frontera. El procedimiento, análogo al del caso 1, nos lleva a demostrar que $ integral_(U(alpha)) dif gamma^(p-1) =  sum_i integral_(U(alpha)) ((partial gamma_i)/(partial u^i)) (dif u^1 times ... times dif u^p) $, tal que el único término que no se anula es $i=p$, dado que los otros tériminos tendrán elementos del tipo $ integral_(-infinity)^infinity ((partial gamma_i)/(partial u^i)) dif u^i $ que se anula si $i<p$. Entonces: $ integral_(V(alpha)) dif beta_alpha= & integral_(U(alpha)) ((partial gamma_p)/(partial u^p)) dif u^1 ... dif u^p \ = & integral_(RR^(p-1)) dif u^1 ... dif u^(p-1) integral_0^infinity ((partial gamma_p)/(partial u^p)) dif u^p \ = & integral_(RR^(p-1)) [gamma_p(infinity)-gamma_p(0)] dif u^1 ... dif u^(p-1) \  =  & - integral_(RR^(p-1)) gamma_p (u^1,...,u^(p-1),0) dif u^1 ... dif u^(p-1) $ Si nos restringimos a $phi:U(alpha) arrow V$ al subconjunto $Y$ de $U(alpha)$ definido por $u^p = 0$ de dodne obtenemos una carata ($p-1$)-dimensional $W(alpha)$ para $partial V$; $phi (Y) = W$. Luego el soporte de $beta_alpha$ está contenido en $partial V$, a través de $W$, y por tanto $ integral_(partial V) beta_alpha = & integral_(W = phi (Y)) beta_alpha = integral_Y phi^* beta_alpha = integral_Y gamma \ = & integral_Y sum_i (-1)^(i-1) gamma_i (u^1,...,u^p)(dif u^1 times ... times hat(dif u^i) times ... times dif u^p  $ pero como $u^p = 0$ en $Y$ y $dif u^p = 0$, el único elemento que no se anula es:  $ integral_(partial V) beta_alpha = integral_Y (-1)^(p-1) gamma_p (u^1,...,u^(p-1),0) (dif u^1 times ... times dif u^(p-1)) $ Ahora como $(partial)/(partial u^1),...,(partial)/(partial u^p)$ está _positivamente orientado en $V$_, y como $-(partial)/(partial u^p)$ es la normal que apunta "al exterior" de $partial V$, concluimos que efectivamente $(partial)/(partial u^1),...,(partial)/(partial u^(p-1))$ lleva una orientación $(-1)^p$ en $partial V$. Consecuentamente: $ integral_(partial V) beta_alpha = (-1)^p integral_Y (-1)^(p-1) gamma_p (u^1 , ..., u^(p-1),0) dif u^1 ... dif u^(p-1) $ por lo que hemos demostrado el teorema. 



En el caso de $p=1$, una variedad de dimensión 1 es una curva simple $C$. Pdemos asumir que su frontera empieza en un punto $P=x(a) in M^n$, y acaba en $Q = x(b) in M^n$. Si definimos la orientación de $C$ como $partial C = Q - P$, y definimos $f(partial C) = f(Q) - f(P)$, entonces el Teorema de Stokes contiene incluso el caso $p=1$. 




== Integración en Pseudoformas 


== Ecuaciones de Maxwell
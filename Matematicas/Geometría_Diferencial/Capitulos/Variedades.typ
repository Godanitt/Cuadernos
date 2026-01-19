#import "../../../plantilla.typ": *

== Topología 

Conceptos como _continuidad_, _diferenciabilidad_, son parte de una de las ramas más importantes de las matemáticas, el análisis, y sin embargo son esenciamente geometricos, y requieren el uso de *topología* para una _definición rigurosa_. La topología es la estrucutra que se impone en un conjunto de elementos/objetos que nos permiten desarrollar los términos de _convergencia_ y _límite_. Un espacio con una topología definida podrá ser llamado *espacio topológico*, y un _mapa continuo_ entre esapcios topológicos es aquel que preserva los puntos límites de los subconjuntos. La mejor manera de aproximarse a esta materia es a través de los _conjuntos abiertos_. 

#v(1em)

Consideremos entonecs un espacio dos dimensional $S$ insertado en un espacio tres dimensional euclídeo $RR^3$. En este caso podemos entender intuitivamente lo que es una "deformación continua", siendo una aplicación de la superficie que no implica ningún desgarro. La topología básicamente maneja estas propiedades que son invariantes bajo _deformaciones continuas_. 

=== Topología Euclideana

Resúmase capítulo 10.1 de #cite(<Szekeres_2004>).

=== Espacios Topológicos Genéricos

#definition(name:"Topología")[
  Dado un conjunto $X$, una _topología en $X$_ consiste en una famlia de subconjuntos $Ocal$, llamados _conjuntos abiertos_ que siguen la siguientes condiciones:
  + El conjunto vacío $emptyset$ es abierto y el espacio $X$ es abierto ${emptyset,X} subset Ocal$.
  + Si $U$ y $V$ son conjuntos abiertos, entonces su intersección $U inter V$, $ U in Ocal " y " V in Ocal arrow.long.double U inter V in Ocal $
  + Si ${V_i | i in I}$ es una familia de conjuntos abiertos entonces su unión $union.big_(i in I) V_i$ es abierto. 
]

Curiosamente, la definición de "topología" inlcuye la definición de abierto. Un abierto es _cualquier conjunto de conjuntos_ que verifique dichas condiciones. Por ejemplo, una *bola abierta* en un espacio euclídeo $RR^n$ cumple esas condiciones, y por eso se llama abierto. Sin embargo no hace falta definir "distancias" (i.e. tener un espacio métrico) para definir un abierto, por eso decimos que _un espacio métrico es siempre topológico pero un espacio topológico no tiene que ser necesariamente métrico_. 

#v(1em)

Redactar Ejemplos 10.2 #cite(<Szekeres_2004>).

/*
#example()[
  Definimos $Ocal$ como la colección de subconjuntos de $U$ de $RR$ tal que para cada $x in U$ existe un intervalo abierto ($x - epsilon, x + epsilon) subset.eq  U$) para un $epsilon>0$. El conjunto vacío $emptyset$ y el $RR$ son trvialmente abiertos (cada punto de $x in RR$ cae en un abierto: $RR$). Sea entonces $U$ y $V$ dos conjutnos abiertos tales que $U inter V eq.not emptyset$.]
*/

#definition(name:"Espacio Topológico")[
  El par $(X,Ocal)$ donde $Ocal$ es una _topología en $X$_ se llama espacio topológico. Muchas veces se dice que $X$ es el espacio topológico cuando $Ocal$ está entendido. Los elementos de $X$ se suelen llamar puntos.   
] 

Se dice que un conjunto $A$ es *vecindario* de $x in X$ si existe un conjunto abierto $U$ tal que $x in U subset A$. Decimos que un espacio topológico $X$ es *primer contable* para todo punto de $x in X$ tenemos un una colección de vecestáindarios de $x$ abiertos $U_1(x),U_2(x)...$ tal que cada vecindario abierto de $x$ $U$ contenga a esta colección $U_n(x) subset U$.

#v(1em)

Sean $X$ e $Y$ espacios topológicos. Una función $f:X arrow Y$ entre espacios topológicas es *continua* si la imagen inversa $f^(-1)(U)$ de cada abierto $U$ en $Y$ es abierto en $X$. Si $f$ es 1 a 1 (biyectiva) y $f^(-1):Y arrow X$ es continua, entonces decimos qeu $f$ es un *homeomorfismo* y los espacios $X$ e $Y$ son *homeomórficos* (topológicamente equivalentes) y se denotan como $X tilde.equiv Y$. 

#v(1em)

El punto principal de la topología es encontrar los *invariantes topológicos*, propiedades que se preservan en bajos homeomofismos. El objetivo último de la topología es estudiar los invariantes que caracterizan une esapacio topológico. 

=== Espacio Métrico

La idea de esapcio métrico viene a generalizar la idea de distancia, que está implícita en un epacio euclídeo. 

#definition(name:"Espacio Métrico")[
  Definimos como espacio métrico a un conjunto de elementos $M$ con una *función distancia* o *métrica* $d: M times M arrow RR$ tal que 
  + $d(x,y) gt.eq 0$ para todo $x,y in M$.
  + $d(x,y) =  0$ sí y solo sí $x=y$.
  + $d(x,y) = d(y,x)$.
  + $d(x,y) + d(y,z) gt.eq d(x,z)$.

]

Para cada punto $x$ en un espacio métrico ($M,d$) y un número real $a>0$, deifnimos una *bola abierta* $B_a(x) = {y|d(x,y)<a}$. 

#v(1em)

Acabar de redactar 10.3 #cite(<Szekeres_2004>)

=== Espacio de Hausdorff 

En algunas topologías, existen conjuntos abiertos cuyos puntos no pueden ser separados por vecindarios que no intersecan. Para remediar esto, se crean oos llamados axiomas de separación. Uno de los más usados es la *condición de Haussdorff*. Esta nos dice que para cada par de puntos $x,y in X$ existen conjuntos abiertos $U$ de $x$ y $V$ de $y$ tales que $U inter V = emptyset$. Un espacio topológico que cumpla esta propiedad se llama *espacio de Hausdorff*. Una idea intuitiva de este tipo de espacios es esta: "no todos los pares de puntos de un espacio de Haussdorff están arbitrariamente cerca". 

#v(1em)

#theorem()[
  Cada espacio métrico $(X,d)$ es un espacio de Hausdorff. 
]


Redactar 10.5 #cite(<Szekeres_2004>)

=== Espacios Compactos




== Variedades Diferenciables

=== Introducción

Para muchos físicos y matemáticos el concepto de "mapa" dado por la topología no es suficiente. Y para un español más, ya que, las traducciones, no juegan a nuestro favor. Cuando hablamos de mapa nos referimos a _relaciones entre espacios_, incluso espacios no euclídeos (como por ejemplo la superficie de una esfera). Los conceptos/objetos que nos permiten relacionar espacios no euclídeos con, de hecho, espacios "localmente euclidéanos" son lo que llamamos _variedades diferenciables_. La geometría diferencial es precisamente el área que estudia estas estructuras, y sus aplicaciones son abundantes, siendo la más interesante y bella la Relatividad General. 

#v(1em)

Un mapa, aunque sea una definición abstracta, en realidad se puede pensar como la definición clásica de mapa. Pensemos en la superficie de la Tierra. Dado que es una esfera, no es ni métricamente ni topológicamente un espacio euclídeo plano $RR^2$. Sin embargo hay formas de representar la tierra en uno o varios planos (mapas). Un atlas consistirá en diferentes planos o _cartas_, cada uno representando diferentes partes de la Tierra. Supongamos por ejemplo que tenemos un mapa de Francia. Es evidente que habrá regiones donde esta carta se concectará con otras cartas, aunque sean en pequeñas regiones (véase el norte de España comprenderá parte del sur de Francia, y la parte sur del mapa de Francia comprenderá una pequeña parte del Norte del España). La correspondencia entre estas regiones de las cartas, esta región superpuesta será continua y suave, y exisitirá una correspondencia 1 a 1. Algunas cartas incluso se podrán encontrar dentro de otras (véase una carta de España y una carta de Europa). E ahí donde podemos ver las relaciones mapa $arrow.l.r$ carta $arrow.l.r$ atlas. Estas definiciones que hemos hecho no son precisamente abstractas o rigurosas, sin embargo son fundamentales para hacernos una idea clara de lo que estudia la geometría diferencial. 

#v(1em)

=== Variedades Diferenciales 

Los puntos de $RR^n$ serán denotados como $xn = (x^1,x^2,...,x^n)$. Una función $f:RR^n arrow R$ será de tipo $C^r$ si todas sus derivadas parciales existen: 


$ (partial^s f(x^1,x^2,...,x^n))/(partial x^(i_1) partial x^(i_2) ... partial x^(i_s)) $

existe y son continuas para $s=1,2,...,r$. Una función $C^0$ es aquella simplemente continuam nnuebtras que a $C^infinity$ será una *función diferenciable*. 

#definition(name: "Mapa")[
  Definimos un *mapa* como una función $phi:RR^n arrow RR^m$ que es un conjunto de funciones $phi_i: RR^n arrow RR$. Se dirá que es de tipo $C^r$ cuando todas sus $phi_ i$ son de tipo $C^r$. 
]

#definition(name:"Variedad topológica")[
  Una variedad topológica es un espacio de Hausdorff $M$ en el que cada punto $x$ tiene un vecindario homeomórfico a un conjunto abierto $RR^n$. 
]

Como sabemos, todo espacio métrico (como $RR^n$) es de Hausdorff, por lo que para que $M$ sea localmente homeomórfico a $RR^n$ debe de ser de Hausdorff. 

#definition(name:"Carta de Coordenadas")[
  Sea $p$ un punto cualquiera de la variedad topológica $M$. Entonces la *carta de coordendas* en $p$ es el par $(U,phi)$ donde $U$ es un subconjunto abierto de $M$ llamado _dominio de la carta_  y $phi$ una función tal que $phi:U arrow phi (U) subset RR^n$ es un homeomorfismo entre $U$ y su imagen $phi (U)$. Por otro lado, $phi (U)$ es un subconjunto abierto de $RR^n$. 
]

Llamamos  a$U$ el *vecindario* de $p$ y a $phi$ el *mapa de coordenadas*. Las funciones $x^i = phi^i: U arrow R$ ($i=1,...,n$). En libros como el #cite(<Szekeres_2004>) usan lo que llamamos los _mapas de proyección_ $"pr"_i: RR^n arrow R$, que se usa como $x^i = phi^i = "pr"_i compose phi$ donde $compose$ implica composición $"pr"_i compose phi = "pr"_i (phi)$. 

#v(1em)

Para un par de coordenadas $(U,phi';x^i)$ y $(U',phi',x^(prime j))$ tal que $U inter U' eq.not emptyset$, se definen las *funciones de transición*:

$ phi' compose phi^(-1): phi (U inter U') arrow phi' (U inter U') $
$ phi  compose phi^(prime -1): phi'(U inter U') arrow phi (U inter U') $

Las funciones de transición muchas veces se denotan como


$ x'^j = x'^j (xn) quad quad x^j = x^j (xn') $ <Ec:01.transicion>

que es la manera abreviada de escribirlo con los _mapas de proyección_. Decimos que las dos cartas son $C^r$-compatibles cuando las  @Ec:01.transicion son de tipo $C^r$ (obviamente $r={ZZ^+,infinity}$). 


#definition(name:"Atlas")[
  Un atlas en una variedad $M$ es una familia de cartas $Acal = {(U_alpha,phi_alpha)|alpha in A}$ tal que los $U_alpha$ cubren completamente $M$, y todos los pares de cartas son $C^infinity$-compatibles. Si $Acal$ y $Acal'$ son dos atlas de $M$, la unión también es atlas de $M$. 
]

#definition(name:"Variedad Diferenciable")[
  Cualquier atlas $Acal$ puede exterderse a un _atlas maximal_ añadiendo todas las cartas $C^infinity$-compatibles con $Acal$. Un atlas maximal es llamada la _estructura diferenciable_ de $M$. Un par $(M,Acal)$, donde $M$ es una variedad topológica $n$-dimensional y $A$ es la estructura diferenciable de $M$, es llamado *variedad diferenciable*. 
]

Una matriz Jacobiana $J = [partial x^(prime k) \/ partial x^j]$ es no singular dado que su inversa existe tal que  $J J^(-1) = J^(-1) J = 1$. Por definición $det J eq.not 0$.

=== Ejemplos

#example()[
  El espacio euclídeo es una variedad trivialmente, ya que la carta $U=RR^n$, $phi = "id"$ (identidad) cubre y genera un atlas único. El atlas generado es conssite en todas las cartas compatibles con el mismo. Por ejemplo, $RR^2$ se puede expresar en coordenadas polares $(r,theta)$ definiendo 
  $ x = r cos theta quad y = r sin theta $
  que son compatibles con $(x,y)$ en el conjunto abierto $U=RR^2 - {(x,y) | x >= 0, y = 0}$. La transformada inversa será 

  $ r = sqrt(x^2 + y^2) quad theta = cases( arctan y/x   & "if" y>0, pi & "if" y = 0  x<0, pi + arctan y/x quad &  "if" y<0  )   $
  El conjunto $phi(U)$ en el  plano $(r,theta)$ es un conjunto abirto semi-infinito $r>0$, $0 < theta < 2 pi$. 
]

#example()[
  El círculo $S^1 subset RR^2$, definido por la ecuaión $x^2 + y^2 = 1$, es una variedad uno-dimensional. La coordenada $x$ puede ser usada tanto en la región superior o inferior del semicírculo, pero no sobre todo $S^1$. Alternativamente, igualar $r=1$ en las coordenadas polares hace que $(U,phi;theta)$ donde $U=S^1 - {(1,0)}$ y $phi:U arrow RR$ está definido por $phi(x,y) = theta$. La imagen $phi(U)$ es el intervalo $(0,2 pi) subset RR$. Estas cartas son claramente compatibles entre sí. $S^1$ es la única variedad dimensional que no es homeomórfico a la línea real $RR$.
]


== Mapas y Curvas diferenciables 

Sea $M$ una variedad diferencial de dimensión $n$. Un mapa $f: M arrow RR$ se dice _*diferenciable* en el punto $p in M$_ si para una carta de coordenadas $(U,phi;x^i)$ en $p$ la función $hat(f) = f compose phi^(-1): phi(U) arrow RR$ es diferenciable en $phi(p) = xn (p) = (x^1(p), x^2(p),...,x^n (p))$. Esta definición es independiente de la elección de cartas en $p$. 

#v(1em)

Dado un conjunto abierto $V subset.eq M$, la función real $f: M arrow RR$ es _diferenciable o suave_ entre variedades en $V$ si es diferenciable en todo punto $p in V$. Para esto la función solo necesita ser definida en el subconjunto abierto $V$. Denotamos como $Fcal (V)$ a todas las funciones diferenciables en el conjunto abierto $V$. Dado que la suma $f+g$ y el producto $f g$ son funciones diferenciables para cualquier par de funciones diferenciables $f$ y $g$, tenemos que $Fcal (V)$ es un anillo. Además, $Fcal (V)$ es cerrado respecto las combinaciones lineales $f+a g$ donde $a in RR$, y es además un espacio vectorial, y un álgebra conmutativa respecto a la multiplicación de funciones $f g$. Todas las funciones $Fcal_p (M)$ son diferenciables en un vecindario abierto $V$ del punto $p in M$. 

#definition(name:"Difeomorfismo")[
  Definimos como difeomorfismo como un mapa $alpha: M arrow N$ tal que $alpha$ y $alpha^(-1)$ son uno-a-uno. Las dos variedades $M$ y $N$ relacionados por un difeomorfismo se dicen _difeomórficas_ y se denotan como $M tilde.equiv N$. Si
]

Por definición, para que dos variedades sean difeomórficas deben tener la misma dimensión. 


#definition(name:"Curva suave")[
  Definimos como curva suave en una variedad $M$ $n-$dimensiona como u mapa suave $gamma:(a,b) arrow M$ desde un intervalo abierto $(a,b)subset.eq RR$ de la línea real hacia la variedad $M$. 
]

Se dice que la curva _atraviesa_ el punto $p$ en $t=t_0$ si $gamma (t_0)=p$, donde $a < t_0 < b$. Nótese que una curva parametrizada es el mapa, no la imagen. 


== Espacio tangente, contangente y tensorial

=== Espacio tangente

Sea $x^i = x^i(t)$ una curva en $RR^n$ atravesando el punto $xn_0 = xn (t_0)$. En matemática elemental, es común definir la "tangente" a la curva o "velocidad" como el $n$-vector $vn = (dot(xn)) = (dot(x)^1,...,dot(x)^n)$ donde $dot(xn)^i  = (dif x^i slash dif t)_(t=t_0)$. Esto funciona efectivamente en un espacio euclídeo, sin embargo en una variedad $n$-dimensional esto no es suficiente, ya que en una variedad debemos definir los objetos sin coordenadas. 

#v(1em)

El concepto que nos permite definir una tangente independientemetne de las coordenadas (_invariante_) es la *derivada direccional* $f:RR^n arrow RR$ a lo largo de la curva $xn_0$:

$ X f = evaluated(dv(f(xn(t)),t))_(t=t_0) = evaluated(dv(x^i(t),t))_(t=t_0) = evaluated(pdv(f(xn),x^i))_(t=t_0) $

donde $X$ es el _operador diferenciable_

$ X = evaluated(dv(x^i (t),t))_(t=t_0) evaluated(pdv(,x^i))_(xn = xn_0) $

El valor del operador $X$ cuando lo aplicamos a la función $f$ solo depende de los valores que toma la función en el vecindario de $xn_0$ sobre la curva en cuestión, y es independiente de las coordenadas elegidos para el espacio $RR^n$. La expresión de arriba demuestra, sin embargo, que las componentes de un vector tangente en cualqueir sistema de coordenadas de $RR^n$ puede ser extraído del operador derivada parcial a partir de los coeficienes de expansión en términos de las derivadas parciales. 

#v(1em)

Así pues, la derivada direccional es un mapa real en el álgebra de funciones diferenciables en $xn_0$. Dos propiedades importantes tienen las derivadas direccionales $X: Fcal_(xn_0) (RR^n) arrow RR$:

- El espacio vectorial $Fcal_(xn-0) (RR^n)$ es lineal, es decir, para cualqueir par de funciones $f,g$ y números reales $a,b$ tenemos que $X(a f + b g) = a X f + b X g$. 
- La aplicación de $X$ sobre un producto de funciones $f g$ en el álgebra $Fcal_(xn_0) (RR^n)$ está determinado por la *regla de Leibnitz* $X(f g) = f(xn_0) X g + g(xn_0) X f$. 

Estas dos propiedades caracterizan completamente la clase de operadores derivada direccional, y puede ser usados para motivar la definición de _espacio tangente_ en un punto de una variedad general. 


#definition(name:"Vector tangente")[
  El *vector tangete* $X_p$ en el punto $p$ de una variedad diferencial $M$ es el mapa lineal desde el álgebra de funciones diferenciables en $p$ a los números reales $X_p: Fcal_p(M) arrow RR$, que satisface las reglas de Leibnitz para los productos: 
  $ X_p (a f + b g) = a X_p f + b X_p g $ <Ec:01.condicion_linealidad>
  $ X_p (f g) = f(xn_0) X_p g + g(xn_0) X_p f $ <Ec:01.condicion_leibnitz>
  son llamadas respectivamente _condición de linealidad_ y _condición de Leibnitz_. ]

Un conjunto de vectores tangentes en $p$ definen el espacio $T_p (M)$, ya que la combinación lineal $a X_p + b Y_p$ de vectores tangentes en $p$ definido como 


$ (a X_p + b Y_p ) f = a X_p f + b Y_p f $

también es un espacio tangente de $p$ al satisfacer las condiciones de linealidad @Ec:01.condicion_linealidad y Leibnitz @Ec:01.condicion_leibnitz. Así pues, llamamos a $T_p (M)$ *espacio tangente en* $p$. Si $(U,phi)$ es una carta en $p$ con funciones de coordenadas $x^i$, definimos los operadores 

$ partial_(x^i) equiv evaluated(pdv(,x^i))_p : Fcal_p (M) arrow RR $ <Ec:01.operadores_parciales>

tal que 

$ (partial_(x^i))_p f = evaluated(pdv(,x^i))_p f = evaluated(pdv(hat(f)(x^1,...,x^n),x^i))_(xn = phi(p)) $

donde $hat(f)=f compose phi^(-1): RR^n arrow RR$. Estos operadores son claramente vectores tangentes dado que satisfacen las condiciones de linealidad @Ec:01.condicion_linealidad y Leibnitz @Ec:01.condicion_leibnitz. Cualquier combinación lineal

$ X_p  = X^i evaluated(pdv(,x^i))_p equiv sum_(i=1)^n X^i evaluated(pdv(,x* i))_p quad "donde" quad X^i in RR $
es un vector tangente. Estos coeficientes $X^j$ pueden determinarse de la acción de $X$ sobre las funciones de coordenadas $x^j$: 

$ X_p x^j = X^i evaluated(pdv(x^j,x^i))_(xn = phi(p)) = X^i delta_i^j = X^j $

#theorem()[
  Si $(U,phi;x^i)$ es una carta en $p in M$, entonces los operadores $(partial_(x^i))_p$ definidos por @Ec:01.operadores_parciales forman una base del espacio tangente $T_p (M)$ y su dimensión es $n = dim (M)$
]

La prueba podemos encontrarla en el #cite(<Szekeres_2004>) teorema 15.1

#v(1em)

Los coeficientes $X^i = X_p x^i$ se denominan las _componentes_ del vector tangente $X_p$ en la carta $(U;x^i)$. ¿Cómo esta definición de vector tangente está relacionada con la curva $RR^n$? Sea $gamma: (a,b) arrow M$ la curva suave parametrizada que atraviesa el punto $p in M$ en $t=t_0$. Definimos el vector tangente a la curva en $p$ como el operador $dot(gamma)_p$ definido por la acción de una función arbitraria 

$ dot(gamma)_p f = evaluated((f compose gamma(t), t))_(t=t_0) $ 


=== Espacio cotangente y tensorial

El espacio dual $T_p^* (M)$ asociado con el espacio tangente en $p in M$ es llamado el *espacio cotangente* en $p$. Este espacio consiste en todas los funcionales lineales en $T_p (M)$, llamados *covectores* o *1-formas* en $p$. La acción de un covector $omega_p$ en $p$ sobre el vector tagente $X_p$  se puede denotar como $omega_p (X_p), braket(omega_p , X_p), braket(X_p ,  omega_p)$. 

#v(1em)

Si $f$ es una función diferenciable en $p$, entonces definimos como el *diferencial* de $p$ como el covector $(dif f)_p$, cuya acción sobre cualquier vector tangente $X_p$ en $p$ viene dado por: 

$ braket((dif f)_p , X_p) = X_p f $

Este es un funcional lineal, ya que para un par de vectores tangentes $X_p,Y_p$ y escalares $a,b in RR$:

$ braket((dif f)_p , a X_p + b Y_p ) = a  braket((dif f)_p , X_p ) + b braket((dif f)_p , Y_p ) $

Dado una carta $(U,phi;x^i)$ en  $p$, los diferenciales de las funciones coordenadas tienen la propiedad:

$ braket((dif x^i)_p ,  X_p) = X_p x^i = X^i $
donde $X^i$ son las componentes del _vector tangente_ $X_p = X^i (partial_(x^i))_p$. Aplicando $(dif x^i)_p$ sobre la base de vectores tangentes tenemos: 

$ braket((dif x^i)_p ,  (partial_(x^j))_p) = evaluated(pdv(, x^i))_p x^i = evaluated(pdv(x^i , x^j))_(phi(p)) = delta^i_j $

Por tanto las funciones lineales $(dif x^1)_p,(dif x^2)_p,...,(dif x^n)_p$ que son una _base dual_, abarcando el espacio contangente, y todo covector en $p$ tiene una expansión única

$ omega_p = w_i (dif x^i)_p quad "donde" quad w_i = braket(omega_p , (partial_(x^i))_p) $

donde $w_i$ son los llamados *componentes* del funcional lineal $omega_p$ en la carta $(U;x^i)$. El diferencial de cada función en $p$ tiene la expansión de coordenadas: 

$ (dif f)_p = f_i(dif x^i)_p $

donde 

$ f_i = braket((dif f)_p , (partial_(x^i))_p ) = evaluated(pdv(,x^i))_p f = evaluated(pdv(hat(f),x^i))_(phi(p)) $

La forma de escribir esto es a través de la _regla de la cadena_: 

$ (dif f)_p = f_(i) (p) (dif x^i)_p $
donde 

$ f_(i) = pdv(hat(f),x^i) compose phi $ 

Estas componentes se llaman el *gradiente* de la función del $p$. Los diferenciales nunca han encontrado un punto correcto o cómodo en el dado que son "cantidades arbitrariamente pequeñas que no se anulan". El concepto de diferenciales como funciones lineales evitan estors problemas, ya que poseen todas sus características (regla de la cadena, de Leibnitz...). 

#v(1em)

Un *tensor de tipo* $(r,s)$ en $p$ es un funcional multilineal 

$ A_p : underbrace(T_p^*(M) times T_p^*(M) times dots times T_p^*(M),r)underbrace(times T_p(M) times dots times T_p(M),s) arrow RR $ 

Denotamos el espacio tensorial de tipo $(r,s)$ en $p$ por $T_p^((r,s)) (M)$. Es un esacpio vecotrial de dimensión $n^(r+s)$.

=== Campos vectoriales y tensoriales

#definition(name:"Campo Vectorial")[
Un *campo vectorial* $X$ es la asignación de un vector tangencial $X_p$ en cada punto $p in M$. En otras palabras, $X$ es un mapa $X: M arrow union_(p in M) T_p (M)$, con la propiedad de que la imagen de cada punto, $X(p)$, pertenece al espacio tangente $T_p(M)$ en $p$. ]

Podemos escribir $X_p$ en vez de $X(p)$: son intercambiables. Un campo vectorial se dice *diferenciable* o *suave* si para cada función diferenciable $f in Fcal (M)$ la función $X f$ definida por 

$ (X f) (p) = X_p f $
es diferenciable, $X f in Fcal (M)$. El conjunto de campos vectoriales en $M$ se denota por $Tcal (M)$.

#v(1em)

Cada campo vectorial suave define un mapa $X: Fcal (M) arrow Fcal (M)$ que es lineal: 

$ X (a f + b g ) = a X f + b X g quad "para todo" quad f,g in Fcal (M) quad "y todo" quad a,b in RR $
y satisface la regla de Leibnitz de los productos: 

$ F(f g) = f X g + g X f $
Así pues, cualquier mapa $X$ con estas propiedades definen un campo vectorial suave, dado qeu para cada punto $p$ en el mapa $X_p:Fcal_p (m) arrow Fcal_p (M)$ definido por $X_p f = (X f)(p)$ satisface @Ec:01.condicion_linealidad, @Ec:01.condicion_leibnitz. 

#v(1em)

También podemos definir los campos vectoriales en un conjunto abierto $U$ de una manera similar a como se hace con un vector tangente en cada punto $U$, tal qeu $X f in Fcal (U)$ para todo $f in Fcal (U)$. Definimos como *base local de campos vectoriales* en $p$, siendo $U$ el vecindario de $p$, como un conjunto de  vectores ${e_1,e_2,..., e_n}$ en $U$ tal que los vectores tangentes $(e_i)_q$ abarcan todo el espacio tangente $T_q(M)$ en cada punto $q in U$. Para una carta $(U,phi;x^i)$ defininmos los campos vectoriales en el dominio $U$ 

$ partial_(x^i) equiv pdv(,x^i): Fcal (U) arrow Fcal (U) $

como

$ partial_(x^i) = pdv(,x^i) f = pdv(f compose phi^-1, x^i) $

Estos campos vectoriales asignan la base de tangentes vectoriales $(partial_(x^i))_p$ a cada punto $p in U$, y forman una base local de campos vectoriales en cada punto de $U$. Cuando es restringido al dominio $U$, cada campo vectorial $X$ en $M$ tiene una expansión única en términos de estos campos vectoriales: 


$ evaluated(X)_(U) = X^i pdv( , x^i) = X^i partial_(x^i) $

donde los componentes $X^i:U in RR$ son funcioens diferenciables en $U$. El campo vectorial local $partial_(x^i)$ forman una base modular en $U$, pero no son una base vectorial dado un espacio vecotiral $Tcal (U)$ es la suma de espacios tangentes en todos los puntos $p in U$, es tiene dimensión infinita. 

#v(1em)

De una manera similar, podemos definir un *campo convectorial* o una *1-forma diferencial* $omega$, como la relación de un covector $omega_p$ en cada punto $p in M$, dado que la función $braket(omega,X)$ definido por $braket(omega,X)(p) = braket(omega_p,X_p)$ es diferenciable para cada campo vectorial suave $X$. El espacio de 1-forma será denotado como $Tcal^* (M)$. Dado una función suave $f$, sea $dif f$ la 1-forma diferenciable definido la asignación de una $dif f_p$ a cada punto $p$, dado 

$ braket(dif f, X) = X f quad "para todo" quad X in Tcal(M) $

nos referimos a este campo covector como el *diferencial* de $f$. Una base local en una carta cualquiera $(U,phi;x^i)$ consiste en 1-formas $dif x^i$, que tienen la propiedad


$ braket(dif x^i, partial_(x^j)) = pdv(x^i,x^j) = delta^(i)_j $

Cada diferencial puede ser expandido localmente por la regla de la cadena

$ dif f = f_i dif x^i quad "donde" quad f_i = pdv(,x^i)f $


=== Cambios de coordenadas

Sea $(U,phi;x^i)$ y $(U',phi';x^(prime j))$ dos cartas de coordenadas. Por pura regla de la cadena, podemos deducir que

$ pdv(,x^(prime j)) = pdv(x^i,x^(prime j)) pdv(,x^i) quad pdv(,x^i) = pdv(x^(prime j),x^i) pdv(,x^(prime j)) $

Substituyendo esto en la expresión de un vector tangente con respecto a otras baes: 

$ X = X^i pdv(,x^i) = X^(prime j) pdv(,x^(prime j)) $

La regla de la cadena escrita en coordenadas $x^(prime j)$ y eligiendo $f = x^i$, nos da

$ dif x^i = pdv(x^i,x^(prime j)) dif x^(prime j) $

Expresando esto en función de la 1-forma $omega$ en ambas bases de coordenadas tenemos 

$ omega = w_i dif x^i = w_j' dif x^(prime j) $

u podemos obtener la _transformación covariante_ de compoenntes: 

$ w^(prime)_j = pdv(x^i,x^(prime j)) w_i $

Podemos escribir: 

$ A_i^j = pdv(x^(prime j),x^(i)) quad A_k^(prime i) = pdv(x^i,x^(prime j)) $

Y la transofmración para tensores: 

$ tensor(T,+prime i'_1 ... i'_r,-j'_1...j'_s) =  tensor(T,+ i_1 ... i_r,- j_1...j_s)  pdv(x^(prime i'_1),x^(i_1)) dots pdv(x^(prime i'_r),x^(i_r))  pdv(x^(j_1),x^(prime j'_1)) dots  pdv(x^(j_s),x^(prime j'_s)) $

=== Fibrados Tensoriales

#definition(name:"Fibrado Tangente")[
  El *fibrado tangnte* $T M$ en una variedad $M$ consiste en el conjunto de uniones teóricas de espacios tangentes en todos los puntos: 

  $ T M = union_(p in M) T_p (M) $
]

Existe lo que llamamos un *mapa de proyección* $pi: T M  arrow M$, definido por $pi(u) = p$ si $u in T_p (M)$, y para cada carta $(U,phi;x^i)$ en $M$ podemos definir la carta $(pi^(-1)(U), tilde(phi))$ en $T M$ donde el mapa de coordenadas $tilde(phi): pi^(-1) (U) arrow RR^(2n)$ es definido por 

$ tilde(phi)(v) = (x^1(p),...,x^n(p),v^1,...,v^n) quad "donde" quad p = pi(v) quad "y" quad v = sum^n_(i=1) v^i evaluated(pdv(,x^i))_(p) $ 

La topología en $T M$ es tomado como la topología más tosca dado qeu todos los sets $tilde(phi)^(-1)(A)$ son abiertos cuadno $A$ es un abierto del conjunto $RR^(2n)$.

#v(1em)

Dado un conjunto abierto $U subset.eq M$, es un mapa suave $X:U arrow T M$ es dicho para un *campo vetorial suave en* $U$ si $pi compose X = "id"|_U$. Esto está en concordancia con nuetra noción de asingar un vector tangencial en el espacio tangente $T_p(M)$ en el punto $p in U$. Una idea similar peude ser usada para crear un *campo vectorial suave a lo largo de la curva parametrizada* $gamma: (a,b) arrow M$, defninido por la curva suave $X:(a,b) arrow T M$ que  deja $gamma$ al fibrado tensorial $pi compose X = gamma$. Esencialmente, esto define un vector tangente en cada punto de la curva, no necesariamente tagente a la curva, de una manera diferencial. 

#v(1em)

El *fibrado contagencial* $T^* M$ se define de manera análoga, como la unión de todos los espacios cotangentes $T_p^* (M)$ en todos los puntos $p in M$. La generació nde cartas tiene la forma $(pi^(-1)(U),tilde(phi))$ en $T^* M$ donde el mapa de coordenadas $tilde(phi): pi^(-1)(U) arrow RR^(2n)$ está definidocomo: 

$ tilde(phi)(omega_p) = (x^1(p),...,x^n(p),w^1,...,w^n) quad "donde" quad p = pi(v) quad "y" quad omega = sum^n_(i=1) w^i evaluated(pdv(,x^i))_(p) $ 


tal que $T^* M$ va hacia una variedad 2n dimensional. Este proceso peude extenderse a fibrados tensoriales del tipo $T^((r,s)) M$, que irían hacia variedades $n+n^(r+s)$ dimensionales. 

== Mapa tangente y subvariedades 
=== Mapa tangente y pullback
=== Subvariedades

== Conmutadores, corrientes y derivadas de Lie
=== Conmutadores 
=== Derivada de Lie

== Distribución y Teorema de Frobenius
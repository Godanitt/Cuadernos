#import "../../../plantilla.typ": *

== Ejercicios

//==================================
// -- EJERCICIO 1 -----------------
//==================================

#exercise()[
  Construir la tabla de multiplicación del grupo diédrico $D_3$ o grupo de simetrías del triángulo equilátero.
]

El grupo $D_3$ está formado por 

$ D_3 = {e,c,c^2,x,y,z} $

La tabla de multiplicación es: 

#align(center)[
#table(
  columns: 7,
  align: center,
  stroke: (x, y) => {
  (
    right: if x == 0 { 0.8pt } else { none },
    bottom: if y == 0 { 0.8pt } else { none },
  )
  },


  [],  $e$, $c^1$, $c^2$, $x$, $y$, $z$,
  $e$,  $e$, $c^1$,$c^2$, $x$, $y$, $z$,
  $c^1$, $c^1$, $c^2$, $e$, $y$, $z$, $x$,
  $c^2$, $c^2$, $e$, $c_1$, $z$, $x$, $y$, 
  $x$,  $x$, $z$, $y$, $e$, $c_2$, $c_1$,
  $y$,  $y$, $x$, $z$, $c_1$, $e$, $c_2$,
  $z$,  $z$, $y$, $x$, $c_2$, $c_1$, $e$,
)
]
donde hemos supusto que multiplica por la izquierda primero, así pues 

#align(center)[
  #table(
    columns: 2,
    align: center,
    stroke: (x, y) => {
    (
      right: if x == 0 { 0.8pt } else { none },
      bottom: if y == 0 { 0.8pt } else { none },
    )
    },


    [],   $b$,
    $a$,  $a b$, 
  )
]

//==================================
// -- EJERCICIO 2 -----------------
//==================================

#exercise()[
  Haciendo uso de la notación mediante ciclos, constrúyase la tabla de multiplicación del grupo simétrico $S_3$. Compárese esta tabla con la obtenida para el grupo diérico $D_3$ y estúdiese si estos grupos son isomorfos.
]

El grupo simétrico $S_3$ está formado por 

$ S_3 = {(), (12), (23), (31), (123), (132)} $

tal que la tabla de multiplicación es: 

#align(center)[
#table(
  columns: 7,
  align: center,
  stroke: (x, y) => {
  (
    right: if x == 0 { 0.8pt } else { none },
    bottom: if y == 0 { 0.8pt } else { none },
  )
  },


  [],      $()$, $(12)$, $(23)$, $(31)$, $(123)$, $(132)$,
  $()$,    $()$, $(12)$, $(23)$, $(31)$, $(123)$, $(132)$, 
  $(12)$,  $(12)$, $()$, $(132)$, $(123)$, $(31)$, $(23)$,
  $(23)$,  $(23)$, $(123)$, $()$, $(132)$, $(12)$, $(31)$, 
  $(31)$,  $(31)$, $(132)$, $(123)$, $()$, $(23)$, $(12)$,
  $(123)$, $(123)$, $(23)$, $(31)$, $(12)$, $(132)$, $()$,
  $(132)$, $(132)$, $(31)$, $(12)$, $(23)$, $()$, $(123)$,
)
]

Si comparámos esta tabla con $D_3$ encontramos la relación $f:D_3 arrow S_3$ tal que:

$ e arrow () quad x arrow (12) quad y arrow (23) quad z arrow (31) quad c arrow (123) quad c^2 arrow (132) $

vemos que se preserva tanto la tabla de multiplicación, lo que implica qeu es un homomorfismo. Además, dado que $f(e) = ()$ es inyectivo (i.e. $"ker(f)=e"$), y como $"Im"(f)=S_3$, también es sobreyectivo. Por ser homomorfismo y biyectivo, $D_3$ y $S_3$ son isomorfos. 

//==================================
// -- EJERCICIO 3 -------------------
//==================================


#exercise()[
  Demúestre que las clases de conjugación del grupo simétrico $S_n$ están formadas por los elementos de $S_n$ que en la notación de ciclos tiene la misma estructura.    
]

Las clases de conjugación son el conjunto de elementos con la relación de conjugación. Decimos que $g_1$ y $g_2$ son _conjugados_ si 

$ g_1 = g g_2 g^(-1) quad  "para algún" quad g in S_n $

Es trivial que para un grupo abeliano cada elemento es su propia clase de conjugación. Sin embargo estamos ante un grupo no abeliano, por lo que no es trivial. 

#v(1em)

Definimos longitud $lambda$ como el número de elementos de $h=(h_1,...,h_lambda)$. Queremos demostrar que $g_1$ y $g_2$ tienen la misma longitud. Supongamos que $g_1$ y $g_2$ tal que $g_2 = g g$ Sea $g$:

$ g = (a_1,a_2,...,a_k) =(a_1 a_2)(a_2 a_3) ...(a_(k-1) a_k) (a_k a_1) $

por otro lado

$ g^(-1) = (a_1 a_k)(a_k a_(k-1)) ... (a_2 a_1) $

es decir, tenemos la misma longitud tanto en $g$ como en $g^(-1)$.  Por otro lado, si descomponemos $g_1$ a la vez: 

$ g_1 = (b_1 b_2)...(b_(r-1) b_r) $
donde $b_i eq.not b_j$ si $i eq.not j$, ($i,j = 1,2,...r$), por que si fuera así, podríamos expresar $g_1$ con $r-1$ términos. Vemos claramente que podemos hacer 

$ g_1 = (b_1 b_2)g^(-1) g (b_2 b_3) g^(-1) g ... g^(-1) g(b_(r-1)b_r) $

dado qeu $g^(-1) g = e$. De esto se deduce que 

$ g_2 = g(b_1 b_2)g^(-1) g(b_2 b_3) g^(-1) ...  g (b_(r-1)b_r)g^(-1) $

Lo siguiente que tenemos que hacer es demostrar que $g(b_i b_j)g^(-1)$ tiene longitud 2 consideremos dos casos
- Pongamos que $(b_i b_j)$ no conicide con ningún $a_i in g$. Entonces es disjunto de $g$, lo que implica que podemos hacer $g (b_i b_j) =(b_i b_j) g$ de lo que se deduce que $g(b_i b_j)g^(-1) = (b_i b_j)$ y por tanto que tiene longitud 2. 
- Otro caso es aquel en el que solo uno de los elementos $(b_i,b_j)$ sí coincide con algún $a_i in g$ (por ejemplo $b_i = a_i$, sin pérdida de generalidad) Dado que podemos hacer rotaciones cíclicas en $g$, siempre podremos expresar $g(b_i b_j)g^(-1)$ como $ (a_i a_(i+1))(b_i b_j)(a_(i+1)a_i) =(a_i a_(i+1))(a_i b_j)(a_(i+1)a_i)  = (a_i a_(i+1) a_i b_j a_(i+1))=(b_j a_(i+1))$ que también tiene longitud 2. 
- Si $(b_i,b_j)$ coindice con un par de $g$, $(b_i,b_j) = (a_i,a_(i+1))$, es evidente que $g (b_i b_j) g^(-1) = (b_i b_j)$ por la misma razón. 

Al no coincidir $b_i eq.not b_j$ si $i eq.not j$, se verifica que 

$ g(b_1 b_2)g^(-1) g(b_2 b_3) g^(-1) ...  g (b_(r-1)b_r)g^(-1) $
se puede expresar con longitud $r$, demostrando que $g_2$ y $g_1$ tienen la misma estructura (longitud). La razón por la que es indispensable $b_i eq.not b_j$ si $i eq.not j$ es obvia: $a_(i+1)$ puede coincidir con un $b_k$ cualquiera, lo que haría que $g(b_k b_(k+1))g^(-1)=a_(i+2)b_k$, haciendo que el $a_(i+1)$ que aparecería antes volviese a ser único. Podríamos hacer esto recurrisivamente, pero siempre va a pasar que el $a_(i+1)$ se enontrará solo (dado que estamos denotando índices, _todo mantiene la máxima generalidad_). Si ocurriera que $b_i = b_j$ si $i eq.not j$, entonces aparecerían 2 $a_(i+1)$, lo que implicaría que se podría expresar con $r-1$. 

#v(1em)

Sin embargo como hemos impuesto que esto no pasa, hemos demostrado el enunciado, probablemente de la forma más tosca, bruta y fea posible, pero lo hemos hecho. 


//==================================
// -- EJERCICIO 4 -----------------
//==================================

#exercise()[
  Considérese el grupo formado por tres elementos $A,B$ y $C$ satisfaciendo las relaciones $A^p = B^q = C^r = 1$ con $p,q,r in Z^+$. Si $p=3$, $q=2$ y $r=2$, se tiene un grupo isomorfo al grupo diédrico $D_3$.   
]

A primera vista parece que nuestro grupo tiene ciertas similitudes con un _grupo cíclico_. La pregunta es, ¿cuales son los elementos del grupo? Primero tenemos que descartar algunos. Es evidente que los elementos inversos de $B$ y $C$ son ellos mismos $B B= C C = e$. Por otro el elemebnto inverso de $A$ es $A^2$ ya que $A A^2 = e$. 

#v(1em)
#v(1em)

Luego tenemos la relación $A B C = e$, con el que podemos obtener algunas relaciones más. (132) 

$ A B C = e arrow A B C C^(-1)= C^(-1) arrow A B = C  $

El hecho de que $C = A B$ nos elimina todas los elementos con $C$ al ser redundantes. Como solo tenemos esta "ligadura", no podemos deducir más términos, por lo que $G$ estará compuesto de $e,A,A^2,B$ y sus términos cruzados: 

$ G = {e,A,A^2,B,B A,B A^2, A B, A^2 B} $ 

Por definición $A B$ será el inverso de $B A^2$, y $A^2 B$ será el inverso de $B A$. 

$ A B C = e arrow A B (A B)= e arrow A B A = B arrow A B = B A^2 $

de lo que se deduce que $B A$ y $B A^2$ son mutuamente inversos. En conclusión, el $G$ que pusimos antes _no es correcto_, por lo que 

$ G = {e,A,A^2,B,B A,B A^2} $ 

Y esto si se puede relacionar con $D_3$, ya que la tabla de multiplicación: 

#align(center)[
#table(
  columns: 7,
  align: center,
  stroke: (x, y) => {
    (
      right: if x == 0 { 0.8pt } else { none },
      bottom: if y == 0 { 0.8pt } else { none },
    )
  },

  [],    $e$,  $A$,  $A^2$,  $B$,   $B A$,   $B A^2$,
  $e$,   $e$,  $A$,  $A^2$,  $B$,   $B A$,   $B A^2$,
  $A$,   $A$,  $A^2$, $e$,   $B A^2$, $B$,   $B A$,
  $A^2$, $A^2$, $e$,  $A$,   $B A$,   $B A^2$, $B$,
  $B$,   $B$,  $B A$, $B A^2$, $e$,    $A$,    $A^2$,
  $B A$,  $B A$, $B$,  $A$,    $A^2$,  $e$,    $A$,
  $B A^2$,$B A^2$,$A^2$,$B$,   $A$,    $A^2$,  $e$,
)
]
la cual es mucho más sencilla de calcular que $D_3$ o $S_3$. Si comparamos las tablas de multiplicar se ve la siguiente aplicación 

$ f:D_3 arrow G quad quad  e arrow e quad x arrow B quad y arrow B A quad z arrow B A^2  quad c arrow A A quad c^2 arrow A^2 $
que se ve, por preservar la tabla de multiplicación, por el kernel y por la imagén, que es biyectiva. 

//==================================
// -- EJERCICIO 5 -------------------
//==================================

#exercise()[
  Determinar todos los subgrupos del grupo diédrico $D_3$. Estudiar cuales son subgrupos invariantes y para cada ellos construir un espacio de cosets. 
]

El grupo diédrico $D_3$ tiene la siguiente tabla de multiplicar: 

#align(center)[
#table(
  columns: 7,
  align: center,
  stroke: (x, y) => {
  (
    right: if x == 0 { 0.8pt } else { none },
    bottom: if y == 0 { 0.8pt } else { none },
  )
  },


  [],  $e$, $c^1$, $c^2$, $x$, $y$, $z$,
  $e$,  $e$, $c^1$,$c^2$, $x$, $y$, $z$,
  $c^1$, $c^1$, $c^2$, $e$, $y$, $z$, $x$,
  $c^2$, $c^2$, $e$, $c_1$, $z$, $x$, $y$, 
  $x$,  $x$, $z$, $y$, $e$, $c_2$, $c_1$,
  $y$,  $y$, $x$, $z$, $c_1$, $e$, $c_2$,
  $z$,  $z$, $y$, $x$, $c_2$, $c_1$, $e$,
)
]

de lo que se pueden deducir los 6 subgrupos son: 

$ H_1 = {e}, quad H_2 = {e,c,c^2} quad H_3 = D_3 $
$ H_4 = {e,x}, quad H_5 = {e,y} quad H_6 = {e,z} $

Mirando la tabla de multiplicar se deduce que sus coindiciones de cerrados. Además verifican el inverso, asociatividad y neutro, aunque estas 3 son propiedades heredadas. Expresemos $D_3$ en su forma canónica: 

$ D_3 = {e,c,c^2,x,x c,x c^2}  $ 

Por otro lado, nos piden el espacio de cosets para $D_3/H$ siendo $H$ los subgrupos. Supongamos un elemento $g in G$. El _conjunto de elementos *coset*_ $g H$ es: 

$ g H = {g h_1, g_h_2,...} $
Definimos el *espacio de cosets* $G/H$ como el conjunto de conjutos coset, es decir:

$ G/H = {g_1 H, g_2 H...} = { {g_1 h_1, g_1 h_2...},{g_2 h_1, g_2 h_2...}...} $
Así pues los espacios de cosets para cada subgrupo: 

- Sea $H={e}$. Entonces:
  $ D_3 / H  = {{e},{c},{c^2},{x},{x c},{x c^2}}$
  que se ded
- Sea $H={e,c,c^2}$. Entonces:
  $ D_3 / H  = {{e,c,c^2},{x,c,c^2}$
- Sea $H={e,x}$. Entonces:
  $ D_3 / H  = {{e,x},{c,x c}, {x,c^2}}$
- Sea $H={e,x c}$. Entonces:
  $ D_3 / H  = {{e,x c},{c,x c^2}, {c^2,x}}$
- Sea $H={e,x c^2}$. Entonces:
  $ D_3 / H  = {{e,x c^2},{c,x}, {c^2,x c}}$
- Sea $H={D_3}$. Entonces:
  $ D_3 / H  = {D_3}$

//==================================
// -- EJERCICIO 6 -----------------
//==================================

#exercise()[
  Constrúyase una representación bidimensional del grupo diédrico $D_3$ estudiando su acción en el espacio bidimensional $RR^2$. Estúdiese si se trata de una representación irreducible.
]

La representación bidimensional es relativamente trivial, ya que solo hay que considerar que significan las rotaciones. Dado que $D_3$ es el  grupo de transformaciones de un polígono regular con $n$ lados no direccionado, podemos ver que a cada elemento de 

$ D_3 = {e,c,c^2,x,y,z} $
podemos asignarle una rotación en 2D. Si definimos los ejes de simetría del triángulo: 



#let L = 120pt
#let h = L * calc.sqrt(3) / 2
#let theta = 60deg
#let p = (2, 0)
#let l = 0.3   // longitud de los ejes (pequeñitos)

#align(center)[
#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  polygon(
    (0, 0),3,
    stroke: 3pt,
    fill: none,
    angle: 90deg,
    )
  content((0, 1.2), [x], anchor: "north")
  content((-calc.cos(theta/2)-0.2, -calc.sin(theta/2)), [y], anchor: "east")
  content(( calc.cos(theta/2)+0.2, -calc.sin(theta/2)), [z], anchor: "west")

  content((0.1, -0.8), [$S_x$], anchor: "west")
  content((calc.cos(theta/2)-0.2, calc.sin(theta/2)), [$S_y$], anchor: "east")
  content(( -calc.cos(theta/2)+0.2, calc.sin(theta/2)), [$S_z$], anchor: "west")

  line((0,1)
      ,(0,-1))

  line((-calc.cos(theta/2),-calc.sin(theta/2))
      ,(calc.cos(theta/2),calc.sin(theta/2)))

  line((calc.cos(theta/2),-calc.sin(theta/2))
      ,(-calc.cos(theta/2),calc.sin(theta/2)))

  bezier(
      (0.6, 0.7),   // inicio
      (0.9, 0.25),   // fin
      (1.5, 1),   // control 1
      stroke: (
        thickness: 1pt,
        cap: "round",
      ),
      mark: (
        begin: ">",
        end: ">",
      )
  )
  
  content((calc.cos(theta/2)+0.4, calc.sin(theta/2)), [Cambio de simetría y], anchor: "west")

    // eje x
    line(
      (2, -0.8),
      (2.6, -0.8),
      stroke: (thickness: 1.2pt),
      mark: (end: ">"),
    )
    content((2.35, -0.9), [$x$], anchor: "west")

    // eje y
    line(
      (2, -0.8),
      (2, -0.2),
      stroke: (thickness: 1.2pt),
      mark: (end: ">"),
    )
    content((1.9, -0.6), [$y$], anchor: "south")
})
] 

En la imagen de arriba, con un ejemplo del cambio de simetría por $x,y,z$, queda claro que es cada cosa. Por ejemplo $c$ sería una rotación de 120º, mientras que $c^2$ de 240º. Por otro lado, $x$ representa una rotacion donde se conserva el vector (0,1), $y$ donde se conserva el vector $(cos 30, sin 30)$ y $z$ donde se conserva el vector $(-cos 30, sin 30)$. Sin embargo, como en realidad $y=x c$ y $z = x c^2$, y dado que una _representación debe conservar la estructura de grupo_, podemos calcualr las representaciones de $c^2,y,z$ a partir de $x,c$. Aśi pues, tenemos por un lado que 

$ e = mat(1,0;0,1) quad quad c = mat(cos(120), -sin(120); sin(120), cos(120)) = mat(-1/2,- sqrt(3)/2;sqrt(3)/2,-1/2) quad quad x = mat(-1,0;0,1) $

donde $x$ es el cambio de $x arrow -x$, de forma trivial tenemos: 

$ c^2 = mat(-1/2,sqrt(3)/2;-sqrt(3)/2,-1/2) quad quad  
  y = x c = mat(1/2,sqrt(3)/2;sqrt(3)/2,-1/2)  quad quad
  z = x c^2 = mat(1/2,-sqrt(3)/2;-sqrt(3)/2,-1/2)   $ 

Ahora tenemos que esutidar si se trata de una representación irreducible. La forma en la que yo veo que se trata de un grupo irreducible es la siguiente.

#v(1em)

Supongamos que la representación $D$ fuese reducible. Entonces el espacio vectorial $V = RR^2$ se descompondría como suma directa de dos subespacios invariantes unidimensionales,

$ V = V_1 oplus V_2 $.

En tal caso, la representación $D$ sería equivalente a la suma directa de dos representaciones unidimensionales de $D_3$. Sin embargo, las únicas representaciones unidimensionales de $D_3$ son la trivial y la del signo, por lo que para todo $g in D_3$ las matrices $D(g)$ tendrían únicamente autovalores  reales $plus.minus 1$.

#v(1em)

Consideremos ahora el elemento $c in D_3$ correspondiente a la rotación de ángulo $2 pi / 3$. En la representación construida, $D(c)$ es una rotación de $RR^2$ de ángulo $2 pi / 3$, cuyos autovalores son $e^(plus.minus 2 pi i / 3)$, que no son reales.

#v(1em)

Esto contradice la posibilidad de que $D$ sea suma directa de representaciones unidimensionales. Por tanto, la representación $D$ es irreducible.


//==================================
// -- EJERCICIO 7 -----------------
//==================================

#exercise()[
  Descompóngase la representación natural de dimensión tres de $S_3$ en términos de sus representaciones irreducibles.
]

Podemos aplicar algunos teoremas para hallar las dimensiones que necesitamos. El primer teorema es aquel que nos dice que _el número de representacioens irreducibles no equivalente de un grupo finito G es igual al número de clases de conjugación_. Dado que $S_3$ tiene 3 clases de conjugación, el número máximo de representaciones irreducibles es 3.

#v(1em)

Otro teorema nos dice que _la suma de cuadrados de las dimensiones de las representaciones irreducibles no equivalentes de un gurpo finito $G$ es igual al orden del grupo_. Es decir, $sum_i ("dim"(D_i))^2 = 6$, lo que nos dice que 1 representación tiene dimensión 2, y hay otras 2 representaciones con dimensión 1. 

#v(1em)

Sabemos que la representación natural $3 times 3$ viene dada por 

$ D(()) = mat(1,0,0;0,1,0;0,0,1) quad  
  D((12)) = mat(0,1,0;1,0,0;0,0,1) quad  
  D((123)) = mat(0,1,0;0,0,1;1,0,0)  $

$ D((23)) = mat(1,0,0;0,0,1;0,1,0) quad 
  D((13)) = mat(0,0,1;0,1,0;1,0,0) quad 
  D((132)) = mat(0,0,1;1,0,0;0,1,0) $

Esta representación natural en $3 times 3$. Lógicamente la representación irreducible hará que $D(g)=A_(1 times 1) oplus B_(2 times 2)$, por lo dicho. 

#v(1em)
 Lo primero es que, si nos fijamos, la representación natural $3 times 3$ deja invariante al vector $un_1 prop (1,1,1)$. Algebráicamente está claro, solo hay que hacer la cuenta. Sin embargo, también tiene sentido desde el punto de vista del signficado de $S_3$. Dado que esta es la matriz de permutaciones, un vector que tenga todos sus componentes iguales, es invariante frente a cualquier cambio de componentes.

#v(1em)

Algunas preguntas claves que nos hacemos aquí es ¿qué hacemos con esta invariancia?¿cómo relacionamos que $un_1$ sea invariante con $A_(1 times 1)$ y $B_(2 times 2)$? Puede que la respuesta no sea tan obvia, pero la clave está en pensar que si expresaramos las matrices en función de una base con $un_1$, todos los elementos $D(g)_(11)=1$, ya que si $D(g)_(11)eq.not 1$ no se respetaría la invariancia de $un_1$ (siendo aquí $D_(11)$ el elemento de la matriz D en la fila 1 columna 1, y siendo $g in S_3$). Es decir, un cambio de base a $en_1 arrow un_1$ hará que $A_(1 times 1) = 1$.


#v(1em)

Dado que la matriz de cambio de base siempre se puede representar como 

$ Lambda =  mat(un_1, un_2, un_3) $ 

y por ser una matriz cambio de base tiene varias propiedades. La primera: que es especial (determinante 1) y que es unitaria, y por tanto

$ Lambda^(-1) = Lambda^dagger  = mat(un_1^*;un_2^*; un_3^*)  $
que al verificar $Lambda^-1 Lambda = II$, nos lleva a las relacioens: 

$ un_1^* dot un_1 = 1, quad un_2^* dot un_2 = 1, quad
un_3^* dot un_3 = 1 $
$ un_1^* dot un_2 = 0, quad un_1^* dot un_3 = 0, quad
un_2^* dot un_3 = 0 $
Donde literalmente hemos reducido un problema de resolver 6 parámetros a 5 ecuaciones prácticamente triviales, que se puede resolver de memoria. Veamos que una solución es, considerando que $un_1 prop (1,1,1)$: 

$ un_1 = 1/(sqrt(3)) mat(1,1,1) quad
  un_2 = 1/(sqrt(2)) mat(1,-1,0)
  un_3 = 1/(sqrt(2)) mat(1,1,-2) $

Por lo que la matriz cambio de base será: 

$ Lambda =
mat(
  1/sqrt(3),  1/sqrt(2),  1/sqrt(6);
  1/sqrt(3), -1/sqrt(2),  1/sqrt(6);
  1/sqrt(3),          0, -2/sqrt(6)
) quad quad   Lambda^(-1) = Lambda^T =
mat(
  1/sqrt(3),  1/sqrt(3),  1/sqrt(3);
  1/sqrt(2), -1/sqrt(2),          0;
  1/sqrt(6),  1/sqrt(6), -2/sqrt(6)
) $
 
Y por tanto el elemento $D_("irreducible")(g) equiv D'(g)$ se calculará a partir de $D(g)$ como

$ D'(g) = Lambda^(-1) D(g) Lambda $

Por lo que, para obtener las nuevas matrices en su representación irreducible, solo tenemos que hacer los siguientes cálculos. Veamos que 


$ D'(()) = Lambda^(-1) D(()) Lambda = mat(1,0,0;0,1,0;0,0,1) = 1 oplus mat(1,0;0,1) $
Veamos el cálculo de uno no trivial: 
$ D((12)) Lambda
= mat(0,1,0; 1,0,0; 0,0,1)
  mat(
    1/sqrt(3),  1/sqrt(2),  1/sqrt(6);
    1/sqrt(3), -1/sqrt(2),  1/sqrt(6);
    1/sqrt(3),    0, -2/sqrt(6)
  )
=
mat(
  1/sqrt(3), -1/sqrt(2),  1/sqrt(6);
  1/sqrt(3),  1/sqrt(2),  1/sqrt(6);
  1/sqrt(3),     0, -2/sqrt(6)
) $.
$ D'((12)) = Lambda^(-1) D((12)) Lambda
= mat(
    1/sqrt(3),  1/sqrt(3),  1/sqrt(3);
    1/sqrt(2), -1/sqrt(2),          0;
    1/sqrt(6),  1/sqrt(6), -2/sqrt(6)
  )
  mat(
    1/sqrt(3), -1/sqrt(2),  1/sqrt(6);
    1/sqrt(3),  1/sqrt(2),  1/sqrt(6);
    1/sqrt(3),          0, -2/sqrt(6)
  )
=
mat(
  1, 0, 0;
  0,-1, 0;
  0, 0, 1
)
$
De lo que obtenemos: 

$ D'(()) =mat(1,0,0;0,1,0;0,0,1) = 1 oplus mat(1,0;0,1) $$
D'((12)) =
mat(
  1, 0, 0;
  0, -1, 0;
  0,  0, 1
)
= 1 oplus mat(-1,0;0,1) 
$
$ D'((23)) =
mat(
  1, 0, 0;
  0,  1/2,  sqrt(3)/2;
  0,  sqrt(3)/2, -1/2
) =  1 oplus mat(1/2, sqrt(3)/2; sqrt(3)/2, -1/2)  
$ 

$ D'((13)) =
mat(
  1, 0, 0;
  0,  1/2, -sqrt(3)/2;
  0, -sqrt(3)/2, -1/2
)
= 1 oplus mat(1/2, -sqrt(3)/2; -sqrt(3)/2, -1/2) $

$ D'((123)) =
mat(
  1, 0, 0;
  0, -1/2, -sqrt(3)/2;
  0,  sqrt(3)/2, -1/2
)
= 1 oplus mat(-1/2, -sqrt(3)/2; sqrt(3)/2, -1/2) $ 
$
D'((132)) =
mat(
  1, 0, 0;
  0, -1/2,  sqrt(3)/2;
  0, -sqrt(3)/2, -1/2
)
= 1 oplus mat(-1/2, sqrt(3)/2; -sqrt(3)/2, -1/2) $


Por lo que hemos representado $D(g)=A_(1 times 1) oplus B_(2 times 2)$, que es lo que queríamos (representación irreducible), siendo en particular $A_(1 times 1) = 1$ tal y como se habí
$ D'(()) =mat(1,0,0;0,1,0;0,0,1) = 1 oplus mat(1,0;0,1) $$
D'((12)) =
mat(
  1, 0, 0;
  0, -1, 0;
  0,  0, 1
)
= 1 oplus mat(-1,0;0,1) 
$
$ D'((23)) =
mat(
  1, 0, 0;
  0,  1/2,  sqrt(3)/2;
  0,  sqrt(3)/2, -1/2
) =  1 oplus mat(1/2, sqrt(3)/2; sqrt(3)/2, -1/2)  
$ 

$ D'((13)) =
mat(
  1, 0, 0;
  0,  1/2, -sqrt(3)/2;
  0, -sqrt(3)/2, -1/2
)
= 1 oplus mat(1/2, -sqrt(3)/2; -sqrt(3)/2, -1/2) $

$ D'((123)) =
mat(
  1, 0, 0;
  0, -1/2, -sqrt(3)/2;
  0,  sqrt(3)/2, -1/2
)
= 1 oplus mat(-1/2, -sqrt(3)/2; sqrt(3)/2, -1/2) $ 
$
D'((132)) =
mat(
  1, 0, 0;
  0, -1/2,  sqrt(3)/2;
  0, -sqrt(3)/2, -1/2
)
= 1 oplus mat(-1/2, sqrt(3)/2; -sqrt(3)/2, -1/2) $
a demostrado naifmente antes.

//==================== ==============
// -- EJERCICIO 8 -----------------
//==================================

#exercise()[
  Costrúyase todas las representaciones del grupo cíclico $ZZ_n$
]

Este es un grupo abeliano y todas las representaciones de los grupos abelianos son unidimensionales. Sea

$ z_m = exp(2 pi i m / N) $

entonces 

$ z_m^* = exp(-2 pi i m / N) = exp(2 pi i (N - m) / N) = z_{N-m} $,

y además

$ z_n z_m = z_{n+m} = z_m z_n $.

Por tanto, dado que el grupo es abeliano y conjugado consigo mismo, cada elemento del grupo es una clase de conjugación, por lo que hay $N$ representaciones irreducibles. Es evidente entonces que las representaciones irreducibles de $ZZ_N$ son los
propios elementos de $ZZ_N$.



//==================================
// -- EJERCICIO 9 -----------------
//==================================

#exercise()[
  Construir la representación irreducible de dimensión 2 del grupo simétrico $S_3$ y demostrar que es equivalente a la obtenida a partir del gurpo diédrico $D_3$. 
]

Las represetnaciones irreducibles de dimensión 2 del grupo diédrico: 

$ e = mat(1,0;0,1) quad quad 
  c = mat(-1/2,- sqrt(3)/2;sqrt(3)/2,-1/2) quad quad 
  c^2 = mat(-1/2,sqrt(3)/2;-sqrt(3)/2,-1/2)  $
$ x = mat(-1,0;0,1) quad quad  
  y = mat(1/2,sqrt(3)/2;sqrt(3)/2,-1/2)  quad quad
  z = mat(1/2,-sqrt(3)/2;-sqrt(3)/2,-1/2)   $ 

Si nos fijamos ya obtuvimos en un ejercicio anterior, 


$ D'(()) =  1 oplus mat(1,0;0,1) quad quad 
D'((12)) = 1 oplus mat(-1,0;0,1) 
$
$ D'((23)) 
 =  1 oplus mat(1/2, sqrt(3)/2; sqrt(3)/2, -1/2)  
quad quad D'((13))  
= 1 oplus mat(1/2, -sqrt(3)/2; -sqrt(3)/2, -1/2) $

$ D'((123)) =1 oplus mat(-1/2, -sqrt(3)/2; sqrt(3)/2, -1/2)  quad quad  D'((132)) 
= 1 oplus mat(-1/2, sqrt(3)/2; -sqrt(3)/2, -1/2) $

Si nos fijamos en ambos, vemos que ambas son equivalentes, con las siguientes relaciones: 

$ e tilde () quad x tilde (12) quad y tilde (23) quad z tilde (13) quad c tilde (123) quad c^2 tilde (132)  $
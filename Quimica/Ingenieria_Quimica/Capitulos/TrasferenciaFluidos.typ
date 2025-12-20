
== Introducción

En la mecánica de fluidos mediante el experimento de *Reynolds* se obtuvo la expresión @eq:reynolds la expresión del *número de reynolds* $R_e$ que nos permite conocer en que régimen encontramos. El número de reynolds se define en la ecuación  donde $v$ es la velocidad en $m/s$, $D$ es el diámetro en m, $rho$ es la densidad en $"kg"/"m"^3$ y $mu$ es la viscosidad en $"kg"/("m" dot "p" dot "s")$, de modo que el número de reynolds es adimensional.

$
  R_e = (v dot.op D dot.op rho)/mu 
$ <eq:reynolds>

De modo que si $R_e<2100 $ estamos hablando de régimen laminar, si estamos en el caso $2100<R_e<10000 $ estamos ante el régimen de transición y si $R_e>10000$ estamos ante un régimen turbulento.

=== Régimen Laminar

Definimos *régimen laminar* como el régimen de flujo en el que las partículas de fluido recorren trayectorias paralelas sin entremezclarse, siendo el mecanismo de transporte exclusivamente molecular. Se da en fluidos con velocidades bajas o viscosidades altas, se cumple cuando el número de Reynolds es inferior a $2100$. El perfil de velocidad en este régimen, teniendo en cuenta la @fig:regimenes se representa, viene dado por:

$
    v_x=v_(max) dot [1- (((r)/(R))^2 ]
$

En este caso se cumple que $v_{"media"}/v_{max}=0.5$.



=== Régimen Turbulento

El *régimen turbulento* es el régimen de flujo en el que las partículas de un fluido se entremezclan al azar, macroscópicamente, desplazandose con continuos cambios de dirección, aunque en promedio se mantenga una trayectoria definida. Es un mecanismo más efectivo que el laminar. Se da en fluidos con velocidades altas o viscosidades bajas. En el régimen turbulento el perfil de velocidad viene dado por:

$
v_x = v_(max) dot.op ((R - r)/R)^(1 \/n)
$

En este caso $v_("media")/v_(max)=0,8$. El valor de $n$ dependerá del número de Reynolds $R_e=4000$ se corresponde a $n=6$, $R_e=10000$ que se corresponde con $n=10$ y $R_e=3,2 dot 10^(6)$ con $n=10$.

#figure(
  image("../Imagenes/TrasferenciaFluidos/Imagen-01.jpeg", width: 50%),
  caption: "Representación del régimen laminar y el régimen turbulento.",
) <fig:regimenes>


== Ecuación de continuidad

Suponemos que el fluido (gas o líquido) circula en régimen estacionario por un conducto, es decir, todas las magnitudes que definen la corriente del fluido permanecen constantes con relación al tiempo en cada punto del sistema. Aplicando el principio de conservación de la materia a dos puntos en una canalización, se llega a que la cantidad de materia que pasa por ambos puntos por unidad de tiempo (kg/s) es la misma; o bien, si designamos $S$ al área de sección transversal a flujo, por densidad de fluido $rho$ y por su velocidad $v$ podemos escribir para los puntos 1 y 2 llegamos a la *ecuación de continuidad*:

$ S_1 dot.op rho_1 dot.op v_1 = S_2 dot.op rho_2 dot.op v_2 $ <eq:continuidad>

 Esta ecuación podemos expresarla en función de diferentes magnitudes. Llamamos *velocidad másica* (kg / s $"m"^2$) a la relación $v/theta=G$ siendo $theta$ el volumen específico ($"m"^3/"kg"$) ($theta=1/rho$). Al cociente $Q/ theta=W$ lo nombraremos como *flujo de masa* ($"kg"/"s"$). Teniendo en cuenta estas dos relaciones podemos escribir la ecuación de continuidad como:

$
     W=S_1 dot G_1=S_2 dot G_2
$

 En el caso de que *la densidad sea constante* podemos decir que se trata de un *fluido incompresible*, reduciéndose la ecuación de continuidad a:

 $ S_1 dot v_1=S_2 dot v_2 $

 Recordemos que el caudal se define como la velocidad por la sección ($Q=v dot S$) de modo que la *ecuación de continuidad de un fluido incompresible* no es más que la conservación del caudal.
$ Q_1 = Q_2 $


== Balance de energía mecánica: Ecuación de Bernouilli

Recordamos la ecuación de conservación de la energía en estado estacionario véase @eq:conservacion. En el caso de que no existe una variación de temperatura, la energía interna pertenece constante, de modo que se anula el término de la energía interna en dicha ecuación.

$   m dot.op g dot.op (z_2 - z_1) + dot.op 1/2 dot.op m^2 dot.op (v_2^2 - v_1^2) + m dot.op [(P_2)/(rho_2) - (P_1)/(rho_1)] = Q + W
$ <eq:conservacion>

En un sistema abierto en régimen estacionario, en el que solo se intercambia energía mecánica con el exterior, siendo nulos los intercambios caloríficos ($Q=0$). Se puede aplicar el *teorema de las fuerzas vivas*: _en un sistema en movimiento, la variación de energía cinética es igual a la suma del trabajo realizado sobre el sistema por fuerzas externas y del trabajo realizado por las fuerzas interiores_.

#v(1em)

En este caso podemos aplicar la ecuación de Bernouilli (estado estacionario, isotermo e incompresible) donde en la ecuación de conservación sustituimos $Q$ por la energía perdida (es negativa) por fricción lateral, son las fuerzas viscosas

$ F_("vis") =-m dot sum_i F_i $

 que tienen origen en la viscosidad del fluido, es un trabajo cedido por el exterior.

$ g dot.op(z_2 - z_1) +((P_2 - P_1)/rho) + 1/2 (v_2^2 - v_1^2) + sum F = W " ($J/kg$) " $

En régimen laminar podemos utilizar la *ecuación de Poiseuille*:

$ (Delta P)/L = (32 mu dot.op v)/(D^2) $

De modo que las perdidas por rozamiento en las unidades de la ecuación de Bernouilli:

$    sum F = (Delta P)/rho = (32 mu dot.op v dot.op L)/(rho dot.op D^2) $

En cambio, en régimen tubulento debemos usar la *ecuación de Fanning*:

$ (Delta P)/L = (2 dot.op f dot.op rho dot.op v^2)/D $

Donde $f$ es el factor de rozamiento que en régimen laminar:

$ 
f = (16 mu)/(v dot.op D dot.op rho) = 16/(R_e) $

Expresando en las unidades de Bernouilli:

$ sum F = (Delta P)/rho = (2 dot.op f dot.op v^2 dot.op L)/D $

Donde $D$ es el *diámetro interno* y $L$ la *longitud equivalente*.

=== Ecuación de Chen y Diagrama de Moody

Si la tubería tiene algún tipo de accesorios como llaves, codos, empalmes, etc., se producen pérdidas por fricción asociada a la presencia de los mismos. Estas pérdidas se pueden determinar por medio de gráficas que permiten determinar la longitud de tubo recto a que equivale el accesorio que consideremos. No hay más que sumarle  a la longitud de la tubería recta, la equivalente a los accesorios para calcular las pérdidas por fricción. Podemos calcular el factor de fricción $f$ a partir de la *ecuación de Chen o Diagrama de Moody*, para régimen turbulento. Llamaremos rugosidad relativa en conducciones a $epsilon/D$:

$
1/sqrt(f) = 4 dot.op log [epsilon/(3, 7065 dot.op D) - (5, 0452)/(R_e) dot.op l o g [1/(2, 8257) dot.op(epsilon/D)^(1, 1098) + 5, 8506 dot.op R_e^(-0, 8981)]] $

La rugosidad relativa en conducciones ($epsilon/D$) se determina a través de datos experimentales, para cada tipo de material y diámetro de conducción.

#figure(
  image("../Imagenes/TrasferenciaFluidos/Imagen-02.jpeg", width: 50%),
  caption: [
    Ejemplo de determinación gráfica de la rugosidad relativa $epsilon / D$.
  ],
) <fig:rugosidad-relativa>



El coeficiente de fricción también se puede determinar mediante el *diagrama de Moody* mediante el número de Reynolds.

#figure(
  image("../Imagenes/TrasferenciaFluidos/Imagen-03.jpeg", width: 50%),
  caption: [Diagrama de Moody para la determinación del coeficiente de fricción.
  ],
) <fig:Moody>



En este tema tenemos que tener clara la acción de una bomba y una turbina. Teniendo en cuenta que para un fluido incompresible y sin fricción, la ecuación de conservación de la energía es:

$ ((P_2 - P_1)/rho) = dot(W) $

En presencia de una *bomba* el trabajo será positivo ($W>0$) ya que $P_2>P_1$, la bomba es la que realiza el trabajo sobre el sistema. En cambio, en una turbina el trabajo será negativo ($W<0$), en este caso el trabajo es realizado por el fluido ($P_1>P_2$). 

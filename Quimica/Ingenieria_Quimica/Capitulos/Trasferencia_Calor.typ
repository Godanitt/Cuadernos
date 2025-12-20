
== Introducción

La mayoría de procesos químicos va a tener lugar un intercambio de energía, una transmisión del calor.
La termodinámica trata de los sistemas en equilibrio, y, por tanto, permite predecir la cantidad de energía necesaria para hacer evolucionar el sistema de un equilibrio a otro. No predice la velocidad con que esto se produce. El estudio de la transmisión de calor permite estableces los mecanismos por los que esta transcurre y las correspondientes expresiones para el flujo de calor en cada caso concreto. La velocidad de transmisión de calor dependerá del tamaño del equipo, equipo auxiliar, material de conducción...

#v(1em)

Algunos ejemplos donde es importante la transmisión de calor es en aislamiento térmico de tuberías, producción de calor en hornos, calderas ...

#v(1em)

=== Conceptos Básicos

Existen dos mecanismos fundamentales en el transporte de cualquier propiedad extensiva: *transporte molecular* (conducción de calor, fruto de las colisiones individuales a escala molecular) y el *transporte turbulento* (convección de calor, resultado de los choques de proporción macroscópica de fluido cuando existe régimen turbulento).

#v(1em)

Pero en transmisión de calor, hay un tercer mecanismo: la *radiación*, que a diferencia de los anteriores, no requiere ningún medio material, siendo óptimo en el vacío, pues en definitiva se trata de un mecanismo de propagación de una *onda electromagnética*.

#v(1em)



La *temperatura* es una forma indirecta de medir la cantidad de energía térmica. Es una propiedad de un cuerpo. Se mide en grados de temperatura con un termómetro. Nunca se transmite.

#v(1em)


En cambio, el *calor* es el transporte de energía térmica (flujo) y tiene que haber un gradiente de temperatura (del cuerpo de mayor temperatura al de menor temperatura). Se mide con un calorímetro y tiene unidades de energía (J).ç

#v(1em)


El mecanismo de conducción de calor tiene lugar en los cuerpos sólidos y fluidos en reposo. Se produce como resultado de las interacciones moleculares, en las que las moléculas de mayor contenido energético ceden energía a la de menor contenido energético.

=== Flujo de Calor y Ley de Fourier

Cuando existe un gradiente de temperatura en un cuerpo, se produce la transmisión de calor por conducción desde una región de mayor temperatura hacia la de menor temperatura, siendo *el flujo de energía (q)* proporcional al gradiente de temperatura siguiendo la *ley de Fourier*.

$ q = - kappa dot.op (dif T)/(dif  x) "(W/m"^2) $

Una condición termodinámica es que el flujo de calor se produce en la dirección en la que disminuye la temperatura, es decir, la dirección opuesta al gradiente de temperatura.

#figure(
  image("../Imagenes/TrasferenciaCalor/01.jpg", width: 50%),
  caption: "flujo de energía en presencia de un gradiente de temperatura.",
) <fig:flujo>

La conductividad térmica, $kappa$ ($"W" dot "m"^(-1) dot "K"^(-1)$), de un material o de un fluido, es una propiedad física de este y representa la capacidad para transmitir calor por conducción, y depende fundamentalmente de la temperatura, aunque también de la presión en el caso de los gases. Indica mayor o menor facilidad del material para transmitir calor por conducción. La conducción ocurre cuando el calor se transmite de un cuerpo. a otro con diferente temperatura a través del mero contacto, sin que ocurra un desplazamiento de materia. Los metales son los mejores conductores de calor, si bien definen mucho unos de otros y resultan sensibles a impurezas o presencia de otros metales (aleaciones). Los gases resultan ser buenos aislantes térmicos, siempre que el único mecanismo de transmisión de calor sea la conducción.

#v(1em)

La intensidad de paso de calor por conducción ($"J"/"s"$) se denomina *caudal de calor*. El proporcional al área de la sección normal, al flujo de calor, $A$, al gradiente de temperaturas y a la conductividad calorífica, $kappa$.

$ Q = - kappa dot.op A dot.op (dif T)/(dif x) arrow Q = q dot.op A $ <eq:caudal>

En el caso de una *placa plana* resolviendo la ecuación diferencial correspondiente a la @eq:caudal obtenemos que la expresión de del caudal de calor es:

$ Q = kappa dot.op A (T_1 - T_2)/(x_2 - x_1) $

Llamaremos espesor $e= x_2-x_1$ de la placa. Además, la resistencia se define como $R=e/(kappa dot A)$ de modo que podemos expresar el caudal de calor como:

$   Q=(Delta T)(R) $

Vemos que esta solución es análoga a la *ley de Ohm* de conducción eléctrica $I=(Delta V)/R$.

#v(1em)

Para el caso de combinación de placas planas, el caudal de calor será por la ley de Ohm:

$
Q = (T_1 - T_2)/(R_1) = (T_2 - T_3)/(R_2) = (T_3 - T_4)/(R_3) = (T_1 - T_4)/(R_1 + R_2 + R_3) $

De modo que el caudal de calor cuando existe una combinación de placas:

$  Q = (Delta T_("total"))/(sum R_i)  $

#figure(
  image("../Imagenes/TrasferenciaCalor/02.jpg", width: 45%),
  caption: "Conducción de calor a través de placas paralelas en serie",
  
)<fig-placeholder>


En el caso de que exista un mal contacto entre las placas se colará aire entre las placas. De modo que aparece la resistencia de contacto, $R_c=1/(h_c A_c)$ la cual también se debe tener en cuenta. Llamamos $h_c$ al coeficiente de contacto expresado en $(W/m^2 dot K)$.

#figure(
  image("../Imagenes/TrasferenciaCalor/03.jpg", width: 45%),
  caption: "Resistencia de contacto en placas paralelas",
  
)<fig-placeholder>

En *superficies cilíndricas* el área de conducción se corresponde con $A=2 pi r L$ si resolvemos la ecuación diferencial correspondiente llegamos a que el caudal de calor es:

$  Q = (2 pi L kappa)/(L n(r_2 \/r_1)) (T_1 - T_2) = (Delta T)/R $

Como vemos en este caso, la resistencia se corresponde con:

$ 
R = (L n(r_2 \/r_1))/(2 pi L kappa) $

#figure(
  image("../Imagenes/TrasferenciaCalor/04.jpg", width: 30%),
  caption: "Conducción de calor en superficie cilíndrica.",
  
)<fig-placeholder>


La transmisión de calor se puede llevar a cabo mediante el mecanismo de *convección*. Este mecanismo se basa en la transmisión de calor en un fluido por efecto del movimiento de este, siendo sus moléculas portadoras de energía térmica. Si el movimiento se da por acción de una fuerza externa, hablamos de *convección forzada* y si se produce por la fuerza ascensional originada por una diferencia de densidad, causada por una diferencia de temperatura, se denomina *convección natural*.


#figure(
  image("../Imagenes/TrasferenciaCalor/05.jpg", width: 85%),
  caption: "Tipos de conveccion",
) <fig-placeholder>


Cuando tenemos una placa a una temperatura superficial $T_s$ y un fluido a una temperatura $T_infinity$ que fluye paralelo a la placa. Como resultado de las fuerzas viscosas, la velocidad del fluido será cero en la pared (perfil de viscosidades por efecto de la viscosidad) y aumentará al alejarse de la superficie.

#v(1em)

Puesto que la capa fina de película de fluido adyacente tiene velocidad nula, el calor debe transmitirse a través de ella por *conducción*, aplicándose la Ley de Fourier. La velocidad del fluido (u) afecta al gradiente de temperaturas, y, por tanto, a la rapidez con la que el fluido es capaz de eliminar el calor de la superficie.

#v(1em)


El flujo de calor, $q$, por convección se determina en función del gradiente de la temperatura mediante la *ley de Newton del enfriamiento*:

$ 
q = h dot.op (T_s - T_infinity) $

Siendo $h$, con unidades ($"W" dot "m"^(-2) dot "K"^(-1)$), el coeficiente de transmisión de calor por convección.

=== Caudal de calor

El caudal de calor , $Q$, para una superficie de sección $A$, se determina:

$ 
Q = h dot.op A dot.op (T_s - T_infinity) = (Delta T)/R $

El coeficiente $h$ dependerá de la velocidad del fluido, de la viscosidad y del resto de propiedades del fluido, así como de la geometría del sistema. En este caso también sigue la ley de Ohm con expresión para la resistencia $R=1/(h dot A)$.

#v(1em)

También existe otro mecanismo de transmisión de calor asociado a la *radiación electromagnética* que emite un cuerpo en función de su temperatura. Dicha transmisión de calor no requiere de un medio material y es óptima en el vacío, El flujo de calor transmitido es proporcional a la temperatura del cuerpo (absoluta) elevada a la cuarta potencia ($T^4$). La radiación térmica se vuelve especialmente importante a temperaturas elevadas, sin embargo, todo cuerpo radia energía térmica a $T>0K$. 

#v(1em)


Cuando dos cuerpos se encuentran a distinta temperatura ($T_1$ y $T_2$), intercambian energía térmica por radiación, y el intercambio viene dado por la *ley de Stefan-Boltzmann*:

$ 
Q = epsilon dot.op sigma dot.op A dot.op (T_1^4 - T_2^4) $


Donde $A$ es el área  de intercambio de calor y $sigma$ es la constante de proporcionalidad de Stefan-Boltzmann ($sigma=5,669 dot 10^{-9} "W"/("m"^2"K"^4)$). Se introduce el término de emisividad $epsilon$ (con valor entre $0$ y $1$) que es la fracción de radiación emitida con respecto a un cuerpo negro.

== Coeficiente global de transmisión de calor 

El dispositivo  más sencillo para intercambiar calor entre un fluido frío y uno caliente separado por una pared sólida es el *intercambiador de calor*. La intensidad de paso de calor a través de un elemento diferencial de superficie de cambiador puede expresarse por:

$ 
    dif Q=U dot dif A dot Delta T $

Donde $U$ ($"W" dot "m"^{-2} dot "K"^{-2}$) es el *coeficiente global de transmisión de calor*  y se relaciona con la *resistencia calorífica total* por la ecuación:

$ 
    U A = 1 / (sum R) $

Por tanto:

$ 
Q = U dot.op A dot.op (T_("int") - T_("ext")) $

Es equivalente a:

$ Q = (T_("int") - T_("ext"))/(R_("int") + sum_i^n R_i + R_("ext")) $


De modo que, aplicado a la @fig:mats:

$  1/(U A) = R_("int") + sum_(i = 1)^(i = 3) R_i + R_("ext") = 1/(h_("int") A) + sum (e_i)/(k_i A) + 1/(h_("ext") A) $

Donde $U dot A$ ($"W" dot "K"^{-1}$) siempre es inferior a la contribución de cada una de las resistencias.

$ 
U A <= h_("int") A wide U A <= h_("ext") A wide U A <= (k_i A)/(e_i) $

En paredes cilíndricas, $U dot A$ estará referido a una de las superficies, interna o externa, pero cada una de las resistencias lo estará con respecto a su superficie de transmisión.

#figure(
  image("../Imagenes/TrasferenciaCalor/06.jpg", width: 
  50%),
  caption: "Transmisión de calor a través de placas paralelas de diferentes materiales.",
) <fig:mats>


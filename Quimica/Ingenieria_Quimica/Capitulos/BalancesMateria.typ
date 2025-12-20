#import "../../../plantilla.typ": *


La *Ley de Lavoiser* dice _la materia no puede crearse ni destruirse, solamente transformarse_. 

#v(1em)

Esta ley es valida para todos los fenómenos físicos y químicos, excepto en los que implican reacciones nucleares, en las que parte de la materia se destruye para convertirse en energía segun la ecuación de Einstein:

$ E=m dot c^2 $

Puede establecerse que en un proceso que se desarrolla en estado estacionario, la masa total de todas las corrientes de entrada en un determinado recinto o volumen se control ha de ser igual a la masa total de la suma de las corrientes de salida:

$ [E]=[S] $

En el caso de las recciones químicas la masa de los componentes de la reacción de reorganiza.

Si el régimen no es estacionario y existen reacciones químicas entre los compuestos presentes, la expresión general de la ley de conservación presenta dos nuevos términos : $[A]$ el cual hace referencia a acumulación de materia y $[G]$ que se corresponde la generación de nuevas materias (debido a reacciones químicas).

$ [A]=[E]-[S]+[G] $ <ec:01>

== Ecuación general de conservación

Antes de nada necesitamos saber diferenciar lo que es una propiedad intensiva de una extensiva.

- Propiedad extensiva: es aquella que depende de la cantidad de substancia presente, son aditivas (m,V $E_T$ o L).
- Propiedad intensiva: no depende de la cantidad de la materia de la substancia presente, no son aditivas (T, $rho$ o P).


Una vez conocido la diferencia entre estas propiedades vamos a deducir la ecuación general de la conservación para cuaquier propiedad extensiva.

#v(1em)

Siendo $pi$ la concentración de propiedad extensiva en el recinto (cantidad de propiedad por unidad de volumen), variable de un punto a otro:

$ integral_V (delta pi)/(delta t) dif V $
    

El caudal neto de propiedad extensiva que abandona el recinto de fluido a través de la superficie S por transporte molecular es :

$  -integral_S phi dif vec(S) $

Donde $phi$ es el flujo de la propiedad extensiva debido a gradientes de concentración, variable para cada elemento de superficie (cantidad de propiedad que atraviesa la unidad de superficie S en la unidad de tiempo) y el signo $-$ indica que es un cuadal neto que ale del recinto. 

#v(1em)

De la misma manera el caudal neto de propiedad extensiva que abandona el recinto por el mecanismo de convección (movimiento del fluido con velocidad $vec(v)$ será:

$    -integral_S pi dot vec(v) dot dif vec(S)$

La generación de propiedad extensiva en el interior del propio recinto vendrá dada por:


$ integral_V G dif V $

Siendo G la cantidad de propiedad extensiva que se genera en el recinto por unidad de volumen y tiempo. Esta generación en el caso de materia y energía sería siempre causada por las reacciones químicas que tienen lugar en el recinto.

#v(1em)

Por lo que la ecuación general de conservación de cualquier propiedad extensiva vendrá dada por la ecuación:

$
    integral_V (delta pi)(delta t) dif V=-integral_S phi dif vec(S) - integral_V pi vec(v) = dif vec(s) + integral_V G dif V
$

Donde $[E]-[S]=- integral_S phi d vec(s)-integral_V pi vec(v)d vec(S)$. Además, el caudal se define como $Q_v= vec(v) dot vec(s)$ de tal mal¡nera que aplicando el teorema del valor medio del cálculo integral:

$ dif(V, t)  = - sum_i phi.alt_i vec(S_i) +(pi_1 Q_(v, 1) - pi_2 Q_(V, 2)) + G_m V
$


Donde:

- $pi_m$ y $G_m$ es el valor medio de la concentración y generación de propiedad en el sistema.
- $sum_i phi_i vec(S)_i$ se trata de la suma de cuadales netos de propiedad que abandonan el sistema a través de las distintas superficies.
- $pi_1$ y $pi_2$ los valores medios de concentración de propiedad en las corrientes E y S.



== Balances macroscópicos de materia

Partiendo de la ecuación de conservación de cualquier propiedad extensiva, pero para balances macroscópicos el término de la difusión se anula $sum_i phi_i vec(S)_i=0$.


Dependiendo de que propiedad que se conserva tomemos las unidades de $pi$ cambiarán:

- Materia: concentración de materia ($"kg/m"^3$).
- Energía: concentración de energía ($"J/M"^3$)
-Cantidad de movimiento: concentración de cantidad de movimiento($upright(k g /m)^3s$)

Quedando la ecuación macroscópica  de conservación del componente $i$ (masica) (donde $rho$ es la concentración másica de componente $i$):

$ dif(M_(i_T))(t)=(rho_(i_1) Q_(V,1)- rho_(i 2) Q_(V,2))+r_(im)V
$

Donde el último término, el termino de materia total generada, es nulo en unidades masicas ya que la masa no se genera sino que se transforma. Quedando la ecuación macroscópica de conservación de la materia total ecpresada en unidades de masa (OJO: en el caso de numero de moles no se conserva no desaparece el término):

$ dif(M_(i_T))(t)=(rho_(i_1) Q_(V,1)- rho_(i 2)Q_(V,2)) $

Definimos ahora lo que es la \textbf{base de cálculo}. Esta consiste en la cantidad de materia adecuada que se toma como referncia o bien una cantidad de tiempo de operación. Para elegir esta base de cálculo se recomienda:

- Elegir la corriente de la que se dispone más información.
- Para sistemas líquidos o sólidos la unidad de masa o volumes puede ser más adecuada.
- PAra sistemas de flujo (corrientes de entrada y salida), se eligiría la unidad de tiempo.
- Para gases: cantidad de masa o bien de volumes siempre y cuando se conozcan las condiciones de $P$ y $T$. ($P V = n R T$).


== Balances de materia en estado estacionario
=== Sin reacción química

En este caso el término de acumulación es nulo de tal modo que:

$
[S] - [E] = [G] -> Q_(V 2) rho_(i 2) - Q_(V 1) rho_(i 1) = r_(i m) V
$

Donde además si no se produce reacción química el término de generación es nulo, llegando así a la conocida como la ecuación de continuidad:

$Q_(V 2) rho_(i 2) = Q_(V 1) rho_(i 1) -> m_(i 2) = m_(i 1)$

Si $rho="cte"$, es decir se trata de un fluido incompresible:

$ Q_(V 1) = Q_(V 2) -> v_1 S_1 = v_2 S_2 $

Como las secciones no son iguales la velocidad serán diferentes, por lo que donde la superficie sea menor la velocidad será mayor.\\

Con mucha frecuencia, en la industria, se utilizan sistemas de recirculación. Las recirculaciones consisten en el retorno de una fracción de la corriente de salida de una unidad de operación a la entrada de la misma. Principalmente se utliza para aprovechar la conservación calorífico y para una mejora del rendimiento.\\

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-01.jpeg",
    width: 75%,
  ),
  caption: [Diagrama de bloques con corriente de recirculación],
) <fig:recirculacion>


Con recirculación podemos plantear distintos tipos de balance (mostrados en la @fig:balances):

+ Balance global: $F arrow P$
+ Balance referido a la unidad de operación $E arrow S$
+ Balance en el punto de mezcla de alimentación y la recirculación: $F+R=E$.
+ Balance en el punto de partida de la recirculación : $S=R+P$.

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-02.jpeg",
    width: 75%,
  ),
  caption: [Diferentes tipos de balances posibles en un diagrama de recirculación.],
) <fig:balances>

También son muy utilizados los procesos de purga donde se elimina una parte de la corriente de recirculación. Se emplea cuando en la alimentación hay una sustancia inerte, que se acumula a lo largo del tiempo en el sistema.

#v(1em)

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-03.jpeg",
    width: 75%,
  ),
  caption: [Diagrama de bloques correspondiente a un proceso de purga.],
) <fig:purga>

Otro tipo de sistema son los sistemas _bypass_ que consisten en la separación de una fracción de la corriente de entrada o alimentación que no se hace pasar por la unidad de proceso y se une directamente con la corriente de salida (no experimenta transformación). Se utiliza con la finalidad de modificar las condiciones del producto obtenidos en una unidad de proceso.

#v(1em)

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-04.jpeg",
    width: 75%,
  ),
  caption: [Diagrama de bloques de un sistema ahora estea *bypass*.],
) <fig:placeholder>


=== Con reacción química

En este caso el término correspondiente a la generación es no nulo. De tal modo que:

$ [S]=[E]+[G] $

Partimos de un caso ideal donde suponemos que la reacción química se completa al $100 %$, cosa que no ocurre realmente a escala industrial. En la realidad tendremos algún reactivo en exceso, también puede ocurrir que se produzcan reacciones secundarias o habría que tener en cuenta el grado de conversión.

#v(1em)

Como en cualquier cálculo de rendimiento el primer paso que debemos hacer es determinar cual es el \textbf{reactivo limitante}. El reactivo limitante es aquel que está en menor proporción estequimétrica, se consumiría primero en la reacción química y cuando se agota, limita la formación de producto. El reaccitivo limitante se puede obtener dividiendo los moles del reactivo ($N_j$) entre el coeficiente estequimétrico de reactivo ($alpha_j$). De tal modo que en la siguiente ecuación el reactivo $i$ es el limitante cuando se cumpla para el resto de reactivos $j$:

$ lr(| (N_j)/(alpha_j) |) > lr(| (N_i)/(alpha_i) |) $

Los reactivos que participan en la reacción y no son limitantes y, por lo tanto, sobra una cantidad de estos tras la reacción se conocen como *Reactivo en exceso*.

#v(1em)

Podremos determinar el porcentaje en exceso haciendo la relación entre la cantidad de exceso de reactivo y la cantidad necesaria para reaccionar completamente con el reactivo limitante.

$ % "Exceso" = "Nº moles en exceso"/"Nº moles necesarios para reaccionar " dot.op 100 $

También definimos el termino *conversión* que no es más que la fracción de compuesto alimentado que reacciona.

$ chi_A = "Nº moles de A transformado"/"Nº moles de A alimentados" $



Es interesante determinar el *rendimiento*:

$ "Rendimiento" = "Nº de moles (o masa) de producto formado"/"Nºmoles (o masa) inicial de reactivo" $

Dependiendo de a que reactivo sobre el que se basa el rendimiento tendremos tres tipos de rendimiento:

- *Rendimiento teórico o máximo*: cantidad de producto que se espera dada la reacción química balanceada cuando ha reaccionado todo el reactivo limitante.
- *Rendimiento de reacción*: cantidad de producto que realmente es obtenida. Siempre es menor o igual al teórico.
- *Rendimiento relativo*: porcentaje (o fracción) entre el rendimiento de reacción y el teórico.

Cuando hay dos o más rearcciones tenemos que tener en cuenta la selectividad:

$ "Selectividad" = "Cantidad de producto formado"/"Cantidad de reactivo limitante consumido" $

En sistemas con recirculación como el de la figura @fig:reac-rec hay varios tipos de conversión:

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-05.jpeg",
    width: 50%,
  ),
  caption: [Sistema con reacción química y recirculación.],
) <fig:reac-rec>


$ "Conversión global" = (("reactivo en F")- "(Reactivo en P)")/("Reactivo en F") $
$ "Conversión por paso" = ( ("reactivo en F+R") - "(Reactivo en S)")/"Reactivo en F+R" $

== Balances de materia en etado no estacionario

$Q_(v 1) dot.op rho_1 - Q_(v 2) dot.op rho_2 = (d M_T)/(d t)$

En el caso de un sistema en estado no estacionario el término de acumulación no se anula. De modo que la ecuación general se corresponde con la ecuación @ec:01. En este caso el balance de un componente $i$:

$ Q_(v 1) dot.op rho_(i 1) - Q_(v 2) dot.op rho_(i 2) + r_i dot.op V = (d M_(i T))/(d t) $

Y el balance global:

$ Q_(v 1) dot.op rho_1 - Q_(v 2) dot.op rho_2 = (d M_T)/(d t) $

En este caso:

    $ Q_{v 1} dot rho_{i 1} eq.not Q_{v 2} dot rho_{i 2} $ 
    $ v_2 dot S_2  dot rho_{2} eq.not v_1 dot S_1 dot rho_{1} $
    $ m_2 eq.not m_1 $

En sistemas con reacciones químicas se tiene la misma problemática moles/masa del estado estacionario. En sistemas de estados no estacionario una variable fundamental es el tiempo y se recurren a sistemas de ecuaciones diferenciales.

#v(1em)

En esta clase de sistemas, exceptuando periodos de carga y descarga, no hay corrientes de entrada y de salida del sistema, por lo que la ecuación se simplifica:

$ [G]=[A] $

Para un a componente $i$:

$ r_i dot.op V = (d M_(i T))/(d t) $

En otras ocasiones, uno o más materiales se cargan inicialmente en el equipo, donde permanecen un cierto tiempo en contacto con corrientes que entran y salen continuamente, desarrollándose una operación en semicontinuo. En el caso de régimen no estacionario, no se pueden anukar ningún término de la ecuación @ec:01.

== Reactores químicos

En función de las fases presentes se pueden clasificar en :

- Reactores homogéneos: las reacciones transcurren solamente en una fase (líquida y gaseosa).
- Reactores heterogéneos: las reacciones requieres al menos la presencia de más de una fase (normalmente G-L/G-S/L-L, S-L-G.

#v(1em)

En ambos casos puede influir la presencia de catalizadores. Un catalizados en euna sustancia que cambia la velocidad de reacción y que no es ni un reactivo ni un producto, ni necesita estar presente en grandes cantidades.

#v(1em)

En función del régimen térmico:


- Reaccione sisotérmicos: operan a T constante. Estan equipados con sistemas de intercambio de calor que liberan o aportan calor.
- Reactores adiabáticos: no hay intercambio de calor con el exterior. En el interior la T varia con el tiempo (se modifica la velocidad de reacción y equilibrio).


Según el tipo de operación puede clasificarse en *Continuo, discontinuo o semicontinuo*.\\


=== Reactor Discontiuo de tanque agitado (RDTA) 

Los reactivos se introducen al principio de la operación y, una vez transcurrida la reacción, se retiran los productos de reacción (*discontinuo*). Todas las variables varían con el tiempo hasta alcanzar los valores finales. Pueden operar en condiciones isotermas ( T cte) o no isotermac (T no cte). LA variable clave es el tiempo necesario para alcanzar una determinada conversión.

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-06.jpeg",
    width: 75%,
  ),
  caption: [Esquema RTDA],
) <fig:rtda>


En el caso de una componente A, obviando la carga y descarga. 

$ -[G]=[A] $

Donde aparece un signo negativo debido a la cantidad de A que reacciona y por lo tanto desaparece ($(-r_A)V$ en mol/s). El término de acumulación en mol/s:

$ (d N_A)/(d t) = (d [N_(A_0) ](1 - x_A))/(d t) = - N_(A_0) dot.op (d x_A)/(d t) $

De modo que la ecuación de diseño de RDTA:

$ (-r_A) V = N_(A_0) dot.op (d x_A)/(d t) -> t = N_(A_0) dot.op integral_0^(x_A) (d x_A)/((-r_A) V) $

En reacciones donde el volumen es constante es mejor expresar la ecuación en forma de concentraciones:

$ t = (N_(A_0))/V integral_0^(x_A) (d x_A)/((-r_A)) = C_(A_0) integral_0^(x_A) (d x_A)/((-r_A)) $ <ec:RTDA>



Podemos expresar la conversión  de A como:

$ x_A = (N_(A_0) - N_A)/(N_(A_0)) -> x_A = (V dot.op(C_(A_0) - C_A))/(V dot.op C_(A_0)) $

Sabemos que:

$ N_A = N_(A_0) dot.op(1 - x_A) -> C_A = C_(A_0) dot.op(1 - x_A) -> dif C_A = - C_(A_0) dot.op dif x_A $ 

De modo que sustituyendo en la eqcuación @ec:RTDA llegamos a que la ecuación de diseño de un RDTA, con volumen constante, en función de las concentraciones (considerando A reactic¡vo limitante) se puede expresar como:

$ t = - integral_(C_(A_0))^(C_A) (d C_A)/((-r_A)) $

=== Reactor Continuo de Mezcla Completa (RCTA)

Si el RDTA estudiado tuviera una corriente de entrada y una corriente de salida, se convertiría en un reactor continuo de tanque agitado o reactor de flujo de mezcla completa. Este tipo de sistema opera en estado estacionario de tal modo que $[A]=0$. De tal modo que expresando el balance a una componente A:

$ F_(A_0) - F_(A_0) (1 - x_(A_1)) -(-r_A) dot.op V_1 = 0 -> F_(A_0) dot.op x_(A_1) = (-r_A) dot.op V_1 $

Llegando a la ecuación de diseño del reactor la cual nos permite calcular el volumen del reactor para alcanzar la conversión $x_A$.

$ (V_1)/(F_(A_0)) = (x_(A_1))/((-r_A)) $

#figure(
  image(
    "../Imagenes/ConservacionMateria/Imagen-07.jpeg",
    width: 50%,
  ),
  caption: [Reactor continuo de mezcla completa (RCTA)],
) <fig:rcta>


En el caso que $x_A eq.not 0$ podemos expresar la ecuación de diseño en base a concentración sabiendo que :

$ C_(A_s) = C_(A_e) dot.op(1 - x_(A_s)) -> x_A = (C_(A_e) - C_(A_s))/(C_(A_e)) $

De tal forma que llegamos a la ecuación:

$ (V_s dot.op C_(A_e))/(F_(A_e)) = (C_(A_e) - C_(A_s))/((-r_A)) $

También la podemos expresar en función de la fracción molar:

$ (V_s)/(F_(A_e)) = (x_(A_s) - x_(A_e))/((-r_A)) $

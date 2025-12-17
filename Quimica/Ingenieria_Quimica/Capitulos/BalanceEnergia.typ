#import "../../../plantilla.typ": *

== Energía y tipos de energía

Como dice la ley de conservación de la energía _*La energía ni se crea ni se destruye, sólo se transforma*_. En esta afirmación queda excluida la energía nuclear que se genera por desintegración de materia ($E=m dot c^2$).

#v(1em)

El principio de conservación de la energía constituye la _primera ley de la Termodinámica_ ($Delta U= Q+W$). Aplicando a un sistema material sometido a transformaciones físicas y químicas que transcurren en régimen no estacionario el balance de energía completa el balance de materia:

$ [E]-[S]+[G]=[A] $

Donde en el caso de la energía cada termino representa:

- $[E]$: Cantidad de energía recibida del exterior por el sistema.
- $[S]$: Cantidad de energía liberada al exterior por el sistema.
- $[G]$: Cantidad de energía generada en el interior del sistema.
- $[A]$: Cantidad de energía acumulada en el sistema. 

Trataremos diferentes tipos de sistemas:

+ *Sistema abierto*: en estos sistemas hablaremos de procesos continuos. El sistema permite la entrada y la salida de materia y energía ( $[E]eq.not 0$ y $[S]eq.not 0$.
+ *Sistema cerrado*: en estos sistemas hablaremos de procesos discontinuos. Se trata de un sistema que no permite la entrada y salida de materia pero si de energía.
+ *Sistema adiabático*: sistema que no intercambia materia y energía con los alrededores. ($[E]=0$ y$[S]=0$).


=== Clasificación de las energías 

También tenemos que tener claro las diferentes formas de expresión de la energía.Las expresiones matemáticas de cada una de estas formas de energía es diferente,  debiendo hacerse en función de las variables susceptibles de medida experimental.

#v(1em)

La *enerǵia electromagnética* incluye las diferentes manifestaciones de la energía debida a los campos electrostático y magnético y a la corriente electrica.  También trataremos la *energía química* que es la energía de los compuestos relacionada con las reacciones químicas. La *energía metabólica* es la energía generada por los organismos vivos por oxidaión de los alimentos digeridos. La *energía nuclear* es un caso particular de energía química, que está relacionada con las reacciones de fusión y fisión nuclear. 

#v(1em)

La *energía potencial* es función de la posición en el campo gravitatorio.

$ E_p=m dot g dot z $

Donde $m$ es la masa del cuerpo (kg), $z$ la altura respecto al nivel de referencia al que se le asigna una energía potencial nula y $g$ la aceleración de la gravedad. 

#v(1em)

La *energía cinética* es función de la velocidad:

$ E_c= K = (1)/(2) dot m dot v^2 $

Siendo $m$ la masa del cuerpo en kg y $v$ la velocidad del fluido el la sección transversal.

#v(1em)

Definimos  *energía mecánica* como la suma de la energía cinética y la energía potencial. Esta relacionada con la energía acumulada por un cuerpo en movimiento y la energía asociada a la localización de un cuerpo dontro de un campo de fuerza. 

$ E_("mecánica") = E_p+E_c $

#v(1em)

Otro tipo de energía es la *energía interna o energía térmica* que engloba la energía potencial y cinética internas de las particulas elementales de los cuerpos (moléculas, atomos), manifestándose al exterior en forma de temperatura. El contenido de energía interna de un cuerpo se corresponde con la suma de las energías potencial y cinética asocidas a las partículas elementales constituidas por el mismo, moléculas, átomos y partículas subatómicas. Se manifiesta a partir de la Temperatura.  

#v(1em)

Es función de la temperatura, de la concentración y del estado de agregación y prácticamente independiente de la presión  (no se puede calcular de forma absoluta, sólo diferencias).

$ U=m dot integral_(T_("ref"))^(T) C_p dot dif T=m dot{C_p} dot T-T_ ("ref") $

Para un cuerpo de masa $m $ (kg) que se encuentra a una temperatura $T$, $C_p$ es el calor especifico a volumen constante (J/kg$dot$K) y $T_("ref")$ es la temperatura de referencia considerada, habiendose asignado arbitrariamente un valor no nulo de la energóa interna en el estado de referencia considerado (i.e. $U_("ref")=0$). Es una función de estado (variable de estado).

=== Calor y Trabajo 

La transferencia de energía entre un sistema cerrado y sus alrededores puede darse en forme de calor o de trabajo (son formas de energía de transito: nunca se almacenan). El aporte de calor y/o trabajo son formas de aumentar su contenido en energía en alguna de sus formas anteriores (potencial, cinética o interna).

#v(1em)

El *calor (Q)* es la energía en tránsito debida a una diferencia de temperaturas entre un sistema y sus alrededores. Siempre se transmite del foco caliente al frio, sienso el gradiente de temperaturas la fuerza impulsora. Se representa en la @ec:calor donde $dot(U)$ es el coeficiente empírico ($"W" dot"m"^{-2} dot "K"^{-1}$.\\

$ Q= dot(U) dot A dot Delta T $ <ec:calor>

El *trabajo (W)* es la energía en tránsito debida a la acción de las fuerzas mecánicas que vencen una resistencia al recorrer un espacio, energía que fluye en respuesta a la aplicación de una fuerza. Sólo tiene sentido cuando se produce o se consume en un sistema determinado, no se puede hablar de contenido en trabajo. El trabajo se puede calcular como se muestra en la @ec:trabajo (el signo es negativo por que es el trabajo realizado por el sistema). El trabajo realizado por el sistema será negativo ($W<0$) y el trabajo realizado sobre el sistema positivo ($W>0$).

$  W=-integral_(v_1)^(v_2) P dot dif V $ <ec:trabajo>

La *entalpía (H)* es la combinación de dos variables que aparecen con mucha frecuencia en los balances de energía:

$ H=U+P dot V $
Tambien se puede calcular la entalpía específica  J/kg.

$ h=u+P  dot theta= u+ p/rho 
$

Donde $P$ es la presión, $V$ es el volumen ($"m"^3$), $theta$ es el volumen específico ($"m"^3/"kg"$).

#v(1em)

La entalpía es una función de estado (variable de estado), resultado de la combinación de la energía interna con una parte del trabajo que genera el sistema. $H$ es función de la temperatura, composición y estado de agregación.

#v(1em)

La entalpía no tiene un valor absoluto, al igual que la energía interna, solo se pueden evaluar cambios de entalpía ($Delta H$) y a menudo se utiliza un conjunto de condiciones de referencia.

=== Balances macroscópicos de energía

Como ya se mostro anteriormente la ecuación de balance de energía sigue la siguiente ecuación:

$ [E]-[S]+[G]=[A] $

Donde en el caso de la energía cada termino representa:

- $[E]$: Cantidad de energía recibida del exterior por el sistema.
- $[S]$: Cantidad de energía liberada al exterior por el sistema.
- $[G]$: Cantidad de energía generada en el interior del sistema.
- $[A]$: Cantidad de energía acumulada en el sistema. 


Los dos primeros términos representan la energía intercambiada con los alrededores. Podemos tener intercambio de trabajo debido a fuerzas mecánicas, transmisión de calor debido a un flujo de energía de el foco caliente al frio o transferencia de materia ya que la materia lleva asociada una cantidad de energía (potencial, cinética o interna).


#v(1em)


La cantidad de energía generado por el sistema (tercer término de la ecuación) se debe a las reacciones químicas que tienen lugar. La energía acumulada la expresaremos como $(dif E_{"total"))/(dif t)$.

#v(1em)

Recordemos que un *sistema cerrado*  es un sistema discontinuo (por lotes) en el cual si hay transferencia de energía con el exterior pero _no hay intercambio de materia_. La energía dentro del sistema se divide en tres categorias $E_c$, $E_p$ y $U$. La energía transportada a través de la frontera se puede hacer en forma de trabajo o calor. De modo que, la variación de energía del sistema:

$ Delta E=E_(t 2)-E_(t 1)= Delta U + Delta E_c + Delta E_p =Q+W $


Un *sistema abierto* es un sistema continuo por lo que existe una transferencia de materia. Recordemos la expresión del balance de materia obtenida en el Tema 2:

$  (dif (pi_m V))/(dif t)=- sum_i phi_i vec(S)_i+ pi_1 Q_(v,1)- pi_(2 Q_(V,2))+G_(m V) $

La energía asociada a la materia recordemos que es la energía interna $U$, la energía cinética $E_c$ y la energía potencial $E_p$. De modo que la energía del sistema.
$
    E=U+E_p+E_c+Q+W+ "Fuerzas de presión"
$
De modo que el balance energético será de la siguiente forma:

$
    (dif (U_T+E_(P,T)+E_(C,T)))/(dif t)=rho_1 dot Q_( v 1) dot (U+E_p+E_c)_1-rho_2 dot Q_(v 2) dot (U+E_p+E_c)_2+Q+W+[P_1Q_(v 1)-P_2 dot Q_(v 2)]
$

En un sistema en estado estacionario la acumulación de energía se anula de modo que $(dif E)/(dif t)=0$. Además tenemos que tener en cuenta que $m=rho dot Q_v$. De moso que para un sistema en estado estacionario podemos expresar la ecuación del balance de energía como:

$  0=m dot (U+E_p+E_c)_1-m dot (U+E_p+E_c)_2+Q+W+m [(P_1)/(rho_1)-(P_2)/(rho_2) ] $ <ec:conservacion_e>
 
Si sustituimos en esta ecuación las expresiones de la energía cinética ($E_c=1/2 dot m dot v^2$) y de la energía potencial ($E_p=m  dot g dot z$) llegamos a :

$
    g dot(z_1-z_2)+(U_1-U_2)+1/2 dot(v_1^2-v_2^2)+dot(Q)+dot(W)+((P_1))/(rho_1)-(P_2)/(rho_2))=0
$ 
Además sabemos que la entalpía se puede expresar como $H=U+P/rho$ por lo que sustituyendo llegamos a la *eccuación de conservación de energía en régimen estacionario*: 


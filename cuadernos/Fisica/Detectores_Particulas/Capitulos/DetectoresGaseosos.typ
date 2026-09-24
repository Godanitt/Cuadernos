#import "../../../../plantilla/cuaderno.typ": *

#chapter("Introducción")

#chapter("Detectores de Placas Paralelas")

#chapter("Contadores Proporcionales")

#chapter(text([MWPC (*_Multi-Wire Proportional Chambers_*)]))

== Introducción

El *MPWC* (_Multi-Wire Proportional Chambers_) está conformado por un conjunto de hilos que actúan como ánodos entre dos placas plano-paralelas @Charpak1968MWPC. Cuando se aplica una diferencia de potencial entre ánodos y cátodos aparece un campo eléctrico como el de la imagen #ref(<Fig:EfieldMPWC>).

#figure(
  image("../Imagenes/Detectores_Gaseosos/mwpc_field_lines.pdf", width: 50%),
  caption: [
    Líneas del Campo Eléctrico de un MWPC.
  ],
) <Fig:EfieldMPWC>

Las cargas que se generan por la ionización inicial en el gas derivan hacia los electrodos (iones al cátodo, electrones al ánodo). Cuando los electrones se acercan a los hilos se aceleran debido al aumento del campo eléctrico cerca de estos (recordamos que $ arrow(Ecal) prop 1/r$). Los electrones con la suficiente energía comenzarán a colisionar inelásticamente con los átomos o moléleculas del gas ionizándolos, creando pares electrón-ión. Estos nuevos pares se verán también acelerados, siendo este un proceso exponencial que continua hasta que los electrones llegan a los ánodos. El proceso de multiplicación comienza típicamente a una distancia de unos pocos radios del hilo, tal que el número de electrones que llegan a los hilos es proporcional a la ionización primaria en el gas. Eligiendo bien la geometría y los gases, las ganancias proporcionales pueden ser de hasta $10^6$, permitiendo la detección de muy pocas cargas primarias.

Los MPWC operan eficientemente con flujos radiativos de hasta $qty("1e-4", "mm^-2 s^-1")$ por lo que fueron adoptados rápidamente para instrumentar las nuevas generaciones de detectores en experimentos de física de partículas. Al inicio su principal limitación estaba en la separación de los hilos, de 1 a 2 mm, afectando a la resolución espacial. El desarrollo de nuevos métodos de lectura de señales en el cátodo permitieron resoluciones por debajo del milímetro. 

La subsecuente explotación de la medida del tiempo de deriva mejoro la resolución espacial incluso más, lo que hacía que estos detectores poseyeran la capacidad de hacer medidas en un gran volumes, bajo un flujo de radiación alto y a un costo moderado. Ejemplos avanzados de esto son los dispositivos cilíndricos llamados cámaras de deriva que operan a lo largo de aceleradores de partículas y las TPC (_Time Projection Chamber_). Estos MPWC de gran área fueron usados para detectar fotones UV en sistemas PID (_Particle IDentification_) basados en la tecnología RICH (_Cherenkov Ring Imaging_). 

La contribución innegable al campo de la física de partículas de estos detectores fue motivo principal del nobel galardonado al físico franco-polaco Georges Charpak en 1992. 

Pese a todo las mejoras en las capacidades de los detectores basados en hilos, la necesidad de buscar eventos raros, operar a flujos de partículas/radiación extremadamente altos, sorpasaron las capacidades de los MWPC (limitados por la lentitud de medida, dependiente del tiempo de deriva de electrones e iones). 


#chapter(text([MSGC (*_Microstrip Gas Chambers_*)]))

== Introducción

Pese a sus buenas cualidades, los detectores gaseosos basadso en hilos finos como elementos de amplificación dejaron de ser últiles por sus numerosas limitaciones. Los desplazamientos de los hilos e inestabilidades debido a las fuerzas electrostáticas, particularmente en los casos con los espaciados entre hilos más pequeños, pusieron un límite en la longitud máxima de los hilos: hasta 90 cm para espaciados de 2 mm, y 10 cm para espaciados de 1 mm. La solución eran soportes que disminuían las eficiencas de los detectores, y para grandes tamaños pesados soportes eran necesarios por efectos gravitatorios.

Una limitación aun mas importante para las estructuras basadas en hilos era su degradación por culpa de los iones generados en las avalanchas, que con una velocidad menor de deriva podían acumularse alrededor del ánodo. En los casos de grandes flujos radiativos, eta acumulación cerca del hilo generada _efecto espacio carga_, es decir, la carga positiva alteraba el campo eléctrico alrededor del hilo con una consecuente disminución de la carga. Para los típicas cámaras de hilos la ganancia caía a partir del flujo $qty("1e-4","mm^-2 s^-1")$, flujo fácilmente superado en la mayoría de experimentos. Además eran detectores extremadamente frágiles debido a la cantidad de miles de hilos extremadamente finos que poseían.

El *MSGC* (_Micro Strip Gas Counter_), dearrollado por Anton Oed en 1988, véase #ref(<Fig:MSGC>), consiste en una serie de tiras metálicas insertadas en un sustrato aislante y conectado alternativamene a anodos más finos y cátodos más anchos. Cuando se EfieldMPWCaplica una diferencia de voltaje entre los electrodos una estructura de campo se genera como en la imagen . 


#figure(
  image("../Imagenes/Detectores_Gaseosos/MSGC.png", width: 50%),
  caption: [
    _Micro Strip Gas Counter_ concebido por Oed.
  ],
) <Fig:MSGC>


#chapter(text([MPGD (*_Micro-Pattern Gaseous Detectors_*)]))

== GEM (*_Gas Electron Multiplier_*)

=== GEM
=== GEM Multicapa
=== THGEM

== Micromegas

=== Bulk Micromegas
=== Microbulk Micromegas
=== Micromegas Resistivas

== Detectores WELL

=== THWELL
=== RWELL
=== RPWELL
=== $mu$RWELL

== Otras Microestructuras

#chapter(text([RPC (*_Resistive Plate Chambers_*)]))

== RPC en Modo Avalancha
== RPC en Modo Streamer
== MRPC (*_Multi-gap Resistive Plate Chambers_*)

#chapter("Lectura Óptica de Detectores Gaseosos")

#chapter("Estabilidad, Descargas y Degradación")

#chapter("Ejemplos Concretos")

== PICOSEC
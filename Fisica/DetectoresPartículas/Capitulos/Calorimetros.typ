
#import "../../../plantilla.typ": *

== Introducción

El término "calorímetro" (del inglés _calorímeter_, literalmente, _heat measurement_), tiene su origen en la termodinámica. Una caloría se define como la cantidad de energía necesaria para calentar 1 g de agua 1ºC. Típicamente los calorímetros eran cajas aisladas termicamente que conteniean una substancia, en el que un termómetro daba la información de la temperatura. Conociendo el calor específico y la temperatura que ha aumentado la substancia, podríamos saber cuanta energía se le ha aportado (o sabiendo la temperatura y la energía, conocer el calor específico). Versiones de esto se siguen usando en física nuclear, por ejemplo para el ensayo de material fisionable, como el $" "^239"Pu"$, que tiene una tasa de producción de calor de $2 "mW/g"$. Así, un calorímetro podría proporcionar una medida adecuada de la masa de plutonio en una muestra, de una manera no invasiva. 

#v(1em)

En física nuclear y de partículas, la calorimetría se refiere a la detección de partículasy la medida de algunas de sus propiedades a través de su total absorción en el instrumento llamado *calorímetro*. Los calorímetros tienen una gran variedad, pero la mayoría tienen una característica común: que la partícula es destruida en el proceso de medida. La única excepción a esto son los muones. De hecho, que sean capaces de atravesar los calorímetros sin depositar una gran cantidad de energía es uno de las propiedades que permiten indentificar los muones. Otras partículas (neutrinos, algunas hipotéticas partículas de supersimetría) tampoco dejan trazas en los calorímetros, u otro detector. 

#v(1em)

En el proceso de absoción, casi toda la energía de las partículas se acaba conviertiendo en calor, aquí el término calorímetro. Sin embargo, las unidades de enerǵia envueltas en el proceso son muy diferentes a las que se suelen ver en los calorímetros de termodinámica. La partícula más energética en aceleradores de partículas modernos se mieden en $"TeV"$, mientras que 1 caloría ($4.18 "J"$) es equivalente a $10^7 "TeV"$. El aumento de la temperatura en un calorímetro de partículas es, por tanto, despreciable, y por tanto deben usarse otros métodos (Cerenkov, efectos atómicos, moleculares, centelleo...) para medir la energía de la partícula. 

#v(1em)

Sin embargo si es posible hay un tipo de detectores de partículas que explota estos efectos térmicos, en particular a partir de la transición de fase superconductor-conductor. Estos detectores se usan para fenómenos muy partículas donde cantidades ridículas de energías son transferidas. 

== Funcionalidades y Propiedades de los Calorímetros

=== Calorímetros en Experimentos de Partículas modernos

Los calorímetros miden la energía depositada por una partícula abosorbiéndola. Esto genera señales que son posibles medir como energía. Además estas señales nos dan información sobre estas partículas, y el tipo de evento que se ha producido dentro de él. Las señales producidas por el absorbente adecuado, podrán ser usadas para medir el 4-vector de las partículas, a partir de la distribución de energía depositada. Por otro lado, la masa de la partícula también puede ser medida: 

- El _método E/p_  la energía medida en el calorímetro es comparado con el momento medido en un rastreador (_tracker_) en un campo magnético. Este método solo funciona con partículas cargadas y (relativas) bajas energías. 
- Analizado el _perfil de energía depositado_. Este método es frecuentemente usado para identificar electrones, especialmente en aborbentes con un alto número atómico Z. Esto es porque los absorbentes con alto Z permiten duchas eletromagnéticas menos profundas y dispersas sobre el eje de la ducha que las duchas hadrónicas. Esta característica también es explotada en los _preshower detectors_.
- Midiendo la _estructura temporal_ de las señales calorimétricas.

Además de estos métodos, usados en general para la identificación de electrones, los calorímetros se usan para identificar muones y neutrinos. Los muones muy energéticos depositan una fracción muy pequeña de su energía y producen señales a través de todo el detector (una recta atraviesa el detector). Los neutrinos típicamente no interaccionan con el calorímetro. Si un neutrino muy energético es producido en un experimento de colisiones de haces, este fenómeno llevará a un desbalance en las energías depositdas en los dos hemisferios en el que un detector de ángulo sólido completo ($4pi$) puede medir. Esta no-coincidencia es lo que se conoce como _energía transversal faltante_, y llevó al descubrimiento del bosón _W_. 

== Propiedades Relevantes de los Calorímetros 

Las propiedades de los calorímetros deberían ser conocidas para entender el rol que pueden jugar en un experimento. Las propiedades más relevantes son: 

- La *resolución energética*. 
- El *tamaño*.
- La *velocidad de señal*. Esta propiedad es especialmente explotada en experimentos donde la tasa de eventos es muy alta, en particular si solo una fracción de dichos eventos está relacionada con el evento de interés. En los experimentos del LHC en el CERN, donde la fracción de eventos interesantes es $10^(-7)$ y hay una tasa de eventos 1 GHz. 

- La *hermiticidad*. 


== Tipos de Calorímetros

Frecuentemente se usa la distinción _calorímetro homogéneo_ y _calorímetros de muestreo_. En uno homogéneo, el volumen del detector es completamente sensible a las partículas y puede contribuir a la generación de señal. En uno de muestreo, las funciones de absorbente y generación de señal son ejercidos por materiales diferentes, llamados _medios pasivos_ y _activos_ respectivamente. El medio pasivo suele ser un medio altamente denso (hierro, cobre, plomo, uranio) y el medio activo algún material que genere luz o carga, que serán las señales del calorímetro. 

En algunos experimentos donde no hay aceleradores involucrados, los calorímetros pueden llegar a actuar _como fuente_ de partículas. Como ejemplo, se puede mencionar el gran detector Cerenkov de agua construido para buscar el decaimiento del protón o los cristales de gran pureza $""^76"Ge"$ y $""^136"Xe"$ líquido usados para estudiar el decaimiento--$beta beta$.

=== Calorímetros Electromagnéticos

=== Calorímetros Hadrónicos

=== Calorímetros Criogénicos

=== Calorímetros Naturales 

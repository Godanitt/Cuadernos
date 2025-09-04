import numpy as np
import matplotlib.pyplot as plt

# Definir la función ReLU
def relu(x):
    return np.maximum(0, x)

# Calcular valoresx
x = np.linspace(-10, 10, 400)
y_relu = relu(x)

# Graficar
plt.figure(figsize=(8, 5))
plt.plot(x, y_relu, label='ReLU(x)', color='blue')
plt.title('Función ReLU (Rectified Linear Unit)')
plt.xlabel('x')
plt.xlabel('x')
plt.ylabel('RELU(x)')
plt.grid(True,linestyle="--")
#plt.axhline(0, color='black', linewidth=0.5)
#plt.axhline(1, color='black', linewidth=0.5)
#plt.axvline(0, color='gray', linestyle='--', linewidth=0.8)
plt.legend()
plt.savefig("ReLU.pdf",bbox_inches="tight")
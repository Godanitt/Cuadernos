import numpy as np
import matplotlib.pyplot as plt

# Definir la función tangente hiperbólica
def tanh(x):
    return np.tanh(x)

# Calcular valores
x = np.linspace(-10, 10, 400)
y_tanh = tanh(x)

# Graficar
plt.figure(figsize=(8, 5))
plt.plot(x, y_tanh, label='tanh(x)', color='blue')
plt.title('Función Tangente Hiperbólica')
plt.xlabel('x')
plt.ylabel('tanh(x)')
plt.grid(True,linestyle="--")
plt.legend()
plt.savefig("Tanh.pdf",bbox_inches="tight")

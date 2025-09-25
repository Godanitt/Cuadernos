import numpy as np
import matplotlib.pyplot as plt

# Definir la función sigmoide
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# Rango de valores para x
x = np.linspace(-10, 10, 400)
y = sigmoid(x)

# Graficar
plt.figure(figsize=(8, 5))
plt.plot(x, y, label='Sigmoid(x)',color="blue")
#plt.title('Función Sigmoide')
plt.xlabel('x')
plt.ylabel('Sigmoid(x)')
plt.grid(True,linestyle="--")
#plt.axhline(0, color='black', linewidth=0.5)
#plt.axhline(1, color='black', linewidth=0.5)
#plt.axvline(0, color='gray', linestyle='--', linewidth=0.8)
plt.legend()
plt.savefig("Sigmoide.pdf",bbox_inches="tight")
"""
Mandelbrot fractal generator
    Author : Loïc Pottier
    Creation date : 24/02/2023
"""

def sequence(c):
    z = 0
    while True:
        yield z
        z = z ** 2 + c

for n, z in enumerate(sequence(c = 1)):
    print(f"z({n}) = {z}")
    if n >= 9:
        break
# Fractal generator
# Author : Loïc Pottier
# Creation date : 27/01/2022

# IMPORTS
import numpy as np
from PIL import Image
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.animation as animation

# CONSTANTS
DELAY = 1
MAX_ITER = 100

SAVE = True

formula = "z * z + c"

xRange=[-2, 2]
yRange=[-2, 2]
precision = 0.01

xLength = int((xRange[1] - xRange[0]) / precision)
yLength = int((yRange[1] - yRange[0]) / precision)

xStart = int(xRange[0]/precision)
xEnd = int(xRange[1]/precision)

yStart = int(yRange[0]/precision)
yEnd = int(yRange[1]/precision)

print(xLength, yLength)
print(xStart, xEnd)
print(yStart, yEnd)

def fractal() -> np.ndarray:
    # create a array filled with 0
    frac=np.zeros((yLength, xLength), dtype=int)

    # create a fractal
    for y in range(yStart, yEnd):
        
        for x in range(xStart, xEnd):
            yy = y*precision
            xx = x*precision
            c=complex(xx, yy)
            z=0
            for i in range(MAX_ITER):
                z=eval(formula)
                if abs(z)>2:
                    frac[y+int(yLength/2)][x+int(xLength/2)]=i
                    break
    return frac

# tranform the fractal array into an image and save it in the current directory
def saveImage():
    # create a new image
    data = Image.new("RGB", (xLength, xLength))

    # fill the image with the fractal
    for y in range(xLength):
        for x in range(xLength):
            data.putpixel((x, y), (frac[y][x]*16, frac[y][x]*16, frac[y][x]*16))

    data.save("./fractals/new.png")
    print("created fractal.png")

# update the fractal with a new real and imaginary value
def update(num, img):
    global real, im
    real+=-0.1
    im+=-0.1
    frac = fractal()
    img.set_data(frac)
    return img

if __name__ == "__main__":
   
    frac = fractal()

    if SAVE:
        saveImage()

    plt.rcParams["figure.autolayout"] = True
    manager = plt.get_current_fig_manager()
    manager.full_screen_toggle()
    plt.imshow(frac, cmap=mpl.colormaps['inferno'])
    plt.show()

    plt.show()
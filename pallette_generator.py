rgbCode = [[0, 0, 0], [0, 255, 255], [102, 0, 204], [128, 255, 0], [0, 0, 153],
           [255, 0, 0], [255, 51, 255], [153, 153, 0], [153, 255, 204], [160, 160, 160], [255, 128, 0], [0, 102, 102]]


# generate a new list of color by adding a new color between each color of the list
# the new color is the average of the two colors it is between in the list
# the new list is 2 times the length of the original list
# do the average between the last and first color in the list too 

def generateNewColors(rgbCode):
    newColors = []
    for i in range(len(rgbCode)):
        if i == len(rgbCode) - 1:
            newColors.append(rgbCode[i])
        else:
            newColors.append(rgbCode[i])
            newColors.append(averageColor(rgbCode[i], rgbCode[i + 1]))
    return newColors

# find the average of two colors
def averageColor(color1, color2):
    newColor = []
    for i in range(len(color1)):
        newColor.append(int((color1[i] + color2[i]) / 2))
    return newColor

test = generateNewColors(rgbCode)
test = generateNewColors(test)
test = generateNewColors(test)
test = generateNewColors(test)
test = generateNewColors(test)


print(test)
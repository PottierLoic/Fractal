rgbCode = [[4, 4, 73], [0, 7, 100], [12, 44, 138], [24, 82, 177], [57, 125, 209], [134, 181, 229], [211, 236, 248], [241, 233, 191], [248, 201, 95], [255, 170, 0], [204, 128, 0], [153, 87, 0], [106, 52, 3], [66, 30, 15], [25, 7, 26], [9, 1, 47]]


# generate a new list of colors
# for every color in the list, generate a new color bewtween it and the next color that is the average of the two
# repeat this process for the new color and the next color
def generateNewColors(rgbCode):
    newColors = []
    for i in range(len(rgbCode)):
        if i == len(rgbCode) - 1:
            newColors.append(rgbCode[i])
        else:
            newColors.append(rgbCode[i])
            newColors.append(averageColor(rgbCode[i], rgbCode[i + 1]))
    return newColors

# find the average of two colors, must be a int
def averageColor(color1, color2):
    newColor = []
    for i in range(len(color1)):
        newColor.append(int((color1[i] + color2[i]) / 2))
    return newColor

test = generateNewColors(rgbCode)
test = generateNewColors(test)
test = generateNewColors(test)

print(test)
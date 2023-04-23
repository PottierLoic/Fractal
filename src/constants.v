import gx

const (
	screen_width = 1920
	screen_height = 1080

	pwidth = 1920
	pheight = 1080

	fullscreen = true

	max_iterations = 1000

	smooth_coloring = false

	chunk_height = 2

	zoom_factor = 1.1
	auto_zoom = false
	auto_zoom_factor = 1.001

	auto_incr_real = true
	auto_incr_imag = true
	auto_incr_factor = 0.001

	// julia based fractal
	// some nice values :
	// a = 0.285, b = 0.0
	real_part = 0 
	imag_part = 0 

	// Colors
	black = u32(gx.black.abgr8())

	// wikipedia palette
	palette1 = generate_palette_n([[0, 7, 100], [32, 107, 203], [237, 255, 255], [255, 170, 0], [0, 2, 0], [0, 7, 100]], 6)
	
	// sun
	palette2 = generate_palette_n([[255, 255, 255], [255, 255, 0], [255, 0, 0], [255, 255, 255]], 5)
	
	// black and white
	palette3 = generate_palette_n([[255, 255, 255], [0, 0, 0], [255, 255, 255]], 7)

	// rainbow
	palette4 = [[51, 255, 255], [51, 255, 251], [51, 255, 248], [51, 255, 245], [51, 255, 242], [51, 255, 238], [51, 255, 235], [51, 255, 232], [51, 255, 229], [51, 255, 225], [51, 255, 222], [51, 255, 219], [51, 255, 216], [51, 255, 213], [51, 255, 210], [51, 255, 207], [51, 255, 204], [51, 255, 200], [51, 255, 197], [51, 255, 194], [51, 255, 191], [51, 255, 187], [51, 255, 184], [51, 255, 181], [51, 255, 178], [51, 255, 174], [51, 255, 171], [51, 255, 168], [51, 255, 165], [51, 255, 162], [51, 255, 159], [51, 255, 156], [51, 255, 153], [57, 251, 149], [63, 248, 146], [69, 245, 143], [76, 242, 140], [82, 238, 136], [89, 235, 133], [95, 232, 130], [102, 229, 127], [108, 225, 123], [114, 222, 120], [120, 219, 117], [127, 216, 114], [133, 213, 111], [140, 210, 108], [146, 207, 105], [153, 204, 102], [159, 200, 98], [165, 197, 95], [171, 194, 92], [178, 191, 89], [184, 187, 85], [191, 184, 82], [197, 181, 79], [204, 178, 76], [210, 174, 72], [216, 171, 69], [222, 168, 66], [229, 165, 63], [235, 162, 60], [242, 159, 57], [248, 156, 54], [255, 153, 51], [255, 148, 49], [255, 143, 47], [255, 138, 45], [255, 133, 44], [255, 128, 42], [255, 123, 41], [255, 118, 39], [255, 114, 38], [255, 109, 36], [255, 104, 34], [255, 99, 32], [255, 95, 31], [255, 90, 29], [255, 85, 28], [255, 80, 26], [255, 76, 25], [255, 71, 23], [255, 66, 21], [255, 61, 19], [255, 57, 18], [255, 52, 16], [255, 47, 15], [255, 42, 13], [255, 38, 12], [255, 33, 10], [255, 28, 9], [255, 23, 7], [255, 19, 6], [255, 14, 4], [255, 9, 3], [255, 4, 1], [255, 0, 0], [247, 0, 4], [239, 0, 9], [231, 0, 14], [223, 0, 19], [215, 0, 23], [207, 0, 28], [199, 0, 33], [191, 0, 38], [183, 0, 42], [175, 0, 47], [167, 0, 52], [159, 0, 57], [151, 0, 61], [143, 0, 66], [135, 0, 71], [127, 0, 76], [119, 0, 80], [111, 0, 85], [103, 0, 90], [95, 0, 95], [87, 0, 99], [79, 0, 104], [71, 0, 109], [63, 0, 114], [55, 0, 118], [47, 0, 123], [39, 0, 128], [31, 0, 133], [23, 0, 138], [15, 0, 143], [7, 0, 148], [0, 0, 153], [7, 0, 156], [15, 0, 159], [23, 0, 162], [31, 0, 165], [39, 0, 168], [47, 0, 171], [55, 0, 174], [63, 0, 178], [71, 0, 181], [79, 0, 184], [87, 0, 187], [95, 0, 191], [103, 0, 194], [111, 0, 197], [119, 0, 200], [127, 0, 204], [135, 0, 207], [143, 0, 210], [151, 0, 213], [159, 0, 216], [167, 0, 219], [175, 0, 222], [183, 0, 225], [191, 0, 229], [199, 0, 232], [207, 0, 235], [215, 0, 238], [223, 0, 242], [231, 0, 245], [239, 0, 248], [247, 0, 251], [255, 0, 255], [247, 0, 255], [239, 0, 255], [231, 0, 255], [223, 0, 255], [215, 0, 255], [207, 0, 255], [199, 0, 255], [191, 0, 255], [183, 0, 255], [175, 0, 255], [167, 0, 255], [159, 0, 255], [151, 0, 255], [143, 0, 255], [135, 0, 255], [127, 0, 255], [119, 0, 255], [111, 0, 255], [103, 0, 255], [95, 0, 255], [87, 0, 255], [79, 0, 255], [71, 0, 255], [63, 0, 255], [55, 0, 255], [47, 0, 255], [39, 0, 255], [31, 0, 255], [23, 0, 255], [15, 0, 255], [7, 0, 255], [0, 0, 255], [1, 7, 255], [3, 15, 255], [4, 23, 255], [6, 31, 255], [7, 39, 255], [9, 47, 255], [10, 55, 255], [12, 63, 255], [13, 71, 255], [15, 79, 255], [16, 87, 255], [18, 95, 255], [19, 103, 255], [21, 111, 255], [23, 119, 255], [25, 127, 255], [26, 135, 255], [28, 143, 255], [29, 151, 255], [31, 159, 255], [32, 167, 255], [34, 175, 255], [36, 183, 255], [38, 191, 255], [39, 199, 255], [41, 207, 255], [42, 215, 255], [44, 223, 255], [45, 231, 255], [47, 239, 255], [49, 247, 255], [51, 255, 255]]
	
	// dark and awful after
	palette5 = [[0, 0, 0], [0, 7, 7], [0, 15, 15], [0, 23, 23], [0, 31, 31], [0, 39, 39], [0, 47, 47], [0, 55, 55], [0, 63, 63], [0, 71, 71], [0, 79, 79], [0, 87, 87], [0, 95, 95], [0, 103, 103], [0, 111, 111], [0, 119, 119], [0, 127, 127], [0, 135, 135], [0, 143, 143], [0, 151, 151], [0, 159, 159], [0, 167, 167], [0, 175, 175], [0, 183, 183], [0, 191, 191], [0, 199, 199], [0, 207, 207], [0, 215, 215], [0, 223, 223], [0, 231, 231], [0, 239, 239], [0, 247, 247], [0, 255, 255], [3, 247, 253], [6, 239, 251], [9, 231, 249], [12, 223, 248], [15, 215, 246], [18, 207, 245], [21, 199, 243], [25, 191, 242], [28, 183, 240], [31, 175, 238], [34, 167, 236], [38, 159, 235], [41, 151, 233], [44, 143, 232], [47, 135, 230], [51, 127, 229], [54, 119, 227], [57, 111, 225], [60, 103, 223], [63, 95, 222], [66, 87, 220], [69, 79, 219], [72, 71, 217], [76, 63, 216], [79, 55, 214], [82, 47, 213], [85, 39, 211], [89, 31, 210], [92, 23, 208], [95, 15, 207], [98, 7, 205], [102, 0, 204], [102, 7, 197], [103, 15, 191], [104, 23, 184], [105, 31, 178], [105, 39, 171], [106, 47, 165], [107, 55, 159], [108, 63, 153], [108, 71, 146], [109, 79, 140], [110, 87, 133], [111, 95, 127], [112, 103, 120], [113, 111, 114], [114, 119, 108], [115, 127, 102], [115, 135, 95], [116, 143, 89], [117, 151, 82], [118, 159, 76], [118, 167, 69], [119, 175, 63], [120, 183, 57], [121, 191, 51], [121, 199, 44], [122, 207, 38], [123, 215, 31], [124, 223, 25], [125, 231, 18], [126, 239, 12], [127, 247, 6], [128, 255, 0], [124, 247, 4], [120, 239, 9], [116, 231, 14], [112, 223, 19], [108, 215, 23], [104, 207, 28], [100, 199, 33], [96, 191, 38], [92, 183, 42], [88, 175, 47], [84, 167, 52], [80, 159, 57], [76, 151, 61], [72, 143, 66], [68, 135, 71], [64, 127, 76], [60, 119, 80], [56, 111, 85], [52, 103, 90], [48, 95, 95], [44, 87, 99], [40, 79, 104], [36, 71, 109], [32, 63, 114], [28, 55, 118], [24, 47, 123], [20, 39, 128], [16, 31, 133], [12, 23, 138], [8, 15, 143], [4, 7, 148], [0, 0, 153], [7, 0, 148], [15, 0, 143], [23, 0, 138], [31, 0, 133], [39, 0, 128], [47, 0, 123], [55, 0, 118], [63, 0, 114], [71, 0, 109], [79, 0, 104], [87, 0, 99], [95, 0, 95], [103, 0, 90], [111, 0, 85], [119, 0, 80], [127, 0, 76], [135, 0, 71], [143, 0, 66], [151, 0, 61], [159, 0, 57], [167, 0, 52], [175, 0, 47], [183, 0, 42], [191, 0, 38], [199, 0, 33], [207, 0, 28], [215, 0, 23], [223, 0, 19], [231, 0, 14], [239, 0, 9], [247, 0, 4], [255, 0, 0], [255, 1, 7], [255, 3, 15], [255, 4, 23], [255, 6, 31], [255, 7, 39], [255, 9, 47], [255, 10, 55], [255, 12, 63], [255, 13, 71], [255, 15, 79], [255, 16, 87], [255, 18, 95], [255, 19, 103], [255, 21, 111], [255, 23, 119], [255, 25, 127], [255, 26, 135], [255, 28, 143], [255, 29, 151], [255, 31, 159], [255, 32, 167], [255, 34, 175], [255, 36, 183], [255, 38, 191], [255, 39, 199], [255, 41, 207], [255, 42, 215], [255, 44, 223], [255, 45, 231], [255, 47, 239], [255, 49, 247], [255, 51, 255], [251, 54, 247], [248, 57, 239], [245, 60, 231], [242, 63, 223], [238, 66, 215], [235, 69, 207], [232, 72, 199], [229, 76, 191], [225, 79, 183], [222, 82, 175], [219, 85, 167], [216, 89, 159], [213, 92, 151], [210, 95, 143], [207, 98, 135], [204, 102, 127], [200, 105, 119], [197, 108, 111], [194, 111, 103], [191, 114, 95], [187, 117, 87], [184, 120, 79], [181, 123, 71], [178, 127, 63], [174, 130, 55], [171, 133, 47], [168, 136, 39], [165, 140, 31], [162, 143, 23], [159, 146, 15], [156, 149, 7], [153, 153, 0], [153, 156, 6], [153, 159, 12], [153, 162, 18], [153, 165, 25], [153, 168, 31], [153, 171, 38], [153, 174, 44], [153, 178, 51], [153, 181, 57], [153, 184, 63], [153, 187, 69], [153, 191, 76], [153, 194, 82], [153, 197, 89], [153, 200, 95], [153, 204, 102], [153, 207, 108], [153, 210, 114], [153, 213, 120], [153, 216, 127], [153, 219, 133], [153, 222, 140], [153, 225, 146], [153, 229, 153], [153, 232, 159], [153, 235, 165], [153, 238, 171], [153, 242, 178], [153, 245, 184], [153, 248, 191], [153, 251, 197], [153, 255, 204], [153, 252, 202], [153, 249, 201], [153, 246, 199], [153, 243, 198], [153, 240, 196], [153, 237, 195], [153, 234, 194], [154, 231, 193], [154, 228, 191], [154, 225, 190], [154, 222, 188], [155, 219, 187], [155, 216, 185], [155, 213, 184], [155, 210, 183], [156, 207, 182], [156, 204, 180], [156, 201, 179], [156, 198, 177], [157, 195, 176], [157, 192, 174], [157, 189, 173], [157, 186, 172], [158, 183, 171], [158, 180, 169], [158, 177, 168], [158, 174, 166], [159, 171, 165], [159, 168, 163], [159, 165, 162], [159, 162, 161], [160, 160, 160], [162, 159, 155], [165, 158, 150], [168, 157, 145], [171, 156, 140], [174, 155, 135], [177, 154, 130], [180, 153, 125], [183, 152, 120], [186, 151, 115], [189, 150, 110], [192, 149, 105], [195, 148, 100], [198, 147, 95], [201, 146, 90], [204, 145, 85], [207, 144, 80], [210, 143, 75], [213, 142, 70], [216, 141, 65], [219, 140, 60], [222, 139, 55], [225, 138, 50], [228, 137, 45], [231, 136, 40], [234, 135, 35], [237, 134, 30], [240, 133, 25], [243, 132, 20], [246, 131, 15], [249, 130, 10], [252, 129, 5], [255, 128, 0], [247, 127, 3], [239, 126, 6], [231, 125, 9], [223, 124, 12], [215, 123, 15], [207, 122, 18], [199, 121, 21], [191, 121, 25], [183, 120, 28], [175, 119, 31], [167, 118, 34], [159, 118, 38], [151, 117, 41], [143, 116, 44], [135, 115, 47], [127, 115, 51], [119, 114, 54], [111, 113, 57], [103, 112, 60], [95, 111, 63], [87, 110, 66], [79, 109, 69], [71, 108, 72], [63, 108, 76], [55, 107, 79], [47, 106, 82], [39, 105, 85], [31, 105, 89], [23, 104, 92], [15, 103, 95], [7, 102, 98], [0, 102, 102]]
	
	palettes = [palette1, palette2, palette3, palette4, palette5]
)



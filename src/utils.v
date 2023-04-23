import math

// used to do a smooth color transition between two colors
fn linear_interpolation(color_a []int, color_b []int, ratio f64) (int, int, int) {
	mut r := int(math.floor(color_b[0] - color_a[0]) * ratio + color_a[0])
	mut g := int(math.floor(color_b[1] - color_a[1]) * ratio + color_a[1])
	mut b := int(math.floor(color_b[2] - color_a[2]) * ratio + color_a[2])
	return r, g, b
}

// add steps to the palette
fn generate_palette(list [][]int) [][]int {
	mut new_colors := [][]int{}
	for i := 0; i < list.len; i++ {
		if i == list.len - 1 {
			break
		}
		mut new_color := []int{}
		for j := 0; j < 3; j++ {
			new_color << (list[i][j] + list[i + 1][j]) / 2
		}
		new_colors << list[i]
		new_colors << new_color
	}
	new_colors << list[list.len - 1]
	return new_colors
}

// just call generate_palette n times
fn generate_palette_n(list [][]int, iter int) [][]int {
	mut new_palette := list.clone()
	for i := 0; i < iter; i++ {
		new_palette = generate_palette(new_palette)
	}
	return new_palette
}


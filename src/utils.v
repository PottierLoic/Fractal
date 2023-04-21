import math

// used by the smooth_coloring part
fn linear_interpolation(color_a []int, color_b []int, ratio f64) (int, int, int) {
	mut r := int(math.floor(color_b[0] - color_a[0]) * ratio + color_a[0])
	mut g := int(math.floor(color_b[1] - color_a[1]) * ratio + color_a[1])
	mut b := int(math.floor(color_b[2] - color_a[2]) * ratio + color_a[2])
	return r, g, b
}


import math
import gx


fn linear_interpolation(color_a u32, color_b u32, ratio f64) u32 {
	return u32((color_b - color_a) * ratio + color_a)
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
fn generate_palette_n(list [][]int, iter int) []u32 {
	mut new_palette := list.clone()
	for i := 0; i < iter; i++ {
		new_palette = generate_palette(new_palette)
	}

	mut u32_pal := []u32
	for rgb in new_palette {
		u32_pal << u32(gx.rgb(u8(rgb[0]), u8(rgb[1]), u8(rgb[2])).abgr8())
	}

	return u32_pal
}


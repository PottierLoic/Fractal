const rgb_code = [[102, 178, 255], [0, 255, 128], [255, 255, 102], [204, 229, 255]]

// add the average of each pair of color to the list between them
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

fn generate_palette_n(list [][]int, iter int) [][]int {
	mut new_palette := list.clone()
	for i := 0; i < iter; i++ {
		new_palette = generate_palette(new_palette)
	}
	return new_palette
}


import gg
import gx
import runtime
import time
import math

const pwidth = 1920

const pheight = 1080

const chunk_height = 2

const zoom_factor = 1.1

const auto_zoom_factor = 1.0001

const max_iterations = 500

// const palette = [[0, 0, 0], [0, 7, 7], [0, 15, 15], [0, 23, 23], [0, 31, 31], [0, 39, 39], [0, 47, 47], [0, 55, 55], [0, 63, 63], [0, 71, 71], [0, 79, 79], [0, 87, 87], [0, 95, 95], [0, 103, 103], [0, 111, 111], [0, 119, 119], [0, 127, 127], [0, 135, 135], [0, 143, 143], [0, 151, 151], [0, 159, 159], [0, 167, 167], [0, 175, 175], [0, 183, 183], [0, 191, 191], [0, 199, 199], [0, 207, 207], [0, 215, 215], [0, 223, 223], [0, 231, 231], [0, 239, 239], [0, 247, 247], [0, 255, 255], [3, 247, 253], [6, 239, 251], [9, 231, 249], [12, 223, 248], [15, 215, 246], [18, 207, 245], [21, 199, 243], [25, 191, 242], [28, 183, 240], [31, 175, 238], [34, 167, 236], [38, 159, 235], [41, 151, 233], [44, 143, 232], [47, 135, 230], [51, 127, 229], [54, 119, 227], [57, 111, 225], [60, 103, 223], [63, 95, 222], [66, 87, 220], [69, 79, 219], [72, 71, 217], [76, 63, 216], [79, 55, 214], [82, 47, 213], [85, 39, 211], [89, 31, 210], [92, 23, 208], [95, 15, 207], [98, 7, 205], [102, 0, 204], [102, 7, 197], [103, 15, 191], [104, 23, 184], [105, 31, 178], [105, 39, 171], [106, 47, 165], [107, 55, 159], [108, 63, 153], [108, 71, 146], [109, 79, 140], [110, 87, 133], [111, 95, 127], [112, 103, 120], [113, 111, 114], [114, 119, 108], [115, 127, 102], [115, 135, 95], [116, 143, 89], [117, 151, 82], [118, 159, 76], [118, 167, 69], [119, 175, 63], [120, 183, 57], [121, 191, 51], [121, 199, 44], [122, 207, 38], [123, 215, 31], [124, 223, 25], [125, 231, 18], [126, 239, 12], [127, 247, 6], [128, 255, 0], [124, 247, 4], [120, 239, 9], [116, 231, 14], [112, 223, 19], [108, 215, 23], [104, 207, 28], [100, 199, 33], [96, 191, 38], [92, 183, 42], [88, 175, 47], [84, 167, 52], [80, 159, 57], [76, 151, 61], [72, 143, 66], [68, 135, 71], [64, 127, 76], [60, 119, 80], [56, 111, 85], [52, 103, 90], [48, 95, 95], [44, 87, 99], [40, 79, 104], [36, 71, 109], [32, 63, 114], [28, 55, 118], [24, 47, 123], [20, 39, 128], [16, 31, 133], [12, 23, 138], [8, 15, 143], [4, 7, 148], [0, 0, 153], [7, 0, 148], [15, 0, 143], [23, 0, 138], [31, 0, 133], [39, 0, 128], [47, 0, 123], [55, 0, 118], [63, 0, 114], [71, 0, 109], [79, 0, 104], [87, 0, 99], [95, 0, 95], [103, 0, 90], [111, 0, 85], [119, 0, 80], [127, 0, 76], [135, 0, 71], [143, 0, 66], [151, 0, 61], [159, 0, 57], [167, 0, 52], [175, 0, 47], [183, 0, 42], [191, 0, 38], [199, 0, 33], [207, 0, 28], [215, 0, 23], [223, 0, 19], [231, 0, 14], [239, 0, 9], [247, 0, 4], [255, 0, 0], [255, 1, 7], [255, 3, 15], [255, 4, 23], [255, 6, 31], [255, 7, 39], [255, 9, 47], [255, 10, 55], [255, 12, 63], [255, 13, 71], [255, 15, 79], [255, 16, 87], [255, 18, 95], [255, 19, 103], [255, 21, 111], [255, 23, 119], [255, 25, 127], [255, 26, 135], [255, 28, 143], [255, 29, 151], [255, 31, 159], [255, 32, 167], [255, 34, 175], [255, 36, 183], [255, 38, 191], [255, 39, 199], [255, 41, 207], [255, 42, 215], [255, 44, 223], [255, 45, 231], [255, 47, 239], [255, 49, 247], [255, 51, 255], [251, 54, 247], [248, 57, 239], [245, 60, 231], [242, 63, 223], [238, 66, 215], [235, 69, 207], [232, 72, 199], [229, 76, 191], [225, 79, 183], [222, 82, 175], [219, 85, 167], [216, 89, 159], [213, 92, 151], [210, 95, 143], [207, 98, 135], [204, 102, 127], [200, 105, 119], [197, 108, 111], [194, 111, 103], [191, 114, 95], [187, 117, 87], [184, 120, 79], [181, 123, 71], [178, 127, 63], [174, 130, 55], [171, 133, 47], [168, 136, 39], [165, 140, 31], [162, 143, 23], [159, 146, 15], [156, 149, 7], [153, 153, 0], [153, 156, 6], [153, 159, 12], [153, 162, 18], [153, 165, 25], [153, 168, 31], [153, 171, 38], [153, 174, 44], [153, 178, 51], [153, 181, 57], [153, 184, 63], [153, 187, 69], [153, 191, 76], [153, 194, 82], [153, 197, 89], [153, 200, 95], [153, 204, 102], [153, 207, 108], [153, 210, 114], [153, 213, 120], [153, 216, 127], [153, 219, 133], [153, 222, 140], [153, 225, 146], [153, 229, 153], [153, 232, 159], [153, 235, 165], [153, 238, 171], [153, 242, 178], [153, 245, 184], [153, 248, 191], [153, 251, 197], [153, 255, 204], [153, 252, 202], [153, 249, 201], [153, 246, 199], [153, 243, 198], [153, 240, 196], [153, 237, 195], [153, 234, 194], [154, 231, 193], [154, 228, 191], [154, 225, 190], [154, 222, 188], [155, 219, 187], [155, 216, 185], [155, 213, 184], [155, 210, 183], [156, 207, 182], [156, 204, 180], [156, 201, 179], [156, 198, 177], [157, 195, 176], [157, 192, 174], [157, 189, 173], [157, 186, 172], [158, 183, 171], [158, 180, 169], [158, 177, 168], [158, 174, 166], [159, 171, 165], [159, 168, 163], [159, 165, 162], [159, 162, 161], [160, 160, 160], [162, 159, 155], [165, 158, 150], [168, 157, 145], [171, 156, 140], [174, 155, 135], [177, 154, 130], [180, 153, 125], [183, 152, 120], [186, 151, 115], [189, 150, 110], [192, 149, 105], [195, 148, 100], [198, 147, 95], [201, 146, 90], [204, 145, 85], [207, 144, 80], [210, 143, 75], [213, 142, 70], [216, 141, 65], [219, 140, 60], [222, 139, 55], [225, 138, 50], [228, 137, 45], [231, 136, 40], [234, 135, 35], [237, 134, 30], [240, 133, 25], [243, 132, 20], [246, 131, 15], [249, 130, 10], [252, 129, 5], [255, 128, 0], [247, 127, 3], [239, 126, 6], [231, 125, 9], [223, 124, 12], [215, 123, 15], [207, 122, 18], [199, 121, 21], [191, 121, 25], [183, 120, 28], [175, 119, 31], [167, 118, 34], [159, 118, 38], [151, 117, 41], [143, 116, 44], [135, 115, 47], [127, 115, 51], [119, 114, 54], [111, 113, 57], [103, 112, 60], [95, 111, 63], [87, 110, 66], [79, 109, 69], [71, 108, 72], [63, 108, 76], [55, 107, 79], [47, 106, 82], [39, 105, 85], [31, 105, 89], [23, 104, 92], [15, 103, 95], [7, 102, 98], [0, 102, 102]]

const palette = [[4, 4, 73], [3, 4, 76], [3, 4, 79], [2, 4, 82], [2, 5, 86], [1, 5, 89], [1, 6, 93], [0, 6, 96], [0, 7, 100], [1, 11, 104], [3, 16, 109], [4, 20, 114], [6, 25, 119], [7, 29, 123], [9, 34, 128], [10, 39, 133], [12, 44, 138], [13, 48, 142], [15, 53, 147], [16, 58, 152], [18, 63, 157], [19, 67, 162], [21, 72, 167], [22, 77, 172], [24, 82, 177], [28, 87, 181], [32, 92, 185], [36, 97, 189], [40, 103, 193], [44, 108, 197], [48, 114, 201], [52, 119, 205], [57, 125, 209], [66, 132, 211], [76, 139, 214], [85, 146, 216], [95, 153, 219], [104, 160, 221], [114, 167, 224], [124, 174, 226], [134, 181, 229], [143, 187, 231], [153, 194, 233], [162, 201, 235], [172, 208, 238], [181, 215, 240], [191, 222, 243], [201, 229, 245], [211, 236, 248], [214, 235, 240], [218, 235, 233], [222, 234, 226], [226, 234, 219], [229, 233, 212], [233, 233, 205], [237, 233, 198], [241, 233, 191], [241, 229, 179], [242, 225, 167], [243, 221, 155], [244, 217, 143], [245, 213, 131], [246, 209, 119], [247, 205, 107], [248, 201, 95], [248, 197, 83], [249, 193, 71], [250, 189, 59], [251, 185, 47], [252, 181, 35], [253, 177, 23], [254, 173, 11], [255, 170, 0], [248, 164, 0], [242, 159, 0], [235, 154, 0], [229, 149, 0], [222, 143, 0], [216, 138, 0], [210, 133, 0], [204, 128, 0], [197, 122, 0], [191, 117, 0], [184, 112, 0], [178, 107, 0], [171, 102, 0], [165, 97, 0], [159, 92, 0], [153, 87, 0], [147, 82, 0], [141, 78, 0], [135, 73, 0], [129, 69, 1], [123, 64, 1], [117, 60, 2], [111, 56, 2], [106, 52, 3], [101, 49, 4], [96, 46, 6], [91, 43, 7], [86, 41, 9], [81, 38, 10], [76, 35, 12], [71, 32, 13], [66, 30, 15], [60, 27, 16], [55, 24, 17], [50, 21, 18], [45, 18, 20], [40, 15, 21], [35, 12, 23], [30, 9, 24], [25, 7, 26], [23, 6, 28], [21, 5, 31], [19, 4, 33], [17, 4, 36], [15, 3, 38], [13, 2, 41], [11, 1, 44], [9, 1, 47]]

fn linear_interpolation(color_a []int, color_b []int, ratio f64) (int, int, int) {
	mut r := int(math.floor(color_b[0] - color_a[0]) * ratio + color_a[0])
	mut g := int(math.floor(color_b[1] - color_a[1]) * ratio + color_a[1])
	mut b := int(math.floor(color_b[2] - color_a[2]) * ratio + color_a[2])
	return r, g, b
}

struct ViewRect {
mut:
	x_min f64
	x_max f64
	y_min f64
	y_max f64
}

fn (v &ViewRect) width() f64 {
	return v.x_max - v.x_min
}

fn (v &ViewRect) height() f64 {
	return v.y_max - v.y_min
}

struct AppState {
mut:
	gg      &gg.Context = unsafe { nil }
	iidx    int
	pixels  &u32     = unsafe { vcalloc(pwidth * pheight * sizeof(u32)) }
	npixels &u32     = unsafe { vcalloc(pwidth * pheight * sizeof(u32)) }
	view    ViewRect = ViewRect{-3.55, 3.55, -2, 2}
	scale   int      = 1
	max_iter int 	 = max_iterations
	ntasks  int      = runtime.nr_jobs()
	changed_iter bool
	file_increment int
}

struct MandelChunk {
	cview ViewRect
	ymin  f64
	ymax  f64
}

fn (mut state AppState) update() {
	mut chunk_channel := chan MandelChunk{cap: state.ntasks}
	mut chunk_ready_channel := chan bool{cap: 1000}
	mut threads := []thread{cap: state.ntasks}
	defer {
		chunk_channel.close()
		threads.wait()
	}
	for t in 0 .. state.ntasks {
		threads << spawn state.worker(t, chunk_channel, chunk_ready_channel)
	}
	mut oview := ViewRect{}
	mut sw := time.new_stopwatch()
	for {
		sw.restart()
		cview := state.view
		if oview == cview && state.changed_iter == false{
			time.sleep(5 * time.millisecond)
			continue
		}
		// schedule chunks, describing the work:
		mut nchunks := 0
		for start := 0; start < pheight; start += chunk_height {
			chunk_channel <- MandelChunk{
				cview: cview
				ymin: start
				ymax: start + chunk_height
			}
			nchunks++
		}
		// wait for all chunks to be processed:
		for _ in 0 .. nchunks {
			_ := <-chunk_ready_channel
		}
		
		state.pixels, state.npixels = state.npixels, state.pixels
		println('${state.ntasks:2} threads; ${sw.elapsed().milliseconds():3} ms / frame; scale: ${state.scale:4}')
		oview = cview
	}
}

fn (mut state AppState) worker(id int, input chan MandelChunk, ready chan bool) {
	for {
		chunk := <-input or { break }
		yscale := chunk.cview.height() / pheight
		xscale := chunk.cview.width() / pwidth
		mut x, mut y, mut iter := 0.0, 0.0, 0.0
		mut y0 := chunk.ymin * yscale + chunk.cview.y_min
		mut x0 := chunk.cview.x_min
		mut r, g, b := 0.0, 0.0, 0.0
		mut log_zn, nu := 0.0, 0.0
		for y_pixel := chunk.ymin; y_pixel < chunk.ymax && y_pixel < pheight; y_pixel++ {
			yrow := unsafe { &state.npixels[int(y_pixel * pwidth)] }
			y0 += yscale
			x0 = chunk.cview.x_min
			for x_pixel := 0; x_pixel < pwidth; x_pixel++ {
				x0 += xscale
				x, y = x0, y0
				for iter = 0; iter < state.max_iter; iter++ {
					x, y = x * x - y * y + x0, 2 * x * y + y0
					if x * x + y * y > 500 {
						break
					}
				}
				unsafe {
					if iter >= state.max_iter {
						yrow[x_pixel] = u32(gx.black.abgr8())
					} else {
						log_zn = math.log(x*x + y*y) / 2
						nu = math.log(log_zn/math.log(2)) / math.log(2)
						iter += 1 - nu
						mut color_a := palette[math.abs(int(math.floor(iter)) % palette.len)]
						mut color_b := palette[math.abs(int(math.floor(iter + 1)) % palette.len)]
						r, g, b = linear_interpolation(color_a, color_b, math.abs(math.fmod(iter, 1)))
						yrow[x_pixel] = u32(gx.rgb(u8(r), u8(g), u8(b)).abgr8())
					}
				}
			}
		}
		ready <- true
	}
}

fn (mut state AppState) draw() {
	mut istream_image := state.gg.get_cached_image_by_idx(state.iidx)
	istream_image.update_pixel_data(state.pixels)
	size := gg.window_size()
	state.gg.draw_image(0, 0, size.width, size.height, istream_image)
}

fn (mut state AppState) zoom(zoom_factor f64) {
	c_x, c_y := (state.view.x_max + state.view.x_min) / 2, (state.view.y_max + state.view.y_min) / 2
	d_x, d_y := c_x - state.view.x_min, c_y - state.view.y_min
	state.view.x_min = c_x - zoom_factor * d_x
	state.view.x_max = c_x + zoom_factor * d_x
	state.view.y_min = c_y - zoom_factor * d_y
	state.view.y_max = c_y + zoom_factor * d_y
	state.scale += if zoom_factor < 1 { 1 } else { -1 }
}

fn (mut state AppState) increase_iteration() {
	state.max_iter+=5
	state.changed_iter = true
}

fn (mut state AppState) reduce_iteration() {
	if state.max_iter > 1 {
		state.max_iter-=5
		state.changed_iter = true
	}
	if state.max_iter < 1 {
		state.max_iter = 1
	}
}

fn (mut state AppState) center(s_x f64, s_y f64) {
	c_x, c_y := (state.view.x_max + state.view.x_min) / 2, (state.view.y_max + state.view.y_min) / 2
	d_x, d_y := c_x - state.view.x_min, c_y - state.view.y_min
	state.view.x_min = s_x - d_x
	state.view.x_max = s_x + d_x
	state.view.y_min = s_y - d_y
	state.view.y_max = s_y + d_y
}

// gg callbacks:

fn graphics_init(mut state AppState) {
	state.iidx = state.gg.new_streaming_image(pwidth, pheight, 4, pixel_format: .rgba8)
}

fn graphics_frame(mut state AppState) {
	state.gg.begin()
	state.zoom(2 - auto_zoom_factor)
	state.draw()
	state.gg.end()
}

fn graphics_click(x f32, y f32, btn gg.MouseButton, mut state AppState) {
	if btn == .right {
		size := gg.window_size()
		m_x := (x / size.width) * state.view.width() + state.view.x_min
		m_y := (y / size.height) * state.view.height() + state.view.y_min
		state.center(m_x, m_y)
	}
}

fn graphics_move(x f32, y f32, mut state AppState) {
	if state.gg.mouse_buttons.has(.left) {
		size := gg.window_size()
		d_x := (f64(state.gg.mouse_dx) / size.width) * state.view.width()
		d_y := (f64(state.gg.mouse_dy) / size.height) * state.view.height()
		state.view.x_min -= d_x
		state.view.x_max -= d_x
		state.view.y_min -= d_y
		state.view.y_max -= d_y
	}
}

fn graphics_scroll(e &gg.Event, mut state AppState) {
	state.zoom(if e.scroll_y < 0 { zoom_factor } else { 1 / zoom_factor })
}

fn graphics_keydown(code gg.KeyCode, mod gg.Modifier, mut state AppState) {
	if code == gg.KeyCode.kp_add {
		state.increase_iteration()
	}
	if code == gg.KeyCode.kp_subtract {
		state.reduce_iteration()
	}
}

fn main() {
	mut state := &AppState{}
	state.gg = gg.new_context(
		width: 1920
		height: 1080
		create_window: true
		window_title: 'The Mandelbrot Set'
		init_fn: graphics_init
		frame_fn: graphics_frame
		click_fn: graphics_click
		move_fn: graphics_move
		keydown_fn: graphics_keydown
		scroll_fn: graphics_scroll
		user_data: state
		fullscreen: false
	)

	spawn state.update()
	state.gg.run()
}
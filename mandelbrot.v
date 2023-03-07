import gg
import gx
import runtime
import time
import math

const pwidth = 1920

const pheight = 1080

const chunk_height = 2

const zoom_factor = 1.1

const auto_zoom_factor = 1.002

const max_iterations = 255

const palette = [[4, 4, 73], [3, 4, 76], [3, 4, 79], [2, 4, 82], [2, 5, 86], [1, 5, 89], [1, 6, 93], [0, 6, 96], [0, 7, 100], [1, 11, 104], [3, 16, 109], [4, 20, 114], [6, 25, 119], [7, 29, 123], [9, 34, 128], [10, 39, 133], [12, 44, 138], [13, 48, 142], [15, 53, 147], [16, 58, 152], [18, 63, 157], [19, 67, 162], [21, 72, 167], [22, 77, 172], [24, 82, 177], [28, 87, 181], [32, 92, 185], [36, 97, 189], [40, 103, 193], [44, 108, 197], [48, 114, 201], [52, 119, 205], [57, 125, 209], [66, 132, 211], [76, 139, 214], [85, 146, 216], [95, 153, 219], [104, 160, 221], [114, 167, 224], [124, 174, 226], [134, 181, 229], [143, 187, 231], [153, 194, 233], [162, 201, 235], [172, 208, 238], [181, 215, 240], [191, 222, 243], [201, 229, 245], [211, 236, 248], [214, 235, 240], [218, 235, 233], [222, 234, 226], [226, 234, 219], [229, 233, 212], [233, 233, 205], [237, 233, 198], [241, 233, 191], [241, 229, 179], [242, 225, 167], [243, 221, 155], [244, 217, 143], [245, 213, 131], [246, 209, 119], [247, 205, 107], [248, 201, 95], [248, 197, 83], [249, 193, 71], [250, 189, 59], [251, 185, 47], [252, 181, 35], [253, 177, 23], [254, 173, 11], [255, 170, 0], [248, 164, 0], [242, 159, 0], [235, 154, 0], [229, 149, 0], [222, 143, 0], [216, 138, 0], [210, 133, 0], [204, 128, 0], [197, 122, 0], [191, 117, 0], [184, 112, 0], [178, 107, 0], [171, 102, 0], [165, 97, 0], [159, 92, 0], [153, 87, 0], [147, 82, 0], [141, 78, 0], [135, 73, 0], [129, 69, 1], [123, 64, 1], [117, 60, 2], [111, 56, 2], [106, 52, 3], [101, 49, 4], [96, 46, 6], [91, 43, 7], [86, 41, 9], [81, 38, 10], [76, 35, 12], [71, 32, 13], [66, 30, 15], [60, 27, 16], [55, 24, 17], [50, 21, 18], [45, 18, 20], [40, 15, 21], [35, 12, 23], [30, 9, 24], [25, 7, 26], [23, 6, 28], [21, 5, 31], [19, 4, 33], [17, 4, 36], [15, 3, 38], [13, 2, 41], [11, 1, 44], [9, 1, 47]]


// const palette = [[255, 255, 255], [250, 255, 255], [245, 255, 255], [240, 255, 255], [235, 255, 255], [230, 255, 255], [225, 255, 255], [220, 255, 255], [215, 255, 255], [210, 255, 255], [205, 255, 255], [200, 255, 255], [195, 255, 255], [190, 255, 255], [185, 255, 255], [180, 255, 255], [175, 255, 255], [170, 255, 255], [165, 255, 255], [160, 255, 255], [155, 255, 255], [150, 255, 255], [145, 255, 255], [140, 255, 255], [135, 255, 255], [130, 255, 255], [125, 255, 255], [120, 255, 255], [115, 255, 255], [110, 255, 255], [105, 255, 255], [100, 255, 255], [95, 255, 255], [90, 255, 255], [85, 255, 255], [80, 255, 255], [75, 255, 255], [70, 255, 255], [65, 255, 255], [60, 255, 255], [55, 255, 255], [50, 255, 255], [45, 255, 255], [40, 255, 255], [35, 255, 255], [30, 255, 255], [25, 255, 255], [20, 255, 255], [15, 255, 255], [10, 255, 255], [5, 255, 255], [0, 255, 255], 
// 				 [0, 250, 255], [0, 245, 255], [0, 240, 255], [0, 235, 255], [0, 230, 255], [0, 225, 255], [0, 220, 255], [0, 215, 255], [0, 210, 255], [0, 205, 255], [0, 200, 255], [0, 195, 255], [0, 190, 255], [0, 185, 255], [0, 180, 255], [0, 175, 255], [0, 170, 255], [0, 165, 255], [0, 160, 255], [0, 155, 255], [0, 150, 255], [0, 145, 255], [0, 140, 255], [0, 135, 255], [0, 130, 255], [0, 125, 255], [0, 120, 255], [0, 115, 255], [0, 110, 255], [0, 105, 255], [0, 100, 255], [0, 95, 255], [0, 90, 255], [0, 85, 255], [0, 80, 255], [0, 75, 255], [0, 70, 255], [0, 65, 255], [0, 60, 255], [0, 55, 255], [0, 50, 255], [0, 45, 255], [0, 40, 255], [0, 35, 255], [0, 30, 255], [0, 25, 255], [0, 20, 255], [0, 15, 255], [0, 10, 255], [0, 5, 255], [0, 0, 255], 
// 				 [5, 0, 255], [10, 0, 255], [15, 0, 255], [20, 0, 255], [25, 0, 255], [30, 0, 255], [35, 0, 255], [40, 0, 255], [45, 0, 255], [50, 0, 255], [55, 0, 255], [60, 0, 255], [65, 0, 255], [70, 0, 255], [75, 0, 255], [80, 0, 255], [85, 0, 255], [90, 0, 255], [95, 0, 255], [100, 0, 255], [105, 0, 255], [110, 0, 255], [115, 0, 255], [120, 0, 255], [125, 0, 255], [130, 0, 255], [135, 0, 255], [140, 0, 255], [145, 0, 255], [150, 0, 255], [155, 0, 255], [160, 0, 255], [165, 0, 255], [170, 0, 255], [175, 0, 255], [180, 0, 255], [185, 0, 255], [190, 0, 255], [195, 0, 255], [200, 0, 255], [205, 0, 255], [210, 0, 255], [215, 0, 255], [220, 0, 255], [225, 0, 255], [230, 0, 255], [235, 0, 255], [240, 0, 255], [245, 0, 255], [250, 0, 255], 
// 				 [255, 0, 255], [255, 0, 250], [255, 0, 245], [255, 0, 240], [255, 0, 235], [255, 0, 230], [255, 0, 225], [255, 0, 220], [255, 0, 215], [255, 0, 210], [255, 0, 205], [255, 0, 200], [255, 0, 195], [255, 0, 190], [255, 0, 185], [255, 0, 180], [255, 0, 175], [255, 0, 170], [255, 0, 165], [255, 0, 160], [255, 0, 155], [255, 0, 150], [255, 0, 145], [255, 0, 140], [255, 0, 135], [255, 0, 130], [255, 0, 125], [255, 0, 120], [255, 0, 115], [255, 0, 110], [255, 0, 105], [255, 0, 100], [255, 0, 95], [255, 0, 90], [255, 0, 85], [255, 0, 80], [255, 0, 75], [255, 0, 70], [255, 0, 65], [255, 0, 60], [255, 0, 55], [255, 0, 50], [255, 0, 45], [255, 0, 40], [255, 0, 35], [255, 0, 30], [255, 0, 25], [255, 0, 20], [255, 0, 15], [255, 0, 10], [255, 0, 5], [255, 0, 0], 
// 				 [255, 5, 0], [255, 10, 0], [255, 15, 0], [255, 20, 0], [255, 25, 0], [255, 30, 0], [255, 35, 0], [255, 40, 0], [255, 45, 0], [255, 50, 0], [255, 55, 0], [255, 60, 0], [255, 65, 0], [255, 70, 0], [255, 75, 0], [255, 80, 0], [255, 85, 0], [255, 90, 0], [255, 95, 0], [255, 100, 0], [255, 105, 0], [255, 110, 0], [255, 115, 0], [255, 120, 0], [255, 125, 0], [255, 130, 0], [255, 135, 0], [255, 140, 0], [255, 145, 0], [255, 150, 0], [255, 155, 0], [255, 160, 0], [255, 165, 0], [255, 170, 0], [255, 175, 0], [255, 180, 0], [255, 185, 0], [255, 190, 0], [255, 195, 0], [255, 200, 0], [255, 205, 0], [255, 210, 0], [255, 215, 0], [255, 220, 0], [255, 225, 0], [255, 230, 0], [255, 235, 0], [255, 240, 0], [255, 245, 0], [255, 250, 0], [255, 255, 0], 
// 				 [255, 255, 5], [255, 255, 10], [255, 255, 15], [255, 255, 20], [255, 255, 25], [255, 255, 30], [255, 255, 35], [255, 255, 40], [255, 255, 45], [255, 255, 50], [255, 255, 55], [255, 255, 60], [255, 255, 65], [255, 255, 70], [255, 255, 75], [255, 255, 80], [255, 255, 85], [255, 255, 90], [255, 255, 95], [255, 255, 100], [255, 255, 105], [255, 255, 110], [255, 255, 115], [255, 255, 120], [255, 255, 125], [255, 255, 130], [255, 255, 135], [255, 255, 140], [255, 255, 145], [255, 255, 150], [255, 255, 155], [255, 255, 160], [255, 255, 165], [255, 255, 170], [255, 255, 175], [255, 255, 180], [255, 255, 185], [255, 255, 190], [255, 255, 195], [255, 255, 200], [255, 255, 205], [255, 255, 210], [255, 255, 215], [255, 255, 220], [255, 255, 225], [255, 255, 230], [255, 255, 235], [255, 255, 240], [255, 255, 245], [255, 255, 250], [255, 255, 255]]


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
}
// good color, i leave it here in case i need it
//const colors =[gx.rgb(255, 255, 255), gx.rgb(245, 255, 255), gx.rgb(235, 255, 255), gx.rgb(225, 255, 255), gx.rgb(215, 255, 255), gx.rgb(205, 255, 255), gx.rgb(195, 255, 255), gx.rgb(185, 255, 255), gx.rgb(175, 255, 255), gx.rgb(165, 255, 255), gx.rgb(155, 255, 255), gx.rgb(145, 255, 255), gx.rgb(135, 255, 255), gx.rgb(125, 255, 255), gx.rgb(115, 255, 255), gx.rgb(105, 255, 255), gx.rgb(95, 255, 255), gx.rgb(85, 255, 255), gx.rgb(75, 255, 255), gx.rgb(65, 255, 255), gx.rgb(55, 255, 255), gx.rgb(45, 255, 255), gx.rgb(35, 255, 255), gx.rgb(25, 255, 255), gx.rgb(15, 255, 255), gx.rgb(5, 255, 255), gx.rgb(0, 255, 255), gx.rgb(0, 245, 255), gx.rgb(0, 235, 255), gx.rgb(0, 225, 255), gx.rgb(0, 215, 255), gx.rgb(0, 205, 255), gx.rgb(0, 195, 255), gx.rgb(0, 185, 255), gx.rgb(0, 175, 255), gx.rgb(0, 165, 255), gx.rgb(0, 155, 255), gx.rgb(0, 145, 255), gx.rgb(0, 135, 255), gx.rgb(0, 125, 255), gx.rgb(0, 115, 255), gx.rgb(0, 105, 255), gx.rgb(0, 95, 255), gx.rgb(0, 85, 255), gx.rgb(0, 75, 255), gx.rgb(0, 65, 255), gx.rgb(0, 55, 255), gx.rgb(0, 45, 255), gx.rgb(0, 35, 255), gx.rgb(0, 25, 255), gx.rgb(0, 15, 255), gx.rgb(0, 5, 255), gx.rgb(0, 0, 255), gx.rgb(5, 0, 255), gx.rgb(15, 0, 255), gx.rgb(25, 0, 255), gx.rgb(35, 0, 255), gx.rgb(45, 0, 255), gx.rgb(55, 0, 255), gx.rgb(65, 0, 255), gx.rgb(75, 0, 255), gx.rgb(85, 0, 255), gx.rgb(95, 0, 255), gx.rgb(105, 0, 255), gx.rgb(115, 0, 255), gx.rgb(125, 0, 255), gx.rgb(135, 0, 255), gx.rgb(145, 0, 255), gx.rgb(155, 0, 255), gx.rgb(165, 0, 255), gx.rgb(175, 0, 255), gx.rgb(185, 0, 255), gx.rgb(195, 0, 255), gx.rgb(205, 0, 255), gx.rgb(215, 0, 255), gx.rgb(225, 0, 255), gx.rgb(235, 0, 255), gx.rgb(245, 0, 255), gx.rgb(255, 0, 255), gx.rgb(255, 0, 245), gx.rgb(255, 0, 235), gx.rgb(255, 0, 225), gx.rgb(255, 0, 215), gx.rgb(255, 0, 205), gx.rgb(255, 0, 195), gx.rgb(255, 0, 185), gx.rgb(255, 0, 175), gx.rgb(255, 0, 165), gx.rgb(255, 0, 155), gx.rgb(255, 0, 145), gx.rgb(255, 0, 135), gx.rgb(255, 0, 125), gx.rgb(255, 0, 115 ), gx.rgb(255, 0, 105), gx.rgb(255, 0, 95), gx.rgb(255, 0, 85), gx.rgb(255, 0, 75), gx.rgb(255, 0, 65), gx.rgb(255, 0, 55), gx.rgb(255, 0, 45), gx.rgb(255, 0, 35), gx.rgb(255, 0, 25), gx.rgb(255, 0, 15), gx.rgb(255, 0, 5), gx.rgb(255, 0, 0), gx.rgb(255, 5, 0), gx.rgb(255, 15, 0), gx.rgb(255, 25, 0), gx.rgb(255, 35, 0), gx.rgb(255, 45, 0), gx.rgb(255, 55, 0), gx.rgb(255, 65, 0), gx.rgb(255, 75, 0), gx.rgb(255, 85, 0), gx.rgb(255, 95, 0), gx.rgb(255, 105, 0), gx.rgb(255, 115, 0), gx.rgb(255, 125, 0), gx.rgb(255, 135, 0), gx.rgb(255, 145, 0), gx.rgb(255, 155, 0), gx.rgb(255, 165, 0), gx.rgb(255, 175, 0), gx.rgb(255, 185, 0), gx.rgb(255, 195, 0), gx.rgb(255, 205, 0), gx.rgb(255, 215, 0), gx.rgb(255, 225, 0), gx.rgb(255, 235, 0), gx.rgb(255, 245, 0), gx.rgb(255, 255, 0), gx.rgb(255, 255, 10), gx.rgb(255, 255, 20), gx.rgb(255, 255, 30), gx.rgb(255, 255, 40), gx.rgb(255, 255, 50), gx.rgb(255, 255, 60), gx.rgb(255, 255, 70), gx.rgb(255, 255, 80), gx.rgb(255, 255, 90), gx.rgb(255, 255, 100), gx.rgb(255, 255, 110), gx.rgb(255, 255, 120), gx.rgb(255, 255, 130), gx.rgb(255, 255, 140), gx.rgb(255, 255, 150), gx.rgb(255, 255, 160), gx.rgb(255, 255, 170), gx.rgb(255, 255, 180), gx.rgb(255, 255, 190), gx.rgb(255, 255, 200), gx.rgb(255, 255, 210), gx.rgb(255, 255, 220), gx.rgb(255, 255, 230), gx.rgb(255, 255, 240), gx.rgb(255, 255, 250), gx.rgb(255, 255, 255)].map(u32(it.abgr8()))

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
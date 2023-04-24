import math

fn (mut app App) mandelbrot(id int, input chan Chunk, ready chan bool) {
	for {
		chunk := <-input or { break }
		xscale := chunk.cview.width() / pwidth
		yscale := chunk.cview.height() / pheight
		mut x, mut y, mut iter := 0.0, 0.0, 0.0
		mut x0 := chunk.cview.x_min
		mut y0 := chunk.ymin * yscale + chunk.cview.y_min
		mut log_zn, nu := 0.0, 0.0
		len := app.palette.len
		for y_pixel := chunk.ymin; y_pixel < chunk.ymax && y_pixel < pheight; y_pixel++ {
			yrow := unsafe { &app.npixels[int(y_pixel * pwidth)] }
			y0 += yscale
			x0 = chunk.cview.x_min
			for x_pixel := 0; x_pixel < pwidth; x_pixel++ {
				x0 += xscale
				x, y = 0.0, 0.0
				for iter = 0; iter < app.max_iter; iter++ {
					x, y = x * x - y * y + x0, 2 * x * y + y0
					if x * x + y * y > 100 {
						break
					}
				}
				unsafe {
					if iter >= app.max_iter {
						yrow[x_pixel] = black
					} else {
						if smooth_coloring == true {
							log_zn = math.log(x*x + y*y) / 2
							nu = math.log(log_zn/math.log(2)) / math.log(2)
							iter += 1 - nu
							mut color_a := app.palette[math.abs(int(math.floor(iter)) % len)]
							mut color_b := app.palette[math.abs(int(math.floor(iter + 1)) % len)]
							yrow[x_pixel] = linear_interpolation(color_a, color_b, math.abs(math.fmod(iter, 1)))
						} else {
							yrow[x_pixel] = app.palette[int(iter)%len]
						}
					}
				}
			}
		}
		ready <- true
	}
}


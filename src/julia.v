import math
import gx

fn (mut app App) julia(id int, input chan Chunk, ready chan bool) {
	for {
		chunk := <-input or { break }
		yscale := chunk.cview.height() / pheight
		xscale := chunk.cview.width() / pwidth
		mut iter := 0.0
		mut x := chunk.ymin * yscale + chunk.cview.y_min
		mut y := chunk.cview.x_min
		mut cx := real_part
		mut cy := imag_part
		mut tempx := x
		mut tempy := y
		for y_pixel := chunk.ymin; y_pixel < chunk.ymax && y_pixel < pheight; y_pixel++ {
			yrow := unsafe { &app.npixels[int(y_pixel * pwidth)] }
			y = tempy + yscale
			tempy = y
			x = chunk.cview.x_min
			for x_pixel := 0; x_pixel < pwidth; x_pixel++ {
				x = tempx + xscale
				tempx = x
				for iter = 0; iter < app.max_iter; iter++ {
					x, y = x * x - y * y + cx, 2 * x * y + cy
					if x * x + y * y > 500 {
						break
					}
				}
				unsafe {
					if iter >= app.max_iter {
						yrow[x_pixel] = u32(gx.black.abgr8())
					} else {
						yrow[x_pixel] = u32(gx.rgb(u8(palette[int(iter)%palette.len][0]), u8(palette[int(iter)%palette.len][1]), u8(palette[int(iter)%palette.len][2])).abgr8())
					}
				}
			}
		}
		ready <- true
	}
}

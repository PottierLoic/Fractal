import gg
import time
import runtime

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

struct App {
mut:
	gg      &gg.Context = unsafe { nil }
	iidx    int
	pixels  &u32     = unsafe { vcalloc(pwidth * pheight * sizeof(u32)) }
	npixels &u32     = unsafe { vcalloc(pwidth * pheight * sizeof(u32)) }
	view    ViewRect = ViewRect{-3.55, 3.55, -2, 2}
	scale   int      = 1
	max_iter int 	 = max_iterations
	real_part f64	 = real_part
	imag_part f64	 = imag_part
	ntasks  int      = runtime.nr_jobs()
	changed bool
	fractal_type string = 'mandelbrot'
	color_palette int
	palette [][]int = palettes[0]
}

struct Chunk {
	cview ViewRect
	ymin  f64
	ymax  f64
}

fn (mut app App) update() {
	mut chunk_channel := chan Chunk{cap: app.ntasks}
	mut chunk_ready_channel := chan bool{cap: 1000}
	mut threads := []thread{cap: app.ntasks}
	primal_type := app.fractal_type
	defer {
		chunk_channel.close()
		threads.wait()
	}
	for t in 0 .. app.ntasks {
		match app.fractal_type {
			'mandelbrot' { threads << spawn app.mandelbrot(t, chunk_channel, chunk_ready_channel) }
			'julia' { threads << spawn app.julia(t, chunk_channel, chunk_ready_channel) }
			else { panic ('this type of fractal is not supported : ${app.fractal_type}')}
		}
	}
	mut oview := ViewRect{}
	mut sw := time.new_stopwatch()
	for {
		sw.restart()
		cview := app.view
		if oview == cview && app.changed == false{
			time.sleep(5 * time.millisecond)
			continue
		}
		// schedule chunks, describing the work:
		mut nchunks := 0
		for start := 0; start < pheight; start += chunk_height {
			chunk_channel <- Chunk{
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
		
		app.pixels, app.npixels = app.npixels, app.pixels
		app.changed = false
		println('${app.ntasks:2} threads; ${sw.elapsed().milliseconds():3} ms / frame; scale: ${app.scale:4}')
		oview = cview
		if primal_type != app.fractal_type {
			break
		}
	}
}


fn (mut app App) draw() {
	mut istream_image := app.gg.get_cached_image_by_idx(app.iidx)
	istream_image.update_pixel_data(app.pixels)
	size := gg.window_size()
	app.gg.draw_image(0, 0, size.width, size.height, istream_image)
}

fn (mut app App) zoom(zoom_factor f64) {
	c_x, c_y := (app.view.x_max + app.view.x_min) / 2, (app.view.y_max + app.view.y_min) / 2
	d_x, d_y := c_x - app.view.x_min, c_y - app.view.y_min
	app.view.x_min = c_x - zoom_factor * d_x
	app.view.x_max = c_x + zoom_factor * d_x
	app.view.y_min = c_y - zoom_factor * d_y
	app.view.y_max = c_y + zoom_factor * d_y
	app.scale += if zoom_factor < 1 { 1 } else { -1 }
}

fn (mut app App) center(s_x f64, s_y f64) {
	c_x, c_y := (app.view.x_max + app.view.x_min) / 2, (app.view.y_max + app.view.y_min) / 2
	d_x, d_y := c_x - app.view.x_min, c_y - app.view.y_min
	app.view.x_min = s_x - d_x
	app.view.x_max = s_x + d_x
	app.view.y_min = s_y - d_y
	app.view.y_max = s_y + d_y
}

fn graphics_init(mut app App) {
	app.iidx = app.gg.new_streaming_image(pwidth, pheight, 4, pixel_format: .rgba8)
}

fn frame(mut app App) {
	app.gg.begin()
	if auto_zoom == true {
		app.zoom(2 - auto_zoom_factor)
	}
	app.draw()
	app.gg.end()
}

fn click(x f32, y f32, btn gg.MouseButton, mut app App) {
	if btn == .right {
		size := gg.window_size()
		m_x := (x / size.width) * app.view.width() + app.view.x_min
		m_y := (y / size.height) * app.view.height() + app.view.y_min
		app.center(m_x, m_y)
	}
}

fn move(x f32, y f32, mut app App) {
	if app.gg.mouse_buttons.has(.left) {
		size := gg.window_size()
		d_x := (f64(app.gg.mouse_dx) / size.width) * app.view.width()
		d_y := (f64(app.gg.mouse_dy) / size.height) * app.view.height()
		app.view.x_min -= d_x
		app.view.x_max -= d_x
		app.view.y_min -= d_y
		app.view.y_max -= d_y
	}
}

fn scroll(e &gg.Event, mut app App) {
	app.zoom(if e.scroll_y < 0 { zoom_factor } else { 1 / zoom_factor })
}

fn keydown(code gg.KeyCode, mod gg.Modifier, mut app App) {
	match code {
		.kp_add { 
			app.max_iter+=5
			app.changed = true
		 }
		.kp_subtract { 
			if app.max_iter > 5 {
				app.max_iter-=5
				app.changed = true
	}
		}
		.enter {
			if app.fractal_type == 'mandelbrot' {
				app.fractal_type = 'julia'
			} else {app.fractal_type = 'mandelbrot' }
				spawn app.update()
		}
		.up {
			app.imag_part += 0.001
			app.changed = true
		}
		.down {
			app.imag_part -= 0.001
			app.changed = true
		}
		.right {
			app.real_part += 0.001
			app.changed = true
		}
		.left {
			app.real_part -= 0.001
			app.changed = true
		}
		.space {
			app.color_palette += 1
			if app.color_palette >= palettes.len { app.color_palette = 0 }
			app.palette = palettes[app.color_palette]
			app.changed = true
		}
		else {}
	}
}

fn main() {
	mut app := &App{}
	app.gg = gg.new_context(
		width: screen_width
		height: screen_height
		create_window: true
		window_title: 'Fractal explorer'
		init_fn: graphics_init
		frame_fn: frame
		click_fn: click
		move_fn: move
		keydown_fn: keydown
		scroll_fn: scroll
		user_data: app
		fullscreen: fullscreen
	)

	spawn app.update()
	app.gg.run()
}
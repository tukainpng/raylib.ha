use fmt;
use strconv;
use types::c;
use raylib::*;
use gruvbox::*;

const SPEED: f32 = 200.0;

export fn main() void = {

	let bg         = get_color(bg0);
	let fg         = get_color(fg1);

	let red        = get_color(red0);
	let green      = get_color(green0);
	let yellow     = get_color(yellow0);
	let blue       = get_color(blue0);
	let purple     = get_color(purple0);
	let aqua       = get_color(aqua0);
	let orange     = get_color(orange0);

	let x: f32 = 0.0;
	let y: f32 = 0.0;

	let size_x: f32 = 30.0;
	let size_y: f32 = 30.0;

	let square_color = green;
	let square_size_x: f32 = 30.0;
	let square_size_y: f32 = 30.0;

	let mouse_square_color = aqua;

	let first_axis_square_color = purple;
	let second_axis_square_color = purple;

	let up_dpad_square_color = fg;
	let down_dpad_square_color = fg;
	let left_dpad_square_color = fg;
	let right_dpad_square_color = fg;

	let button_select_square_color = fg;
	let button_start_square_color = fg;

	let button_lt_square_color = fg;
	let button_lb_square_color = fg;
	let button_rt_square_color = fg;
	let button_rb_square_color = fg;

	let button_a_square_color = fg;
	let button_b_square_color = fg;
	let button_x_square_color = fg;
	let button_y_square_color = fg;

	init_window(800, 600, "Input Test");

	for (!window_should_close()) {
		set_window_title("Input Test");
		begin_drawing();
		clear_background(bg);
		draw_text("Input Test", 10, 570, 20, fg);
		set_target_fps(120);
		let fps_str = strconv::i32tos(get_fps());
		draw_text(fps_str, 750, 570, 20, fg);

		// Gamepad
		let first_axis_x = 100.0 + get_gamepad_axis_movement(0,0)*30.0;
		let first_axis_y = 100.0 + get_gamepad_axis_movement(0,1)*30.0;
		let second_axis_x = 300.0 + get_gamepad_axis_movement(0,2)*30.0;
		let second_axis_y = 100.0 + get_gamepad_axis_movement(0,3)*30.0;

		let dpad_up_x = 100.0;
		let dpad_up_y = 250.0;
		let dpad_down_x = 100.0;
		let dpad_down_y = 310.0;
		let dpad_left_x = 70.0;
		let dpad_left_y = 280.0;
		let dpad_right_x = 130.0;
		let dpad_right_y = 280.0;

		let button_select_x = 180.0;
		let button_select_y = 250.0;

		let button_start_x = 220.0;
		let button_start_y = 250.0;

		let button_lt_x = 100.0;
		let button_lt_y = 200.0;
		let button_lb_x = 100.0;
		let button_lb_y = 220.0;

		let button_rt_x = 300.0;
		let button_rt_y = 200.0;
		let button_rb_x = 300.0;
		let button_rb_y = 220.0;

		let button_y_x = 300.0;
		let button_y_y = 250.0;
		let button_a_x = 300.0;
		let button_a_y = 310.0;
		let button_x_x = 270.0;
		let button_x_y = 280.0;
		let button_b_x = 330.0;
		let button_b_y = 280.0;

		x += get_gamepad_axis_movement(0,0)*2.0;
		y += get_gamepad_axis_movement(0,1)*2.0;
		if (is_gamepad_button_pressed(0,6)) square_color = red;
		if (is_gamepad_button_pressed(0,8)) square_color = blue;
		if (is_gamepad_button_pressed(0,7)) square_color = green;
		if (is_gamepad_button_pressed(0,5)) square_color = yellow;
		if (is_gamepad_button_pressed(0,1)) square_size_y -= 10.0;
		if (is_gamepad_button_pressed(0,3)) square_size_y += 10.0;
		if (is_gamepad_button_pressed(0,4)) square_size_x -= 10.0;
		if (is_gamepad_button_pressed(0,2)) square_size_x += 10.0;

		if (is_gamepad_button_pressed(0,16)) first_axis_square_color = blue;
		if (is_gamepad_button_pressed(0,17)) second_axis_square_color = blue;
		if (is_gamepad_button_released(0,16)) first_axis_square_color = purple;
		if (is_gamepad_button_released(0,17)) second_axis_square_color = purple;

		if (is_gamepad_button_pressed(0,13)) button_select_square_color = blue;
		if (is_gamepad_button_pressed(0,15)) button_start_square_color = blue;
		if (is_gamepad_button_released(0,13)) button_select_square_color = fg;
		if (is_gamepad_button_released(0,15)) button_start_square_color = fg;

		if (is_gamepad_button_pressed(0,10)) button_lt_square_color = orange;
		if (is_gamepad_button_pressed(0,9)) button_lb_square_color = red;
		if (is_gamepad_button_pressed(0,12)) button_rt_square_color = orange;
		if (is_gamepad_button_pressed(0,11)) button_rb_square_color = red;
		if (is_gamepad_button_released(0,10)) button_lt_square_color = fg;
		if (is_gamepad_button_released(0,9)) button_lb_square_color = fg;
		if (is_gamepad_button_released(0,12)) button_rt_square_color = fg;
		if (is_gamepad_button_released(0,11)) button_rb_square_color = fg;

		if (is_gamepad_button_pressed(0,6)) button_b_square_color = red;
		if (is_gamepad_button_pressed(0,8)) button_x_square_color = blue;
		if (is_gamepad_button_pressed(0,7)) button_a_square_color = green;
		if (is_gamepad_button_pressed(0,5)) button_y_square_color = yellow;
		if (is_gamepad_button_released(0,6)) button_b_square_color = fg;
		if (is_gamepad_button_released(0,8)) button_x_square_color = fg;
		if (is_gamepad_button_released(0,7)) button_a_square_color = fg;
		if (is_gamepad_button_released(0,5)) button_y_square_color = fg;

		if (is_gamepad_button_pressed(0,1)) up_dpad_square_color = orange;
		if (is_gamepad_button_pressed(0,3)) down_dpad_square_color = orange;
		if (is_gamepad_button_pressed(0,4)) left_dpad_square_color = orange;
		if (is_gamepad_button_pressed(0,2)) right_dpad_square_color = orange;
		if (is_gamepad_button_released(0,1)) up_dpad_square_color = fg;
		if (is_gamepad_button_released(0,3)) down_dpad_square_color = fg;
		if (is_gamepad_button_released(0,4)) left_dpad_square_color = fg;
		if (is_gamepad_button_released(0,2)) right_dpad_square_color = fg;

		// axis
		draw_rectangle(first_axis_x: int, first_axis_y: int, size_x: int, size_y: int, first_axis_square_color);
		draw_rectangle(second_axis_x: int, second_axis_y: int, size_x: int, size_y: int, second_axis_square_color);

		// middle buttons
		draw_rectangle(button_select_x: int, button_start_y: int, size_x: int, 10, button_select_square_color);
		draw_rectangle(button_start_x: int, button_start_y: int, size_x: int, 10, button_start_square_color);

		// dpad
		draw_rectangle(dpad_up_x: int, dpad_up_y: int, size_x: int, size_y: int, up_dpad_square_color);
		draw_rectangle(dpad_down_x: int, dpad_down_y: int, size_x: int, size_y: int, down_dpad_square_color);
		draw_rectangle(dpad_left_x: int, dpad_left_y: int, size_x: int, size_y: int, left_dpad_square_color);
		draw_rectangle(dpad_right_x: int, dpad_right_y: int, size_x: int, size_y: int, right_dpad_square_color);

		// back buttons
		draw_rectangle(button_lt_x: int, button_lt_y: int, size_x: int, 15, button_lt_square_color);
		draw_rectangle(button_lb_x: int, button_lb_y: int, size_x: int, 15, button_lb_square_color);
		draw_rectangle(button_rt_x: int, button_rt_y: int, size_x: int, 15, button_rt_square_color);
		draw_rectangle(button_rb_x: int, button_rb_y: int, size_x: int, 15, button_rb_square_color);

		// front buttons
		draw_rectangle(button_a_x: int, button_a_y: int, size_x: int, size_y: int, button_a_square_color);
		draw_rectangle(button_b_x: int, button_b_y: int, size_x: int, size_y: int, button_b_square_color);
		draw_rectangle(button_x_x: int, button_x_y: int, size_x: int, size_y: int, button_x_square_color);
		draw_rectangle(button_y_x: int, button_y_y: int, size_x: int, size_y: int, button_y_square_color);

		// Keyboard
		if (is_key_down('W')) y -= SPEED*get_frame_time();
		if (is_key_down('A')) x -= SPEED*get_frame_time();
		if (is_key_down('S')) y += SPEED*get_frame_time();
		if (is_key_down('D')) x += SPEED*get_frame_time();

		if (is_key_down('1')) square_color = red;
		if (is_key_down('2')) square_color = green;
		if (is_key_down('3')) square_color = yellow;
		if (is_key_down('4')) square_color = blue;
		if (is_key_down('5')) square_color = purple;
		if (is_key_down('6')) square_color = aqua;
		if (is_key_down('7')) square_color = orange;
		if (is_key_down('8')) square_color = fg;
		if (is_key_down('9')) square_color = bg;

		draw_rectangle(x: int, y: int, square_size_x: int, square_size_y: int, square_color);

		// Mouse
		let mouse_x = get_mouse_x();
		let mouse_y = get_mouse_y();
		let offset_x = size_x / 2.0 * -1.0;
		let offset_y = size_y / 2.0 * -1.0;
		set_mouse_offset(offset_x: int,offset_y: int);

		if (is_mouse_button_pressed(0)) mouse_square_color = blue;
		if (is_mouse_button_pressed(1)) mouse_square_color = red;
		if (is_mouse_button_pressed(2)) mouse_square_color = bg;

		if (is_mouse_button_released(0)) mouse_square_color = aqua;
		if (is_mouse_button_released(1)) mouse_square_color = aqua;
		if (is_mouse_button_released(2)) mouse_square_color = aqua;

		hide_cursor();
		draw_rectangle(mouse_x, mouse_y, 10, 10, mouse_square_color);

		end_drawing();

		// Misc.
		if (is_key_down(' ')) take_screenshot("scr.png");
		if (is_key_down('C')) open_url("https://codeberg.org/guapito/raylib.ha");
	};

	close_window();
};


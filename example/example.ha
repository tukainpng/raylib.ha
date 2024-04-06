use fmt;
use types::c;
use raylib::*;
use gruvbox::*;

const SPEED: f32 = 100.0;

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

	let keyboard_square_color = green;
	let mouse_square_color = aqua;
	let axis_square_color = purple;

	let up_dpad_square_color = fg;
	let down_dpad_square_color = fg;
	let left_dpad_square_color = fg;
	let right_dpad_square_color = fg;

	let button_a_square_color = fg;
	let button_b_square_color = fg;
	let button_x_square_color = fg;
	let button_y_square_color = fg;

	init_window(800, 600, "Olá, Mundo!");

	for (!window_should_close()) {
		set_window_title("Olá, Mundo!");
		begin_drawing();
		clear_background(bg);
		draw_text("Olá, Mundo!", 10, 570, 20, fg);

		// Keyboard

		if (is_key_down('W')) y -= SPEED*get_frame_time();
		if (is_key_down('A')) x -= SPEED*get_frame_time();
		if (is_key_down('S')) y += SPEED*get_frame_time();
		if (is_key_down('D')) x += SPEED*get_frame_time();

		if (is_key_down('1')) keyboard_square_color = red;
		if (is_key_down('2')) keyboard_square_color = green;
		if (is_key_down('3')) keyboard_square_color = yellow;
		if (is_key_down('4')) keyboard_square_color = blue;
		if (is_key_down('5')) keyboard_square_color = purple;
		if (is_key_down('6')) keyboard_square_color = aqua;
		if (is_key_down('7')) keyboard_square_color = orange;
		if (is_key_down('8')) keyboard_square_color = fg;
		if (is_key_down('9')) keyboard_square_color = bg;

		draw_rectangle(x: int, y: int, size_x: int, size_y: int, keyboard_square_color);

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

		draw_rectangle(mouse_x, mouse_y, size_x: int, size_y: int, mouse_square_color);

		// Gamepad
		let first_axis_x = 100.0 + get_gamepad_axis_movement(0,0)*SPEED;
		let first_axis_y = 100.0 + get_gamepad_axis_movement(0,1)*SPEED;
		let second_axis_x = 300.0 + get_gamepad_axis_movement(0,2)*SPEED;
		let second_axis_y = 100.0 + get_gamepad_axis_movement(0,3)*SPEED;

		let dpad_up_x = 100.0;
		let dpad_up_y = 250.0;
		let dpad_down_x = 100.0;
		let dpad_down_y = 310.0;
		let dpad_left_x = 70.0;
		let dpad_left_y = 280.0;
		let dpad_right_x = 130.0;
		let dpad_right_y = 280.0;

		let button_y_x = 300.0;
		let button_y_y = 250.0;
		let button_a_x = 300.0;
		let button_a_y = 310.0;
		let button_x_x = 270.0;
		let button_x_y = 280.0;
		let button_b_x = 330.0;
		let button_b_y = 280.0;

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

		// Shapes
		// axis
		draw_rectangle(first_axis_x: int, first_axis_y: int, size_x: int, size_y: int, axis_square_color);
		draw_rectangle(second_axis_x: int, second_axis_y: int, size_x: int, size_y: int, axis_square_color);

		// dpad
		draw_rectangle(dpad_up_x: int, dpad_up_y: int, size_x: int, size_y: int, up_dpad_square_color);
		draw_rectangle(dpad_down_x: int, dpad_down_y: int, size_x: int, size_y: int, down_dpad_square_color);
		draw_rectangle(dpad_left_x: int, dpad_left_y: int, size_x: int, size_y: int, left_dpad_square_color);
		draw_rectangle(dpad_right_x: int, dpad_right_y: int, size_x: int, size_y: int, right_dpad_square_color);

		// front buttons
		draw_rectangle(button_a_x: int, button_a_y: int, size_x: int, size_y: int, button_a_square_color);
		draw_rectangle(button_b_x: int, button_b_y: int, size_x: int, size_y: int, button_b_square_color);
		draw_rectangle(button_x_x: int, button_x_y: int, size_x: int, size_y: int, button_x_square_color);
		draw_rectangle(button_y_x: int, button_y_y: int, size_x: int, size_y: int, button_y_square_color);

		end_drawing();
	};

	close_window();
};


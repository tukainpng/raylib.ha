use fmt;
use strconv;
use types::c;
use raylib::*;
use gruvbox::*;

def SPEED: f32 = 200.0;
def SCREEN_X = 1280;
def SCREEN_Y = 720;

export fn main() void = {

	const bg         = get_color(bg1);
	const fg         = get_color(fg1);
	const red        = get_color(red0);
	const green      = get_color(green0);
	const yellow     = get_color(yellow0);
	const blue       = get_color(blue0);
	const purple     = get_color(purple0);
	const aqua       = get_color(aqua0);
	const orange     = get_color(orange0);

	let square_x = 0.0;
	let square_y = 0.0;

	let size_x = 30.0;
	let size_y = 30.0;

	let square_color = green;
	let square_size_x: f32 = 30.0;
	let square_size_y: f32 = 30.0;

	let mouse_square_color = aqua;

	let first_axis_circle_color = purple;
	let second_axis_circle_color = purple;

	let dpad_up_triangle_color = fg;
	let dpad_down_triangle_color = fg;
	let dpad_left_triangle_color = fg;
	let dpad_right_triangle_color = fg;

	let button_select_square_color = fg;
	let button_start_square_color = fg;

	let button_lt_square_color = fg;
	let button_lb_square_color = fg;
	let button_rt_square_color = fg;
	let button_rb_square_color = fg;

	let button_a_circle_color = fg;
	let button_b_circle_color = fg;
	let button_x_circle_color = fg;
	let button_y_circle_color = fg;

	let center_x = SCREEN_X: f32;
	let center_y = SCREEN_Y: f32;

	let camera = Camera2D {
		cam_offset = Vector2 { x = SCREEN_X: f32/2.0, y = SCREEN_Y: f32/2.0 },
		target = Vector2 { x = square_x: f32 + square_size_x: f32 / 2.0, y = square_y: f32 + square_size_y: f32 / 2.0 },
		rotation = 0.0,
		zoom = 1.0,
	};

	init_window(SCREEN_X: u32, SCREEN_Y: u32, "Input Test");

	let image = load_image("./example/hare.png");
	let texture = load_texture_from_image(image);

	for (!window_should_close()) {
		set_window_title("Input Test");
		begin_drawing();
		clear_background(bg);
		begin_mode_2d(camera);

		draw_texture(texture, SCREEN_X / 2, SCREEN_Y / 2, get_color(0x00000099));


		let line_1_start	= Vector2 { x = 0.0, y = 0.0 };
		let line_1_end		= Vector2 { x = SCREEN_X: f32, y = 0.0 };
		let line_2_start	= Vector2 { x = SCREEN_X: f32, y = 0.0 };
		let line_2_end		= Vector2 { x = SCREEN_X: f32, y = SCREEN_Y: f32 };
		let line_3_start	= Vector2 { x = SCREEN_X: f32, y = SCREEN_Y: f32 };
		let line_3_end		= Vector2 { x = 0.0, y = SCREEN_Y: f32 };
		let line_4_start	= Vector2 { x = 0.0, y = SCREEN_Y: f32 };
		let line_4_end		= Vector2 { x = 0.0, y = 0.0 };

		draw_line_ex(line_1_start, line_1_end, 5.0, purple);
		draw_line_ex(line_2_start, line_2_end, 5.0, purple);
		draw_line_ex(line_3_start, line_3_end, 5.0, purple);
		draw_line_ex(line_4_start, line_4_end, 5.0, purple);

		// Gamepad
		let first_axis_x = 115.0 + get_gamepad_axis_movement(0,0)*30.0;
		let first_axis_y = 115.0 + get_gamepad_axis_movement(0,1)*30.0;
		let second_axis_x = 315.0 + get_gamepad_axis_movement(0,2)*30.0;
		let second_axis_y = 115.0 + get_gamepad_axis_movement(0,3)*30.0;

		let dpad_triangle_up_v1 = Vector2 { x = 100.0, y = 280.0 };
		let dpad_triangle_up_v2 = Vector2 { x = 130.0, y = 280.0 };
		let dpad_triangle_up_v3 = Vector2 { x = 115.0, y = 250.0 };

		let dpad_triangle_down_v1 = Vector2 { x = 100.0, y = 310.0 };
		let dpad_triangle_down_v2 = Vector2 { x = 115.0, y = 340.0 };
		let dpad_triangle_down_v3 = Vector2 { x = 130.0, y = 310.0 };

		let dpad_triangle_left_v1 = Vector2 { x = 70.0, y = 295.0 };
		let dpad_triangle_left_v2 = Vector2 { x = 100.0, y = 310.0 };
		let dpad_triangle_left_v3 = Vector2 { x = 100.0, y = 280.0 };

		let dpad_triangle_right_v3 = Vector2 { x = 160.0, y = 295.0 };
		let dpad_triangle_right_v1 = Vector2 { x = 130.0, y = 280.0 };
		let dpad_triangle_right_v2 = Vector2 { x = 130.0, y = 310.0 };

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

		let button_y_x = 315.0;
		let button_y_y = 265.0;

		let button_a_x = 315.0;
		let button_a_y = 325.0;

		let button_x_x = 285.0;
		let button_x_y = 295.0;

		let button_b_x = 345.0;
		let button_b_y = 295.0;

		square_x += get_gamepad_axis_movement(0,0)*2.0;
		square_y += get_gamepad_axis_movement(0,1)*2.0;
		if (is_gamepad_button_pressed(0,6)) square_color = red;
		if (is_gamepad_button_pressed(0,8)) square_color = blue;
		if (is_gamepad_button_pressed(0,7)) square_color = green;
		if (is_gamepad_button_pressed(0,5)) square_color = yellow;
		if (is_gamepad_button_pressed(0,1)) square_size_y -= 10.0;
		if (is_gamepad_button_pressed(0,3)) square_size_y += 10.0;
		if (is_gamepad_button_pressed(0,4)) square_size_x -= 10.0;
		if (is_gamepad_button_pressed(0,2)) square_size_x += 10.0;

		if (is_gamepad_button_pressed(0,16)) first_axis_circle_color = blue;
		if (is_gamepad_button_pressed(0,17)) second_axis_circle_color = blue;
		if (is_gamepad_button_released(0,16)) first_axis_circle_color = purple;
		if (is_gamepad_button_released(0,17)) second_axis_circle_color = purple;

		if (is_gamepad_button_pressed(0,13)) button_select_square_color = blue;
		if (is_gamepad_button_pressed(0,15)) button_start_square_color = blue;
		if (is_gamepad_button_released(0,13)) button_select_square_color = fg;
		if (is_gamepad_button_released(0,15)) button_start_square_color = fg;

		if (is_gamepad_button_pressed(0,10)) button_lb_square_color = orange;
		if (is_gamepad_button_pressed(0,9)) button_lt_square_color = red;
		if (is_gamepad_button_pressed(0,12)) button_rb_square_color = orange;
		if (is_gamepad_button_pressed(0,11)) button_rt_square_color = red;
		if (is_gamepad_button_released(0,10)) button_lb_square_color = fg;
		if (is_gamepad_button_released(0,9)) button_lt_square_color = fg;
		if (is_gamepad_button_released(0,12)) button_rb_square_color = fg;
		if (is_gamepad_button_released(0,11)) button_rt_square_color = fg;

		if (is_gamepad_button_pressed(0,6)) button_b_circle_color = red;
		if (is_gamepad_button_pressed(0,8)) button_x_circle_color = blue;
		if (is_gamepad_button_pressed(0,7)) button_a_circle_color = green;
		if (is_gamepad_button_pressed(0,5)) button_y_circle_color = yellow;
		if (is_gamepad_button_released(0,6)) button_b_circle_color = fg;
		if (is_gamepad_button_released(0,8)) button_x_circle_color = fg;
		if (is_gamepad_button_released(0,7)) button_a_circle_color = fg;
		if (is_gamepad_button_released(0,5)) button_y_circle_color = fg;

		if (is_gamepad_button_pressed(0,1)) dpad_up_triangle_color = orange;
		if (is_gamepad_button_pressed(0,3)) dpad_down_triangle_color = orange;
		if (is_gamepad_button_pressed(0,4)) dpad_left_triangle_color = orange;
		if (is_gamepad_button_pressed(0,2)) dpad_right_triangle_color = orange;
		if (is_gamepad_button_released(0,1)) dpad_up_triangle_color = fg;
		if (is_gamepad_button_released(0,3)) dpad_down_triangle_color = fg;
		if (is_gamepad_button_released(0,4)) dpad_left_triangle_color = fg;
		if (is_gamepad_button_released(0,2)) dpad_right_triangle_color = fg;

		// axis
		draw_circle(first_axis_x: int, first_axis_y: int, 15.0, first_axis_circle_color);
		draw_circle(second_axis_x: int, second_axis_y: int, 15.0, second_axis_circle_color);

		// middle buttons
		draw_rectangle(button_select_x: int, button_start_y: int, size_x: int, 10, button_select_square_color);
		draw_rectangle(button_start_x: int, button_start_y: int, size_x: int, 10, button_start_square_color);

		// dpad
		draw_triangle(dpad_triangle_up_v1, dpad_triangle_up_v2, dpad_triangle_up_v3, dpad_up_triangle_color);
		draw_triangle(dpad_triangle_down_v1, dpad_triangle_down_v2, dpad_triangle_down_v3, dpad_down_triangle_color);
		draw_triangle(dpad_triangle_left_v1, dpad_triangle_left_v2, dpad_triangle_left_v3, dpad_left_triangle_color);
		draw_triangle(dpad_triangle_right_v1, dpad_triangle_right_v2, dpad_triangle_right_v3, dpad_right_triangle_color);

		// back buttons
		draw_rectangle(button_lt_x: int, button_lt_y: int, size_x: int, 15, button_lt_square_color);
		draw_rectangle(button_lb_x: int, button_lb_y: int, size_x: int, 15, button_lb_square_color);
		draw_rectangle(button_rt_x: int, button_rt_y: int, size_x: int, 15, button_rt_square_color);
		draw_rectangle(button_rb_x: int, button_rb_y: int, size_x: int, 15, button_rb_square_color);

		// front buttons
		draw_circle(button_a_x: int, button_a_y: int, 15.0, button_a_circle_color);
		draw_circle(button_b_x: int, button_b_y: int, 15.0, button_b_circle_color);
		draw_circle(button_x_x: int, button_x_y: int, 15.0, button_x_circle_color);
		draw_circle(button_y_x: int, button_y_y: int, 15.0, button_y_circle_color);

		// Keyboard
		set_exit_key('Q');

		if (is_key_down('W')) square_y -= SPEED*get_frame_time();
		if (is_key_down('A')) square_x -= SPEED*get_frame_time();
		if (is_key_down('S')) square_y += SPEED*get_frame_time();
		if (is_key_down('D')) square_x += SPEED*get_frame_time();

		if (is_key_down('1')) square_color = red;
		if (is_key_down('2')) square_color = green;
		if (is_key_down('3')) square_color = yellow;
		if (is_key_down('4')) square_color = blue;
		if (is_key_down('5')) square_color = purple;
		if (is_key_down('6')) square_color = aqua;
		if (is_key_down('7')) square_color = orange;
		if (is_key_down('8')) square_color = fg;
		if (is_key_down('9')) square_color = bg;

		draw_rectangle(square_x: int, square_y: int, square_size_x: int, square_size_y: int, square_color);

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

		// Camera
		camera.target = Vector2 { x = square_x: f32 + square_size_x: f32 / 2.0, y = square_y: f32 + square_size_y: f32 / 2.0 };
		if (is_gamepad_button_down(0,10)) camera.rotation -= 0.3;
		if (is_gamepad_button_down(0,12)) camera.rotation += 0.3;
		if (is_gamepad_button_down(0,9)) camera.zoom -= 0.01;
		if (is_gamepad_button_down(0,11)) camera.zoom += 0.01;
		if (is_gamepad_button_pressed(0,13)) camera.rotation = 0.0;
		if (is_gamepad_button_pressed(0,15)) camera.zoom = 1.0;
		camera.zoom += get_mouse_wheel_move() / 20.0;
		if (camera.zoom < 0.0) camera.zoom = 0.0;

		end_mode_2d();

		set_target_fps(120);
		draw_text("Input Test", 10, SCREEN_Y: u32 - 30, 20, fg);

		draw_text(strconv::u32tos(SCREEN_X), 10, 10, 20, fg);
		draw_text("x", 60, 10, 20, fg);
		draw_text(strconv::u32tos(SCREEN_Y), 80, 10, 20, fg);

		draw_fps(SCREEN_X - 100, SCREEN_Y - 30);
		end_drawing();

		// Misc.
		if (is_key_down(' ')) take_screenshot("scr.png");
		if (is_key_down('C')) open_url("https://codeberg.org/guapito/raylib.ha");
	};

	close_window();
};


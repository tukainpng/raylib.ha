use fmt;
use strconv;
use types::c;
use raylib::*;

def SPEED: f32 = 300.0;
def SCREEN_X: int = 1280;
def SCREEN_Y: int = 720;

type Player = struct {
	position:       Vector2,
	dimensions:     Vector2,
	collision:      Rectangle,
	color:          Color,
};

type LineCollision = struct {
	line_1: Rectangle,
	line_2: Rectangle,
	line_3: Rectangle,
	line_4: Rectangle,
};

export fn main() void = {

	let player = Player {
		position   = Vector2 { x = 10.0,  y = 10.0 },
		dimensions = Vector2 { x = 30.0, y = 30.0 },
		collision  = Rectangle {
			x      = 0.0,
			y      = 0.0,
			width  = 30.0,
			height = 30.0,
		},
		color      = GREEN_DARK,
	};

	let mouse_square_color = AQUA_DARK;

	let first_axis_circle_color = PURPLE_DARK;
	let second_axis_circle_color = PURPLE_DARK;

	let dpad_up_triangle_color = FG_LIGHT;
	let dpad_down_triangle_color = FG_LIGHT;
	let dpad_left_triangle_color = FG_LIGHT;
	let dpad_right_triangle_color = FG_LIGHT;

	let button_select_square_color = FG_LIGHT;
	let button_start_square_color = FG_LIGHT;

	let button_lt_square_color = FG_LIGHT;
	let button_lb_square_color = FG_LIGHT;
	let button_rt_square_color = FG_LIGHT;
	let button_rb_square_color = FG_LIGHT;

	let button_a_circle_color = FG_LIGHT;
	let button_b_circle_color = FG_LIGHT;
	let button_x_circle_color = FG_LIGHT;
	let button_y_circle_color = FG_LIGHT;

	let camera = Camera2D {
		cam_offset = Vector2 {
			x = SCREEN_X: f32/2.0,
			y = SCREEN_Y: f32/2.0,
		},
		target = Vector2 {
			x = player.position.x + player.dimensions.x / 2.0,
			y = player.position.y + player.dimensions.y / 2.0,
		},
		rotation = 0.0,
		zoom = 1.0,
	};

	init_window(SCREEN_X: u32, SCREEN_Y: u32, "Input Test");

	let monitor = get_current_monitor();
	let refresh_rate = get_monitor_refresh_rate(monitor);

	let image = load_image("./example/hare.png");
	let texture = load_texture_from_image(image);

	for (!window_should_close()) {
		set_window_title("Input Test");
		begin_drawing();
		clear_background(BG_LIGHT);
		set_target_fps(refresh_rate * 2);
		begin_mode_2d(camera);

		draw_texture(texture, SCREEN_X / 3, SCREEN_Y / 3, get_color(0x000000FF));

		let rec_1_position = Vector2 { x = 0.0, y = 0.0 };
		let rec_1_size     = Vector2 { x = SCREEN_X: f32, y = 5.0 };
		let rec_2_position = Vector2 { x = SCREEN_X: f32, y = 0.0 };
		let rec_2_size     = Vector2 { x = 5.0, y = SCREEN_Y: f32 };
		let rec_3_position = Vector2 { x = 0.0, y = SCREEN_Y: f32 };
		let rec_3_size     = Vector2 { x = SCREEN_X: f32 + 5.0, y = 5.0 };
		let rec_4_position = Vector2 { x = 0.0, y = 0.0 };
		let rec_4_size     = Vector2 { x = 5.0, y = SCREEN_Y: f32 };

		draw_rectangle_v(rec_1_position, rec_1_size, PURPLE_DARK);
		draw_rectangle_v(rec_2_position, rec_2_size, PURPLE_DARK);
		draw_rectangle_v(rec_3_position, rec_3_size, PURPLE_DARK);
		draw_rectangle_v(rec_4_position, rec_4_size, PURPLE_DARK);

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

		player.position.x += get_gamepad_axis_movement(0,0)*2.0;
		player.position.y += get_gamepad_axis_movement(0,1)*2.0;
		if (is_gamepad_button_pressed(0,1)) player.dimensions.y -= 10.0;
		if (is_gamepad_button_pressed(0,3)) player.dimensions.y += 10.0;
		if (is_gamepad_button_pressed(0,4)) player.dimensions.x -= 10.0;
		if (is_gamepad_button_pressed(0,2)) player.dimensions.x += 10.0;

		if (is_gamepad_button_pressed(0,6)) player.color                 = RED_DARK;
		if (is_gamepad_button_pressed(0,8)) player.color                 = BLUE_DARK;
		if (is_gamepad_button_pressed(0,7)) player.color                 = GREEN_DARK;
		if (is_gamepad_button_pressed(0,5)) player.color                 = YELLOW_DARK;

		if (is_gamepad_button_pressed(0,16)) first_axis_circle_color     = BLUE_DARK;
		if (is_gamepad_button_pressed(0,17)) second_axis_circle_color    = BLUE_DARK;
		if (is_gamepad_button_released(0,16)) first_axis_circle_color    = PURPLE_DARK;
		if (is_gamepad_button_released(0,17)) second_axis_circle_color   = PURPLE_DARK;

		if (is_gamepad_button_pressed(0,13)) button_select_square_color  = BLUE_DARK;
		if (is_gamepad_button_pressed(0,15)) button_start_square_color   = BLUE_DARK;
		if (is_gamepad_button_released(0,13)) button_select_square_color = FG_LIGHT;
		if (is_gamepad_button_released(0,15)) button_start_square_color  = FG_LIGHT;

		if (is_gamepad_button_pressed(0,10)) button_lb_square_color      = ORANGE_DARK;
		if (is_gamepad_button_pressed(0,9)) button_lt_square_color       = RED_DARK;
		if (is_gamepad_button_pressed(0,12)) button_rb_square_color      = ORANGE_DARK;
		if (is_gamepad_button_pressed(0,11)) button_rt_square_color      = RED_DARK;
		if (is_gamepad_button_released(0,10)) button_lb_square_color     = FG_LIGHT;
		if (is_gamepad_button_released(0,9)) button_lt_square_color      = FG_LIGHT;
		if (is_gamepad_button_released(0,12)) button_rb_square_color     = FG_LIGHT;
		if (is_gamepad_button_released(0,11)) button_rt_square_color     = FG_LIGHT;

		if (is_gamepad_button_pressed(0,6)) button_b_circle_color        = RED_DARK;
		if (is_gamepad_button_pressed(0,8)) button_x_circle_color        = BLUE_DARK;
		if (is_gamepad_button_pressed(0,7)) button_a_circle_color        = GREEN_DARK;
		if (is_gamepad_button_pressed(0,5)) button_y_circle_color        = YELLOW_DARK;
		if (is_gamepad_button_released(0,6)) button_b_circle_color       = FG_LIGHT;
		if (is_gamepad_button_released(0,8)) button_x_circle_color       = FG_LIGHT;
		if (is_gamepad_button_released(0,7)) button_a_circle_color       = FG_LIGHT;
		if (is_gamepad_button_released(0,5)) button_y_circle_color       = FG_LIGHT;

		if (is_gamepad_button_pressed(0,1)) dpad_up_triangle_color       = ORANGE_DARK;
		if (is_gamepad_button_pressed(0,3)) dpad_down_triangle_color     = ORANGE_DARK;
		if (is_gamepad_button_pressed(0,4)) dpad_left_triangle_color     = ORANGE_DARK;
		if (is_gamepad_button_pressed(0,2)) dpad_right_triangle_color    = ORANGE_DARK;
		if (is_gamepad_button_released(0,1)) dpad_up_triangle_color      = FG_LIGHT;
		if (is_gamepad_button_released(0,3)) dpad_down_triangle_color    = FG_LIGHT;
		if (is_gamepad_button_released(0,4)) dpad_left_triangle_color    = FG_LIGHT;
		if (is_gamepad_button_released(0,2)) dpad_right_triangle_color   = FG_LIGHT;

		// Keyboard
		set_exit_key('Q');

		if (is_key_down('W')) player.position.y -= SPEED*get_frame_time();
		if (is_key_down('A')) player.position.x -= SPEED*get_frame_time();
		if (is_key_down('S')) player.position.y += SPEED*get_frame_time();
		if (is_key_down('D')) player.position.x += SPEED*get_frame_time();

		if (is_key_down('H')) player.position.x -= SPEED*get_frame_time();
		if (is_key_down('J')) player.position.y += SPEED*get_frame_time();
		if (is_key_down('K')) player.position.y -= SPEED*get_frame_time();
		if (is_key_down('L')) player.position.x += SPEED*get_frame_time();

		if (is_key_down('1')) player.color = RED_DARK;
		if (is_key_down('2')) player.color = GREEN_DARK;
		if (is_key_down('3')) player.color = YELLOW_DARK;
		if (is_key_down('4')) player.color = BLUE_DARK;
		if (is_key_down('5')) player.color = PURPLE_DARK;
		if (is_key_down('6')) player.color = AQUA_DARK;
		if (is_key_down('7')) player.color = ORANGE_DARK;
		if (is_key_down('8')) player.color = FG_LIGHT;
		if (is_key_down('9')) player.color = BG_LIGHT;

		// Mouse
		let mouse_x = get_mouse_x();
		let mouse_y = get_mouse_y();
		set_mouse_offset(-15, -15);

		if (is_mouse_button_pressed(0)) mouse_square_color = BLUE_DARK;
		if (is_mouse_button_pressed(1)) mouse_square_color = RED_DARK;
		if (is_mouse_button_pressed(2)) mouse_square_color = BG_DARK;

		if (is_mouse_button_released(0)) mouse_square_color = AQUA_DARK;
		if (is_mouse_button_released(1)) mouse_square_color = AQUA_DARK;
		if (is_mouse_button_released(2)) mouse_square_color = AQUA_DARK;

		hide_cursor();

		// Collision detection
		let line_collision = LineCollision {
			line_1 = Rectangle {
				x = 0.0,
				y = 0.0,
				width = SCREEN_X: f32,
				height = 2.0,
			},

			line_2 = Rectangle {
				x = SCREEN_X: f32 + 4.0,
				y = 0.0,
				width = 5.0,
				height = SCREEN_Y: f32,
			},

			line_3 = Rectangle {
				x = 0.0,
				y = SCREEN_Y: f32 + 4.0,
				width = SCREEN_X: f32,
				height = 5.0,
			},

			line_4 = Rectangle {
				x = 0.0,
				y = 0.0,
				width = 2.0,
				height = SCREEN_Y: f32,
			},
		};

		player.collision = Rectangle {
			x = player.position.x,
			y = player.position.y,
			width = player.dimensions.x,
			height = player.dimensions.y,
		};

		if (check_collision_recs(line_collision.line_1, player.collision)) { 
			draw_rectangle_v(rec_1_position, rec_1_size, PURPLE_LIGHT);
			player.position.y = 4.0;
		};

		if (check_collision_recs(line_collision.line_2, player.collision)) { 
			draw_rectangle_v(rec_2_position, rec_2_size, PURPLE_LIGHT);
			player.position.x = SCREEN_X: f32 - player.dimensions.x + 2.0;
		};

		if (check_collision_recs(line_collision.line_3, player.collision)) { 
			draw_rectangle_v(rec_3_position, rec_3_size, PURPLE_LIGHT);
			player.position.y = SCREEN_Y: f32 - player.dimensions.y + 2.0;
		};

		if (check_collision_recs(line_collision.line_4, player.collision)) { 
			draw_rectangle_v(rec_4_position, rec_4_size, PURPLE_LIGHT);
			player.position.x = 4.0;
		};

		// Camera
		camera.target = Vector2 {
			x = player.position.x + player.dimensions.x / 2.0,
			y = player.position.y + player.dimensions.y / 2.0
		};

		if (is_gamepad_button_down(0,10)) camera.rotation -= 0.3;
		if (is_gamepad_button_down(0,12)) camera.rotation += 0.3;
		if (is_gamepad_button_down(0,9)) camera.zoom -= 0.01;
		if (is_gamepad_button_down(0,11)) camera.zoom += 0.01;
		if (is_gamepad_button_pressed(0,13)) camera.rotation = 0.0;
		if (is_gamepad_button_pressed(0,15)) camera.zoom = 1.0;
		camera.zoom += get_mouse_wheel_move() / 20.0;
		if (camera.zoom < 0.0) camera.zoom = 0.0;

		// Resident Evil-like camera
		//
		// if (player.position.x <= SCREEN_X: f32 / 2.0) camera.target.x = SCREEN_X: f32 / 4.0;
		// if (player.position.x >= SCREEN_X: f32 / 2.0) camera.target.x = SCREEN_X: f32;
		// if (player.position.y <= SCREEN_Y: f32 / 2.0) camera.target.y = SCREEN_Y: f32 / 4.0;
		// if (player.position.y >= SCREEN_Y: f32 / 2.0) camera.target.y = SCREEN_Y: f32;

		// Axis circles
		draw_circle(    first_axis_x: int,
				first_axis_y: int,
				15.0,
				first_axis_circle_color);

		draw_circle(    second_axis_x: int,
				second_axis_y: int,
				15.0,
				second_axis_circle_color);

		// Middle buttons rectangles
		draw_rectangle( button_select_x: int,
				button_start_y: int,
				30,
				10,
				button_select_square_color);

		draw_rectangle( button_start_x: int,
				button_start_y: int,
				30,
				10,
				button_start_square_color);

		// D-PAD Triangles
		draw_triangle(  dpad_triangle_up_v1,
				dpad_triangle_up_v2,
				dpad_triangle_up_v3,
				dpad_up_triangle_color);

		draw_triangle(  dpad_triangle_down_v1,
				dpad_triangle_down_v2,
				dpad_triangle_down_v3,
				dpad_down_triangle_color);

		draw_triangle(  dpad_triangle_left_v1,
				dpad_triangle_left_v2,
				dpad_triangle_left_v3,
				dpad_left_triangle_color);

		draw_triangle(  dpad_triangle_right_v1,
				dpad_triangle_right_v2,
				dpad_triangle_right_v3,
				dpad_right_triangle_color);

		// Triggers/Shoulder buttons rectangles
		draw_rectangle( button_lt_x: int,
				button_lt_y: int,
				30,
				15,
				button_lt_square_color);

		draw_rectangle( button_lb_x: int,
				button_lb_y: int,
				30,
				15,
				button_lb_square_color);

		draw_rectangle( button_rt_x: int,
				button_rt_y: int,
				30,
				15,
				button_rt_square_color);

		draw_rectangle( button_rb_x: int,
				button_rb_y: int,
				30,
				15,
				button_rb_square_color);

		// Front buttons circles
		draw_circle(    button_a_x: int,
				button_a_y: int,
				15.0,
				button_a_circle_color);

		draw_circle(    button_b_x: int,
				button_b_y: int,
				15.0,
				button_b_circle_color);

		draw_circle(    button_x_x: int,
				button_x_y: int,
				15.0,
				button_x_circle_color);

		draw_circle(    button_y_x: int,
				button_y_y: int,
				15.0,
				button_y_circle_color);

		// Mouse cursor
		draw_rectangle(mouse_x, mouse_y, 10, 10, mouse_square_color);

		// Player
		draw_rectangle_v(player.position, player.dimensions, player.color);

		end_mode_2d();

		if (is_gamepad_button_down(0,17)) debug_info(get_current_monitor());
		if (is_key_down('I')) debug_info(get_current_monitor());

		end_drawing();

		// Misc.
		if (is_key_pressed(' ')) take_screenshot("scr.png");
		if (is_key_pressed('C')) open_url("https://codeberg.org/guapito/raylib.ha");
	};

	close_window();
};

fn debug_info(monitor: int) void = {
	// Background
	draw_rectangle(0, 0, get_render_width(), 140, get_color(0x282828AA));

	// Left-side
	draw_text("Example: Input Test", 10, 10, 20, FG_LIGHT);
	draw_text("Controller:", 10, 40, 20, FG_LIGHT);
	draw_text(get_gamepad_name(0), 130, 40, 20, FG_LIGHT);
	draw_fps(10, 100);

	// Right-side
	draw_text("Resolution:", SCREEN_X: u32 - 300, 10, 20, FG_LIGHT);
	draw_text(strconv::itos(get_render_width()), SCREEN_X: u32 - 180, 10, 20, FG_LIGHT);
	draw_text("x", SCREEN_X: u32 - 130, 10, 20, FG_LIGHT);
	draw_text(strconv::itos(get_render_height()), SCREEN_X: u32 - 110, 10, 20, FG_LIGHT);
	draw_text("Monitor name:", SCREEN_X: u32 - 300, 40, 20, FG_LIGHT);
	draw_text(get_monitor_name(monitor), SCREEN_X: u32 - 150, 40, 20, FG_LIGHT);
};


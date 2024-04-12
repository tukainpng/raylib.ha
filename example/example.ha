use fmt;
use strconv;
use types::c;
use raylib::*;

def TITLE = "Game Example";

def SCREEN_RESOLUTION = Vector2 {
	x = 1280.0,
	y = 720.0,
};

type Player = struct {
	position:   Vector2,
	dimensions: Vector2,
	collision:  Rectangle,
	color:      Color,
	speed:      f32,
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
		x = 0.0,
		y = 0.0,
		width = 30.0,
		height = 30.0,
	},
	color = GREEN_DARK,
	speed = 300.0,
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
		x = SCREEN_RESOLUTION.x / 2.0,
		y = SCREEN_RESOLUTION.y / 2.0,
	},
	target = Vector2 {
		x = player.position.x + player.dimensions.x / 2.0,
		y = player.position.y + player.dimensions.y / 2.0,
	},
	rotation = 0.0,
	zoom = 1.0,
};

init_window(SCREEN_RESOLUTION.x: u32, SCREEN_RESOLUTION.y: u32, TITLE);

let monitor = get_current_monitor();
let refresh_rate = get_monitor_refresh_rate(monitor);

let image = load_image("./example/hare.png");
let texture = load_texture_from_image(image);

init_audio_device();
let music: Music = load_music_stream("./example/rollingdownthestreet.xm");
music.looping = true;
set_music_volume(music, 0.5);

set_target_fps(refresh_rate * 2);

for (!window_should_close()) {
	set_window_title(TITLE);

	update_music_stream(music);
	switch (is_music_stream_playing(music)) {
		case true =>
		if (is_key_pressed(KeyboardKey::KEY_P)) pause_music_stream(music);
		if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_THUMB)) pause_music_stream(music);
		case false =>
		if (is_key_pressed(KeyboardKey::KEY_P)) play_music_stream(music);
		if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_THUMB)) play_music_stream(music);
	};

	begin_drawing();
	clear_background(BG_LIGHT);
	hide_cursor();
	begin_mode_2d(camera);

	draw_texture(texture, SCREEN_RESOLUTION.x: int / 3, SCREEN_RESOLUTION.y: int / 3, get_color(0x000000FF));

	let rec_1 = Rectangle {
		x = 0.0,
		y = 0.0,
		width = SCREEN_RESOLUTION.x,
		height = 5.0,
	};

	let rec_2 = Rectangle {
		x = SCREEN_RESOLUTION.x,
		y = 0.0,
		width = 5.0,
		height = SCREEN_RESOLUTION.y,
	};

	let rec_3 = Rectangle {
		x = 0.0,
		y = SCREEN_RESOLUTION.y,
		width = SCREEN_RESOLUTION.x + 5.0,
		height = 5.0,
	};

	let rec_4 = Rectangle {
		x = 0.0,
		y = 0.0,
		width = 5.0,
		height = SCREEN_RESOLUTION.y,
	};

	draw_rectangle_rec(rec_1, PURPLE_DARK);
	draw_rectangle_rec(rec_2, PURPLE_DARK);
	draw_rectangle_rec(rec_3, PURPLE_DARK);
	draw_rectangle_rec(rec_4, PURPLE_DARK);

	// Gamepad
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_X) > 0.0) player.position.x += player.speed*get_frame_time();
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_X) < 0.0) player.position.x -= player.speed*get_frame_time();
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_Y) > 0.0) player.position.y += player.speed*get_frame_time();
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_Y) < 0.0) player.position.y -= player.speed*get_frame_time();

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_UP)) player.dimensions.y -= 10.0;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_DOWN)) player.dimensions.y += 10.0;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_LEFT)) player.dimensions.x -= 10.0;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_RIGHT)) player.dimensions.x += 10.0;

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_THUMB)) first_axis_circle_color = BLUE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB)) second_axis_circle_color = BLUE_DARK;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_THUMB)) first_axis_circle_color = PURPLE_DARK;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB)) second_axis_circle_color = PURPLE_DARK;

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_MIDDLE_LEFT)) button_select_square_color = BLUE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_MIDDLE_RIGHT)) button_start_square_color = BLUE_DARK;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_MIDDLE_LEFT)) button_select_square_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_MIDDLE_RIGHT)) button_start_square_color = FG_LIGHT;

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_TRIGGER_2)) button_lb_square_color = ORANGE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_TRIGGER_1)) button_lt_square_color = RED_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_TRIGGER_2)) button_rb_square_color = ORANGE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_TRIGGER_1)) button_rt_square_color = RED_DARK;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_TRIGGER_2)) button_lb_square_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_TRIGGER_1)) button_lt_square_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_TRIGGER_2)) button_rb_square_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_TRIGGER_1)) button_rt_square_color = FG_LIGHT;

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_RIGHT)) player.color = RED_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_LEFT)) player.color = BLUE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_DOWN)) player.color = GREEN_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_UP)) player.color = YELLOW_DARK;

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_RIGHT)) button_b_circle_color = RED_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_LEFT)) button_x_circle_color = BLUE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_DOWN)) button_a_circle_color = GREEN_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_UP)) button_y_circle_color = YELLOW_DARK;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_RIGHT)) button_b_circle_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_LEFT)) button_x_circle_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_DOWN)) button_a_circle_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_FACE_UP)) button_y_circle_color = FG_LIGHT;

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_UP)) dpad_up_triangle_color = ORANGE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_DOWN)) dpad_down_triangle_color = ORANGE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_LEFT)) dpad_left_triangle_color = ORANGE_DARK;
	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_RIGHT)) dpad_right_triangle_color = ORANGE_DARK;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_UP)) dpad_up_triangle_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_DOWN)) dpad_down_triangle_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_LEFT)) dpad_left_triangle_color = FG_LIGHT;
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_LEFT_FACE_RIGHT)) dpad_right_triangle_color = FG_LIGHT;

	// Keyboard
	set_exit_key(KeyboardKey::KEY_Q);

	if (is_key_down(KeyboardKey::KEY_W)) player.position.y -= player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_A)) player.position.x -= player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_S)) player.position.y += player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_D)) player.position.x += player.speed*get_frame_time();

	if (is_key_down(KeyboardKey::KEY_H)) player.position.x -= player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_J)) player.position.y += player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_K)) player.position.y -= player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_L)) player.position.x += player.speed*get_frame_time();

	if (is_key_down(KeyboardKey::KEY_ONE)) player.color = RED_DARK;
	if (is_key_down(KeyboardKey::KEY_TWO)) player.color = GREEN_DARK;
	if (is_key_down(KeyboardKey::KEY_THREE)) player.color = YELLOW_DARK;
	if (is_key_down(KeyboardKey::KEY_FOUR)) player.color = BLUE_DARK;
	if (is_key_down(KeyboardKey::KEY_FIVE)) player.color = PURPLE_DARK;
	if (is_key_down(KeyboardKey::KEY_SIX)) player.color = AQUA_DARK;
	if (is_key_down(KeyboardKey::KEY_SEVEN)) player.color = ORANGE_DARK;
	if (is_key_down(KeyboardKey::KEY_EIGHT)) player.color = FG_DARK;
	if (is_key_down(KeyboardKey::KEY_NINE)) player.color = BG_DARK;

	if (is_key_down(KeyboardKey::KEY_KP_1)) player.color = RED_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_2)) player.color = GREEN_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_3)) player.color = YELLOW_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_4)) player.color = BLUE_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_5)) player.color = PURPLE_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_6)) player.color = AQUA_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_7)) player.color = ORANGE_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_8)) player.color = FG_LIGHT;
	if (is_key_down(KeyboardKey::KEY_KP_9)) player.color = BG_LIGHT;

	// Collision detection
	let line_collision = LineCollision {
		line_1 = Rectangle {
			x = 0.0,
			y = 0.0,
			width = SCREEN_RESOLUTION.x,
			height = 2.0,
		},

		line_2 = Rectangle {
			x = SCREEN_RESOLUTION.x + 4.0,
			y = 0.0,
			width = 5.0,
			height = SCREEN_RESOLUTION.y,
		},

		line_3 = Rectangle {
			x = 0.0,
			y = SCREEN_RESOLUTION.y + 4.0,
			width = SCREEN_RESOLUTION.x,
			height = 5.0,
		},

		line_4 = Rectangle {
			x = 0.0,
			y = 0.0,
			width = 2.0,
			height = SCREEN_RESOLUTION.y,
		},
	};

	player.collision = Rectangle {
		x = player.position.x,
		y = player.position.y,
		width = player.dimensions.x,
		height = player.dimensions.y,
	};

	if (check_collision_recs(line_collision.line_1, player.collision)) { 
		draw_rectangle_rec(rec_1, PURPLE_LIGHT);
		player.position.y = 4.0;
	};

	if (check_collision_recs(line_collision.line_2, player.collision)) { 
		draw_rectangle_rec(rec_2, PURPLE_LIGHT);
		player.position.x = SCREEN_RESOLUTION.x - player.dimensions.x + 2.0;
	};

	if (check_collision_recs(line_collision.line_3, player.collision)) { 
		draw_rectangle_rec(rec_3, PURPLE_LIGHT);
		player.position.y = SCREEN_RESOLUTION.y - player.dimensions.y + 2.0;
	};

	if (check_collision_recs(line_collision.line_4, player.collision)) { 
		draw_rectangle_rec(rec_4, PURPLE_LIGHT);
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
	// if (player.position.x <= SCREEN_RESOLUTION.x / 2.0) camera.target.x = SCREEN_RESOLUTION.x / 4.0;
	// if (player.position.x >= SCREEN_RESOLUTION.x / 2.0) camera.target.x = SCREEN_RESOLUTION.x;
	// if (player.position.y <= SCREEN_RESOLUTION.y / 2.0) camera.target.y = SCREEN_RESOLUTION.y / 4.0;
	// if (player.position.y >= SCREEN_RESOLUTION.y / 2.0) camera.target.y = SCREEN_RESOLUTION.y;

	// Axis circles
	let first_axis = Vector2 {
		x = 115.0 + get_gamepad_axis_movement(0,0)*30.0,
		y = 115.0 + get_gamepad_axis_movement(0,1)*30.0,
	};

	let second_axis = Vector2 {
		x = 315.0 + get_gamepad_axis_movement(0,2)*30.0,
		y = 115.0 + get_gamepad_axis_movement(0,3)*30.0,
	};

	draw_circle_v(first_axis, 15.0, first_axis_circle_color);
	draw_circle_v(second_axis, 15.0, second_axis_circle_color);

	// Middle buttons rectangles
	let button_select = Rectangle {
		x = 180.0,
		y = 250.0,
		width = 30.0,
		height = 10.0,
	};

	let button_start = Rectangle {
		x = 220.0,
		y = 250.0,
		width = 30.0,
		height = 10.0,
	};

	draw_rectangle_rec(button_select, button_select_square_color);
	draw_rectangle_rec(button_start, button_start_square_color);

	// D-PAD Triangles
	let dpad_up = Triangle {
		point_1 = Vector2 { x = 100.0, y = 280.0 },
		point_2 = Vector2 { x = 130.0, y = 280.0 },
		point_3 = Vector2 { x = 115.0, y = 250.0 },
	};

	let dpad_down = Triangle {
		point_1 = Vector2 { x = 100.0, y = 310.0 },
		point_2 = Vector2 { x = 115.0, y = 340.0 },
		point_3 = Vector2 { x = 130.0, y = 310.0 },
	};

	let dpad_left = Triangle {
		point_1 = Vector2 { x = 70.0, y = 295.0 },
		point_2 = Vector2 { x = 100.0, y = 310.0 },
		point_3 = Vector2 { x = 100.0, y = 280.0 },
	};

	let dpad_right = Triangle {
		point_1 = Vector2 { x = 160.0, y = 295.0 },
		point_2 = Vector2 { x = 130.0, y = 280.0 },
		point_3 = Vector2 { x = 130.0, y = 310.0 },
	};

	draw_triangle_v(dpad_up, dpad_up_triangle_color);
	draw_triangle_v(dpad_down, dpad_down_triangle_color);
	draw_triangle_v(dpad_left, dpad_left_triangle_color);
	draw_triangle_v(dpad_right, dpad_right_triangle_color);

	// Triggers/Shoulder buttons rectangles
	let button_lt = Rectangle {
		x = 107.5,
		y = 190.0,
		width = 15.0,
		height = 25.0,
	};

	let button_lb = Rectangle {
		x = 100.0,
		y = 220.0,
		width = 30.0,
		height = 15.0,
	};

	let button_rt = Rectangle {
		x = 307.5,
		y = 190.0,
		width = 15.0,
		height = 25.0,
	};

	let button_rb = Rectangle {
		x = 300.0,
		y = 220.0,
		width = 30.0,
		height = 15.0,
	};

	draw_rectangle_rec(button_lt, button_lt_square_color);
	draw_rectangle_rec(button_lb, button_lb_square_color);
	draw_rectangle_rec(button_rt, button_rt_square_color);
	draw_rectangle_rec(button_rb, button_rb_square_color);

	// Front buttons circles
	let button_a = Vector2 { x = 315.0, y = 325.0 };
	let button_b = Vector2 { x = 345.0, y = 295.0 };
	let button_x = Vector2 { x = 285.0, y = 295.0 };
	let button_y = Vector2 { x = 315.0, y = 265.0 };

	draw_circle_v(button_a, 15.0, button_a_circle_color);
	draw_circle_v(button_b, 15.0, button_b_circle_color);
	draw_circle_v(button_x, 15.0, button_x_circle_color);
	draw_circle_v(button_y, 15.0, button_y_circle_color);

	// Player
	draw_rectangle_v(player.position, player.dimensions, player.color);

	end_mode_2d();

	if (is_gamepad_button_down(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB)) debug_info(get_current_monitor(), music);
	if (is_key_down(KeyboardKey::KEY_I)) debug_info(get_current_monitor(), music);

	end_drawing();

	// Misc.
	if (is_key_pressed(KeyboardKey::KEY_SPACE)) take_screenshot("scr.png");
	if (is_key_pressed(KeyboardKey::KEY_C)) open_url("https://codeberg.org/guapito/raylib.ha");
};
close_audio_device();
close_window();
};

fn debug_info(monitor: int, music: Music) void = {
// Background
draw_rectangle(0, 0, get_render_width(), 140, get_color(0x282828AA));

// Left-side
draw_text(TITLE, 10, 10, 20, FG_LIGHT);
draw_text("Controller:", 10, 40, 20, FG_LIGHT);
draw_text(get_gamepad_name(0), 130, 40, 20, FG_LIGHT);
draw_text("Music progress:", 10, 70, 20, FG_LIGHT);
draw_text(strconv::itos(get_music_time_played(music): int), 200, 70, 20, FG_LIGHT);
draw_text("/", 240, 70, 20, FG_LIGHT);
draw_text(strconv::itos(get_music_time_length(music): int), 280, 70, 20, FG_LIGHT);
draw_fps(10, 100);

// Right-side
draw_text("Resolution:", SCREEN_RESOLUTION.x: u32 - 300, 10, 20, FG_LIGHT);
draw_text(strconv::itos(get_render_width()), SCREEN_RESOLUTION.x: u32 - 180, 10, 20, FG_LIGHT);
draw_text("x", SCREEN_RESOLUTION.x: u32 - 130, 10, 20, FG_LIGHT);
draw_text(strconv::itos(get_render_height()), SCREEN_RESOLUTION.x: u32 - 110, 10, 20, FG_LIGHT);
draw_text("Monitor name:", SCREEN_RESOLUTION.x: u32 - 300, 40, 20, FG_LIGHT);
draw_text(get_monitor_name(monitor), SCREEN_RESOLUTION.x: u32 - 150, 40, 20, FG_LIGHT);
};


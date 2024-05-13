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

export fn main() void = {

let player = Player {
	position   = Vector2 { x = 320.0,  y = 240.0 },
	dimensions = Vector2 { x = 30.0, y = 30.0 },
	collision  = Rectangle {
		x = 0.0,
		y = 0.0,
		width = 38.0,
		height = 60.0,
	},
	color = BLACK,
	speed = 300.0,
};

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

init_window(SCREEN_RESOLUTION.x: int, SCREEN_RESOLUTION.y: int, TITLE);
defer close_window();

let monitor = get_current_monitor();
let refresh_rate = get_monitor_refresh_rate(monitor);

// Textures
let ruins = load_texture("./examples/images/ruins.png");
let player_texture = load_texture("./examples/images/player.png");

init_audio_device();
defer close_audio_device();

let music: Music = load_music_stream("./examples/sounds/ruins.mp3");
music.looping = true;
let menu_enter = load_sound("./examples/sounds/snd_bell.wav");
let menu_quit = load_sound("./examples/sounds/snd_select.wav");
set_music_volume(music, 0.5);
play_music_stream(music);

set_target_fps(refresh_rate * 2);

for (!window_should_close()) {
	set_window_title(TITLE);

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB)
		|| is_key_pressed(KeyboardKey::KEY_I)) play_sound(menu_enter);

	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB)
		|| is_key_released(KeyboardKey::KEY_I)) play_sound(menu_quit);

	update_music_stream(music);
	switch (is_music_stream_playing(music)) {
		case true =>
		if (is_key_pressed(KeyboardKey::KEY_P)) pause_music_stream(music);
		if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_THUMB))
			pause_music_stream(music);

		case false =>
		if (is_key_pressed(KeyboardKey::KEY_P)) play_music_stream(music);
		if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_LEFT_THUMB))
			play_music_stream(music);
	};

	begin_drawing();
	defer end_drawing();
	clear_background(BLACK);
	hide_cursor();
	begin_mode_2d(camera);
	defer end_mode_2d();

	// Gamepad
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_X) > 0.0)
		player.position.x += player.speed*get_frame_time();

	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_X) < 0.0)
		player.position.x -= player.speed*get_frame_time();

	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_Y) > 0.0)
		player.position.y += player.speed*get_frame_time();

	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_Y) < 0.0)
		player.position.y -= player.speed*get_frame_time();

	// Keyboard
	set_exit_key(KeyboardKey::KEY_Q);

	if (is_key_down(KeyboardKey::KEY_W))
		player.position.y -= player.speed*get_frame_time();

	if (is_key_down(KeyboardKey::KEY_A))
		player.position.x -= player.speed*get_frame_time();

	if (is_key_down(KeyboardKey::KEY_S))
		player.position.y += player.speed*get_frame_time();

	if (is_key_down(KeyboardKey::KEY_D))
		player.position.x += player.speed*get_frame_time();

	if (is_key_down(KeyboardKey::KEY_H))
		player.position.x -= player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_J))
		player.position.y += player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_K))
		player.position.y -= player.speed*get_frame_time();
	if (is_key_down(KeyboardKey::KEY_L))
		player.position.x += player.speed*get_frame_time();

	// Camera
	camera.target.x = 320.0;
	camera.target.y = 240.0;

	// Background
	draw_texture(ruins, 0, 0, get_color(0xFFFFFFFF));

	// Player
	player.collision = Rectangle {
		x = player.position.x,
		y = player.position.y,
		width = 38.0,
		height = 60.0,
	};

	draw_texture(
		player_texture,
		player.position.x: int,
		player.position.y: int,
		get_color(0xFFFFFFFF)
	);

	// Map Limits

	// Top
	if (check_collision_recs(
		Rectangle {
			x = 0.0,
			y = 120.0,
			width = 640.0,
			height = 2.0
		}, player.collision))
	{
		player.position.y += 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	// Left-side
	if (check_collision_recs(
		Rectangle {
			x = 120.0,
			y = 140.0,
			width = 2.0,
			height = 50.0
		}, player.collision))
	{
		player.position.x += 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 85.0,
			y = 200.0,
			width = 25.0,
			height = 2.0
		}, player.collision))
	{
		player.position.y += 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 80.0,
			y = 200.0,
			width = 2.0,
			height = 140.0
		}, player.collision))
	{
		player.position.x += 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;
	
	let left_corner_1_point_1 = Vector2 { x = 80.0, y = 360.0 };
	let left_corner_1_point_2 = Vector2 { x = 80.0, y = 400.0 };
	let left_corner_1_point_3 = Vector2 { x = 120.0, y = 400.0 };
	let left_corner_1_point_player = Vector2 {
		x = player.position.x, y = player.position.y + 30.0
	};

	if (check_collision_point_triangle(
		left_corner_1_point_player,
		left_corner_1_point_1,
		left_corner_1_point_2,
		left_corner_1_point_3))
	{
		player.position.x += 2.5;
		player.position.y -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 120.0,
			y = 410.0,
			width = 40.0,
			height = 20.0
		}, player.collision))
	{
		player.position.y -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	let left_corner_2_point_1 = Vector2 { x = 160.0, y = 400.0 };
	let left_corner_2_point_2 = Vector2 { x = 160.0, y = 440.0 };
	let left_corner_2_point_3 = Vector2 { x = 200.0, y = 440.0 };
	let left_corner_2_point_player = Vector2 {
		x = player.position.x, y = player.position.y + 30.0
	};

	if (check_collision_point_triangle(
		left_corner_2_point_player,
		left_corner_2_point_1,
		left_corner_2_point_2,
		left_corner_2_point_3))
	{
		player.position.x += 2.5;
		player.position.y -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	// Bottom
	if (check_collision_recs(
		Rectangle {
			x = 0.0,
			y = 450.0,
			width = 650.0,
			height = 2.0
		}, player.collision))
	{
		player.position.y -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	// Right-side
	if (check_collision_recs(
		Rectangle {
			x = 490.0,
			y = 140.0,
			width = 2.0,
			height = 50.0
		}, player.collision))
	{
		player.position.x -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 510.0,
			y = 200.0,
			width = 25.0,
			height = 2.0
		}, player.collision))
	{
		player.position.y += 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 530.0,
			y = 200.0,
			width = 2.0,
			height = 30.0
		}, player.collision))
	{
		player.position.x -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 535.0,
			y = 240.0,
			width = 25.0,
			height = 2.0
		}, player.collision))
	{
		player.position.y += 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 570.0,
			y = 240.0,
			width = 2.0,
			height = 150.0
		}, player.collision))
	{
		player.position.x -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	if (check_collision_recs(
		Rectangle {
			x = 540.0,
			y = 390.0,
			width = 20.0,
			height = 10.0
		}, player.collision))
	{
		player.position.y -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	let right_corner_point_1 = Vector2 { x = 560.0, y = 360.0 };
	let right_corner_point_2 = Vector2 { x = 480.0, y = 440.0 };
	let right_corner_point_3 = Vector2 { x = 560.0, y = 440.0 };
	let right_corner_point_player = Vector2 {
		x = player.position.x + 40.0,
		y = player.position.y + 30.0
	};

	if (check_collision_point_triangle(
		right_corner_point_player,
		right_corner_point_1,
		right_corner_point_2,
		right_corner_point_3))
	{
		player.position.x -= 2.5;
		player.position.y -= 2.5;
		player.speed = 0.0;
	}
	else player.speed = 300.0;

	debug_info(get_current_monitor(), music);

	// Misc.
	if (is_key_pressed(KeyboardKey::KEY_SPACE))
		take_screenshot("scr.png");

	if (is_key_pressed(KeyboardKey::KEY_C))
		open_url("https://git.cbps.xyz/guapito/raylib.ha");
};
};

fn debug_info(monitor: int, music: Music) bool = {

if (is_gamepad_button_down(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB)
	|| is_key_down(KeyboardKey::KEY_I)) {
	// Background
	draw_rectangle(
		SCREEN_RESOLUTION.x: int / 8, 60, // Position
		320, 320, // Dimensions
		get_color(0x000000AA));

	// Content
	draw_text(TITLE, SCREEN_RESOLUTION.x: int / 8 + 5, 60, 20, GRUV_FG_LIGHT);
	draw_text("Controller:", SCREEN_RESOLUTION.x: int / 8 + 5, 80, 20, GRUV_FG_LIGHT);
	draw_text(get_gamepad_name(0), SCREEN_RESOLUTION.x: int / 8 + 5, 100, 15, GRUV_FG_LIGHT);
	draw_text("Music progress:", SCREEN_RESOLUTION.x: int / 8 + 5, 120, 20, GRUV_FG_LIGHT);
	draw_text(strconv::itos(get_music_time_played(music): int), SCREEN_RESOLUTION.x: int / 8 + 10, 140, 20, GRUV_FG_LIGHT);
	draw_text("/", SCREEN_RESOLUTION.x: int / 8 + 45, 140, 20, GRUV_FG_LIGHT);
	draw_text(strconv::itos(get_music_time_length(music): int), SCREEN_RESOLUTION.x: int / 8 + 90, 140, 20, GRUV_FG_LIGHT);
	draw_fps(SCREEN_RESOLUTION.x: int / 8 + 5, 350);

	return true;
};

return false;

};


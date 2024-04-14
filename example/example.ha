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

init_window(SCREEN_RESOLUTION.x: u32, SCREEN_RESOLUTION.y: u32, TITLE);

let monitor = get_current_monitor();
let refresh_rate = get_monitor_refresh_rate(monitor);

// Textures
let hare = load_texture("./example/hare.png");
let map = load_texture("./example/images/map.png");
let mushroon = load_texture("./example/images/mushroon.png");
let player_texture = load_texture("./example/images/player.png");

init_audio_device();
let music: Music = load_music_stream("./example/sounds/rollingdownthestreet.xm");
music.looping = true;
let menu_enter = load_sound("./example/sounds/snd_bell.wav");
let menu_quit = load_sound("./example/sounds/snd_select.wav");
set_music_volume(music, 0.5);

set_target_fps(refresh_rate * 2);

for (!window_should_close()) {
	set_window_title(TITLE);

	if (is_gamepad_button_pressed(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB) || is_key_pressed(KeyboardKey::KEY_I)) play_sound(menu_enter);
	if (is_gamepad_button_released(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB) || is_key_released(KeyboardKey::KEY_I)) play_sound(menu_quit);

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
	clear_background(get_color(0x1b215aFF));
	hide_cursor();
	begin_mode_2d(camera);

	// Gamepad
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_X) > 0.0) player.position.x += player.speed*get_frame_time();
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_X) < 0.0) player.position.x -= player.speed*get_frame_time();
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_Y) > 0.0) player.position.y += player.speed*get_frame_time();
	if (get_gamepad_axis_movement(0,GamepadAxis::GAMEPAD_AXIS_LEFT_Y) < 0.0) player.position.y -= player.speed*get_frame_time();

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

	draw_rectangle_rec(rec_1, GRUV_PURPLE_DARK);
	draw_rectangle_rec(rec_2, GRUV_PURPLE_DARK);
	draw_rectangle_rec(rec_3, GRUV_PURPLE_DARK);
	draw_rectangle_rec(rec_4, GRUV_PURPLE_DARK);

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
		width = 38.0,
		height = 60.0,
	};

	if (check_collision_recs(line_collision.line_1, player.collision)) { 
		draw_rectangle_rec(rec_1, GRUV_PURPLE_LIGHT);
		player.position.y = 4.0;
	};

	if (check_collision_recs(line_collision.line_2, player.collision)) { 
		draw_rectangle_rec(rec_2, GRUV_PURPLE_LIGHT);
		player.position.x = SCREEN_RESOLUTION.x - 36.0;
	};

	if (check_collision_recs(line_collision.line_3, player.collision)) { 
		draw_rectangle_rec(rec_3, GRUV_PURPLE_LIGHT);
		player.position.y = SCREEN_RESOLUTION.y - 58.0;
	};

	if (check_collision_recs(line_collision.line_4, player.collision)) { 
		draw_rectangle_rec(rec_4, GRUV_PURPLE_LIGHT);
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

	// Scene
	let map_mushroon        = Rectangle { x = 0.0,   y = 0.0,    width = 13.0,  height = 13.0 };
	let map_mushroon_size   = Rectangle { x = 10.0,  y = 20.0,   width = 26.0,  height = 26.0 };
	let map_pilar_4         = Rectangle { x = 180.0, y = 100.0,  width = 60.0,  height = 100.0 };
	let map_pilar_size_4    = Rectangle { x = 0.0,   y = -200.0, width = 120.0, height = 200.0 };
	let map_ground          = Rectangle { x = 160.0, y = 200.0,  width = 60.0,  height = 40.0 };
	let map_ground_size     = Rectangle { x = 0.0,   y = 0.0,    width = 240.0, height = 180.0 };
	let map_ground_position = Vector2   { x = 0.0,   y = 0.0 };

	// Ground
	draw_texture_pro(map, map_ground, map_ground_size, Vector2 { x = 0.0, y = 0.0 }, 0.0, get_color(0xFFFFFFFF));
	draw_texture_pro(map, map_ground, map_ground_size, Vector2 { x = 0.0, y = -180.0 }, 0.0, get_color(0xFFFFFFFF));
	draw_texture_pro(map, map_ground, map_ground_size, Vector2 { x = 0.0, y = -180.0 * 2.0 }, 0.0, get_color(0xFFFFFFFF));
	draw_texture_pro(map, map_ground, map_ground_size, Vector2 { x = 0.0, y = -180.0 * 3.0 }, 0.0, get_color(0xFFFFFFFF));

	// Pilars
	draw_texture_pro(map, map_pilar_4, map_pilar_size_4, map_ground_position, 0.0, get_color(0xFFFFFFFF));

	map_pilar_size_4.x = 120.0;
	draw_texture_pro(map, map_pilar_4, map_pilar_size_4, map_ground_position, 0.0, get_color(0xFFFFFFFF));

	map_pilar_size_4.y = -280.0;
	draw_texture_pro(map, map_pilar_4, map_pilar_size_4, map_ground_position, 0.0, get_color(0xFFFFFFFF));

	// Mushroons
	draw_texture_pro(mushroon, map_mushroon, map_mushroon_size, map_ground_position, 0.0, get_color(0xFFFFFFFF));

	map_mushroon_size.x = 40.0;
	map_mushroon_size.y = 30.0;
	map_mushroon_size.width = 30.0;
	draw_texture_pro(mushroon, map_mushroon, map_mushroon_size, map_ground_position, 0.0, get_color(0xFFFFFFFF));

	draw_texture(hare, SCREEN_RESOLUTION.x: int / 3, SCREEN_RESOLUTION.y: int / 3, get_color(0x000000FF));

	// Player
	draw_texture(player_texture, player.position.x: int, player.position.y: int, get_color(0xFFFFFFFF));

	let wall_left = Rectangle { x = 240.0, y = 0.0, width = 2.0, height = 200.0 };
	let wall_right = Rectangle { x = 240.0, y = 200.0, width = 2.0, height = 200.0 };
	let wall_up = Rectangle { x = 240.0, y = 200.0, width = 200.0, height = 2.0 };
	let wall_down = Rectangle { x = 40.0, y = 200.0, width = 200.0, height = 2.0 };

	draw_rectangle_rec(wall_left, GRUV_PURPLE_DARK);
	draw_rectangle_rec(wall_right, GRUV_BLUE_DARK);
	draw_rectangle_rec(wall_up, GRUV_GREEN_DARK);
	draw_rectangle_rec(wall_down, GRUV_RED_DARK);

	if (check_collision_recs(wall_left, player.collision)) player.position.x -= 3.0;
	if (check_collision_recs(wall_right, player.collision)) player.position.x += 3.0;
	if (check_collision_recs(wall_up, player.collision)) player.position.y -= 3.0;
	if (check_collision_recs(wall_down, player.collision)) player.position.y += 3.0;

	debug_info(get_current_monitor(), music);
	end_mode_2d();
	end_drawing();

	// Misc.
	if (is_key_pressed(KeyboardKey::KEY_SPACE)) take_screenshot("scr.png");
	if (is_key_pressed(KeyboardKey::KEY_C)) open_url("https://codeberg.org/guapito/raylib.ha");
};
close_audio_device();
close_window();
};

fn debug_info(monitor: int, music: Music) bool = {

if (is_gamepad_button_down(0,GamepadButton::GAMEPAD_BUTTON_RIGHT_THUMB) || is_key_down(KeyboardKey::KEY_I) ) { 
	// Background
	draw_rectangle(0, 0, get_render_width() + 5, 140, get_color(0x282828AA));

	// Left-side
	draw_text(TITLE, 10, 10, 20, GRUV_FG_LIGHT);
	draw_text("Controller:", 10, 40, 20, GRUV_FG_LIGHT);
	draw_text(get_gamepad_name(0), 130, 40, 20, GRUV_FG_LIGHT);
	draw_text("Music progress:", 10, 70, 20, GRUV_FG_LIGHT);
	draw_text(strconv::itos(get_music_time_played(music): int), 200, 70, 20, GRUV_FG_LIGHT);
	draw_text("/", 240, 70, 20, GRUV_FG_LIGHT);
	draw_text(strconv::itos(get_music_time_length(music): int), 280, 70, 20, GRUV_FG_LIGHT);
	draw_fps(10, 100);

	// Right-side
	draw_text("Resolution:", SCREEN_RESOLUTION.x: u32 - 300, 10, 20, GRUV_FG_LIGHT);
	draw_text(strconv::itos(get_render_width()), SCREEN_RESOLUTION.x: u32 - 180, 10, 20, GRUV_FG_LIGHT);
	draw_text("x", SCREEN_RESOLUTION.x: u32 - 130, 10, 20, GRUV_FG_LIGHT);
	draw_text(strconv::itos(get_render_height()), SCREEN_RESOLUTION.x: u32 - 110, 10, 20, GRUV_FG_LIGHT);
	draw_text("Monitor name:", SCREEN_RESOLUTION.x: u32 - 300, 40, 20, GRUV_FG_LIGHT);
	draw_text(get_monitor_name(monitor), SCREEN_RESOLUTION.x: u32 - 150, 40, 20, GRUV_FG_LIGHT);

	return true;
};

return false;

};


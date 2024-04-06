use fmt;
use types::c;

export type Color = struct {
	r: u8,
	g: u8,
	b: u8,
	a: u8,
};

export type Vector2 = struct {
	x: f32,
	y: f32,
};

export type Vector3 = struct {
	x: f32,
	y: f32,
	z: f32,
};

// Window-Related functions
export fn init_window(width: size, height: size, title: str) void = {
	InitWindow(width, height, c::fromstr(title));
};

export fn set_window_title(title: str) void = {
	SetWindowTitle(c::fromstr(title));
};

@symbol("InitWindow") fn InitWindow(size, size, *c::char) void;
@symbol("SetWindowTitle") fn SetWindowTitle(*c::char) void;
export @symbol("WindowShouldClose") fn window_should_close() bool;
export @symbol("CloseWindow") fn close_window() void;

// Cursor-Related functions
export @symbol("ShowCursor") fn show_cursor() void;
export @symbol("HideCursor") fn hide_cursor() void;
export @symbol("IsCursorHidden") fn is_cursor_hidden() bool;
export @symbol("EnableCursor") fn enable_cursor() void;
export @symbol("DisableCursor") fn disable_cursor() void;
export @symbol("IsCursorOnScreen") fn is_cursor_on_screen() bool;

// Drawing-Related functions
export @symbol("BeginDrawing") fn begin_drawing() void;
export @symbol("EndDrawing") fn end_drawing() void;
export @symbol("ClearBackground") fn clear_background(color: Color) void;

// Timing-Related functions
export @symbol("SetTargetFPS") fn set_target_fps(fps: int) void;
export @symbol("GetFrameTime") fn get_frame_time() f32;
export @symbol("GetTime") fn get_time() f32;
export @symbol("GetFPS") fn get_fps() int;

// Misc. Functions
export fn take_screenshot(filename: str) void = {
	TakeScreenshot(c::fromstr(filename));
};

export fn open_url(url: str) void = {
	OpenURL(c::fromstr(url));
};

@symbol("TakeScreenshot") fn TakeScreenshot(*c::char) void;
@symbol("OpenURL") fn OpenURL(*c::char) void;

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
export @symbol("IsKeyPressed") fn is_key_pressed(key: int) bool;
export @symbol("IsKeyPressedRepeat") fn is_key_pressed_repeat(key: int) bool;
export @symbol("IsKeyDown") fn is_key_down(key: int) bool;
export @symbol("IsKeyReleased") fn is_key_released(key: int) bool;
export @symbol("IsKeyUp") fn is_key_up(key: int) bool;
export @symbol("GetKeyPressed") fn get_key_pressed() int;
export @symbol("GetCharPressed") fn get_char_pressed() int;
export @symbol("SetExitKey") fn set_exit_key(key: int) void;

// Input-related functions: mouse
export @symbol("IsMouseButtonPressed") fn is_mouse_button_pressed(mouse_button: int) bool;
export @symbol("IsMouseButtonDown") fn is_mouse_button_down(mouse_button: int) bool;
export @symbol("IsMouseButtonReleased") fn is_mouse_button_released(mouse_button: int) bool;
export @symbol("IsMouseButtonUp") fn is_mouse_button_up(mouse_button: int) bool;
export @symbol("GetMouseX") fn get_mouse_x() int;
export @symbol("GetMouseY") fn get_mouse_y() int;
export @symbol("SetMousePosition") fn set_mouse_position(x: int, y: int) void;
export @symbol("SetMouseOffset") fn set_mouse_offset(offset_x: int, offset_y: int) void;
export @symbol("SetMouseScale") fn set_mouse_scale(scale_x: f32, scale_y: f32) void;
export @symbol("GetMouseWheelMove") fn get_mouse_wheel_move() f32;
export @symbol("GetMouseWheelMoveV") fn get_mouse_wheel_move_v() Vector2;
export @symbol("SetMouseCursor") fn set_mouse_cursor(cursor: int) void;

// Input-related functions: gamepad
export fn set_gamepad_mappings(mappings: str) void = {
	SetGamepadMappings(c::fromstr(mappings));
};

export @symbol("IsGamepadAvaible") fn is_gamepad_avaible(gamepad: int) bool;
export @symbol("IsGamepadButtonPressed") fn is_gamepad_button_pressed(gamepad: int, button: int) bool;
export @symbol("IsGamepadButtonDown") fn is_gamepad_button_down(gamepad: int, button: int) bool;
export @symbol("IsGamepadButtonReleased") fn is_gamepad_button_released(gamepad: int, button: int) bool;
export @symbol("IsGamepadButtonUp") fn is_gamepad_button_up(gamepad: int, button: int) bool;
export @symbol("GetGamepadButtonPressed") fn get_gamepad_button_pressed() int;
export @symbol("GetGamepadAxisCount") fn get_gamepad_axis_count() int;
export @symbol("GetGamepadAxisMovement") fn get_gamepad_axis_movement(gamepad: int, axis: int) f32;
@symbol("SetGamepadMappings") fn SetGamepadMappings(*c::char) int;

// module: rshapes
// Basic shapes drawing functions
export @symbol("DrawRectangle") fn draw_rectangle(x: int, y: int, w: int, h: int, color: Color) void;

// module: rtextures
// Color/Pixel related functions
export @symbol("GetColor") fn get_color(color: u32) Color;

// module: rtext
// Text-Drawing functions
export fn draw_text(title: str, x: size, y: size, text_size: size, color: Color) void = {
	DrawText(c::fromstr(title), x, y, text_size, color);
};

@symbol("DrawText") fn DrawText(*c::char, size, size, size, Color) void;


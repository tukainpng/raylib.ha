use fmt;
use types::c;

// Structs
export type Vector2 = struct {
	x: f32,
	y: f32,
};

export type Vector3 = struct {
	x: f32,
	y: f32,
	z: f32,
};

export type Vector4 = struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
};

export type Matrix = struct {
	m0: f32, m4: f32, m8: f32, m12: f32,
	m1: f32, m5: f32, m9: f32, m13: f32,
	m2: f32, m6: f32, m10: f32, m14: f32,
	m3: f32, m7: f32, m11: f32, m15: f32,
};

export type Color = struct {
	r: u8,
	g: u8,
	b: u8,
	a: u8,
};

export type Rectangle = struct {
	x: f32,
	y: f32,
	width: f32,
	height: f32,
};

export type Texture = struct {
	id: u32,
	width: int,
	height: int,
	mipmaps: int,
	format: int,
};

export type Texture2D = Texture;
export type TextureCubemap = Texture;

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
export @symbol("DrawPixel") fn draw_pixel(x: int, y: int, color: Color) void;
export @symbol("DrawPixelV") fn draw_pixel_v(position: Vector2, color: Color) void;
export @symbol("DrawLine") fn draw_line(start_x: int, start_y: int, end_x: int, end_y: int, color: Color) void;
export @symbol("DrawLineV") fn draw_line_v(start_position: Vector2, end_position: Vector2, color: Color) void;
export @symbol("DrawLineEx") fn draw_line_ex(start_position: Vector2, end_position: Vector2, thic: f32, color: Color) void;
// TODO:
// DrawLineStrip
export @symbol("DrawLineBezier") fn draw_line_bezier(start_position: Vector2, end_position: Vector2, thic: f32, color: Color) void;
export @symbol("DrawCircle") fn draw_circle(center_x: int, center_y: int, radius: f32, color: Color) void;
export @symbol("DrawCircleSector") fn draw_circle_sector(center: Vector2, radius: f32, start_angle: f32, end_angle: f32, segments: int, color: Color) void;
export @symbol("DrawCircleSectorLines") fn draw_circle_sector_lines(center: Vector2, radius: f32, start_angle: f32, end_angle: f32, segments: int, color: Color) void;
export @symbol("DrawCircleGradient") fn draw_circle_gradient(center_x: int, center_y: int, radius: f32, color_1: Color, color_2: Color) void;
export @symbol("DrawCircleV") fn draw_circle_v(center: Vector2, radius: f32, color: Color) void;
export @symbol("DrawCircleLines") fn draw_circle_lines(center_x: int, center_y: int, radius: f32, color: Color) void;
export @symbol("DrawCircleLinesV") fn draw_circle_lines_v(center: Vector2, radius: f32, color: Color) void;
export @symbol("DrawEllipse") fn draw_ellipse(center_x: int, center_y: int, radius_h: f32, radius_v: f32, color: Color) void;
export @symbol("DrawEllipseLines") fn draw_ellipse_lines(center_x: int, center_y: int, radius_h: f32, radius_v: f32, color: Color) void;
export @symbol("DrawRing") fn draw_ring(center: Vector2, inner_radius: f32, outter_radius: f32, start_angle: f32, end_angle: f32, segments: int, color: Color) void;
export @symbol("DrawRingLine") fn draw_ring_line(center: Vector2, inner_radius: f32, outter_radius: f32, start_angle: f32, end_angle: f32, segments: int, color: Color) void;
export @symbol("DrawRectangle") fn draw_rectangle(x: int, y: int, w: int, h: int, color: Color) void;
export @symbol("DrawRectangleV") fn draw_rectangle_v(position: Vector2, rectangle_size: Vector2, color: Color) void;
// TODO:
// DrawRectangleRec
// DrawRectanglePro
export @symbol("DrawRectangleGradientV") fn draw_rectangle_gradient_v(x: int, y: int, w: int, h: int, color_1: Color, color_2: Color) void;
export @symbol("DrawRectangleGradientH") fn draw_rectangle_gradient_h(x: int, y: int, w: int, h: int, color_1: Color, color_2: Color) void;
// TODO:
// DrawRectangleGradientEx
export @symbol("DrawRectangleLines") fn draw_rectangle_lines(x: int, y: int, w: int, h: int, color: Color) void;
// TODO:
// DrawRectangleLinesEx
// DrawRectangleRounded
// DrawRectangleRoundedLines
export @symbol("DrawTriangle") fn draw_triangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
export @symbol("DrawTriangleLines") fn draw_triangle_lines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
// TODO:
// DrawTriangleFan
// DrawTriangleStrip
export @symbol("DrawPoly") fn draw_poly(center: Vector2, sides: int, radius: f32, rotation: f32, color: Color) void;
export @symbol("DrawPolyLines") fn draw_poly_lines(center: Vector2, sides: int, radius: f32, rotation: f32, color: Color) void;
export @symbol("DrawPolyLinesEx") fn draw_poly_lines_ex(center: Vector2, sides: int, radius: f32, rotation: f32, line_thic: f32,color: Color) void;

// module: rtextures

// STILL IN DEVELOPMENT
// ---------------------------------------------------------------------------------------------------
// Texture loading functions
export fn load_texture(filename: str) Texture2D = {
	return LoadTexture(c::fromstr(filename));
};
@symbol("LoadTexture") fn LoadTexture(*c::char) Texture2D;
export @symbol("UnloadTexture") fn unload_texture(texture: Texture2D) void;

// Texture drawing functions
export @symbol("DrawTexture") fn draw_texture(texture: Texture, x: int, y: int, tint: Color) void;
// ---------------------------------------------------------------------------------------------------

// Color/Pixel related functions
export @symbol("GetColor") fn get_color(color: u32) Color;

// module: rtext
// Text-Drawing functions
export @symbol("DrawFPS") fn draw_fps(x: int, y: int) void;
export fn draw_text(title: str, x: size, y: size, text_size: size, color: Color) void = {
	DrawText(c::fromstr(title), x, y, text_size, color);
};
@symbol("DrawText") fn DrawText(*c::char, size, size, size, Color) void;

// Text font info functions
export @symbol("SetTextLineSpacing") fn set_text_line_spacing(spacing: int) void;


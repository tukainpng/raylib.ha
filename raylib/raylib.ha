use fmt;
use types::c;

// Structs
export type Vector2 = struct { x: f32, y: f32 };
export type Vector3 = struct { x: f32, y: f32, z: f32 };
export type Vector4 = struct { x: f32, y: f32, z: f32, w: f32 };

export type Matrix = struct {
	m0: f32, m4: f32, m8: f32, m12: f32,
	m1: f32, m5: f32, m9: f32, m13: f32,
	m2: f32, m6: f32, m10: f32, m14: f32,
	m3: f32, m7: f32, m11: f32, m15: f32,
};

export type Color = struct { r: u8, g: u8, b: u8, a: u8 };

export type Rectangle = struct {
	x: f32,
	y: f32,
	width: f32,
	height: f32,
};

export type Image = struct {
	data: *opaque,
	width: int,
	height: int,
	mipmaps: int,
	format: int,
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

export type RenderTexture = struct {
	id: u32,
	texture: Texture,
	depth: Texture,
};

export type RenderTexture2D = RenderTexture;

export type Camera2D = struct {
	cam_offset: Vector2,
	target: Vector2,
	rotation: f32,
	zoom: f32,
};

// Gruvbox colors
export const BG_DARK		= Color { r = 40,  g = 40,  b = 40,  a = 255 };
export const BG_LIGHT		= Color { r = 60,  g = 56,  b = 54,  a = 255 };
export const FG_DARK		= Color { r = 168, g = 153, b = 132, a = 255 };
export const FG_LIGHT		= Color { r = 235, g = 219, b = 178, a = 255 };
export const RED_DARK		= Color { r = 204, g = 36,  b = 29,  a = 255 };
export const RED_LIGHT		= Color { r = 251, g = 73,  b = 52,  a = 255 };
export const GREEN_DARK		= Color { r = 152, g = 151, b = 26,  a = 255 };
export const GREEN_LIGHT	= Color { r = 184, g = 187, b = 38,  a = 255 };
export const YELLOW_DARK	= Color { r = 215, g = 153, b = 33,  a = 255 };
export const YELLOW_LIGHT	= Color { r = 250, g = 189, b = 47,  a = 255 };
export const BLUE_DARK		= Color { r = 69,  g = 133, b = 136, a = 255 };
export const BLUE_LIGHT		= Color { r = 131, g = 165, b = 152, a = 255 };
export const PURPLE_DARK	= Color { r = 177, g = 98,  b = 134, a = 255 };
export const PURPLE_LIGHT	= Color { r = 211, g = 134, b = 155, a = 255 };
export const AQUA_DARK		= Color { r = 104, g = 157, b = 106, a = 255 };
export const AQUA_LIGHT		= Color { r = 142, g = 192, b = 124, a = 255 };
export const ORANGE_DARK	= Color { r = 214, g = 93,  b = 14,  a = 255 };
export const ORANGE_LIGHT	= Color { r = 254, g = 128, b = 25,  a = 255 };

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
// TODO:
// IsWindowReady
// IsWindowFullscreen
// IsWindowHidden
// IsWindowMinimized
// IsWindowMaximized
// IsWindowFocused
// IsWindowResized
// IsWindowState
// SetWindowState
// ClearWindowState
// ToggleFullscreen
// ToggleBorderlessWindowed
// MaximizeWindow
// MinimizeWindow
// RestoreWindow
// SetWindowIcon
// SetWindowIcons
// SetWindowPosition
// SetWindowMonitor
// SetWindowMinSize
// SetWindowMaxSize
// SetWindowSize
// SetWindowOpacity
// SetWindowFocused
// *GetWindowHandle
// GetScreenWidth
// GetScreenHeight
// GetRenderWidth
// GetRenderHeight
// GetMonitorCount
// GetCurrentMonitor
// GetMonitorPosition
// GetMonitorWidth
// GetMonitorHeight
// GetMonitorPhysicalWidth
// GetMonitorPhysicalHeight
// GetMonitorRefreshRate
// GetWindowPosition
// GetWindowScaleDPI
// *GetMonitorName
// SetClipboardText
// *GetClipboardText
// EnableEventWaiting
// DisableEventWaiting

// Cursor-Related functions
export @symbol("ShowCursor") fn show_cursor() void;			// Shows cursor
export @symbol("HideCursor") fn hide_cursor() void;			// Hides cursor
export @symbol("IsCursorHidden") fn is_cursor_hidden() bool;		// Check if cursor is not visible
export @symbol("EnableCursor") fn enable_cursor() void;			// Enables cursor (unlock cursor)
export @symbol("DisableCursor") fn disable_cursor() void;		// Disables cursor (lock cursor)
export @symbol("IsCursorOnScreen") fn is_cursor_on_screen() bool;	// Check if cursor is on the screen

// Drawing-Related functions
export @symbol("BeginDrawing") fn begin_drawing() void;
export @symbol("EndDrawing") fn end_drawing() void;
export @symbol("BeginMode2D") fn begin_mode_2d(camera: Camera2D) void;
export @symbol("EndMode2D") fn end_mode_2d() void;
export @symbol("BeginTextureMode") fn begin_texture_mode(target: RenderTexture2D) void;
export @symbol("EndTextureMode") fn end_texture_mode() void;
export @symbol("ClearBackground") fn clear_background(color: Color) void;
// TODO:
// BeginShaderMode
// EndShaderMode
// BeginBlendMode
// EndBlendMode
// BeginScissorMode
// EndScissorMode
// BeginVrStereoMode
// EndVrStereoMode

// Timing-Related functions
export @symbol("SetTargetFPS") fn set_target_fps(fps: int) void;	// Set target FPS (maximum)
export @symbol("GetFrameTime") fn get_frame_time() f32;			// Get time in seconds for last frame drawn (delta time)
export @symbol("GetTime") fn get_time() f64;				// Get elapsed time in seconds since InitWindow()
export @symbol("GetFPS") fn get_fps() int;				// Get current FPS

// Misc. Functions
export fn take_screenshot(filename: str) void = {
	TakeScreenshot(c::fromstr(filename));
};

export fn open_url(url: str) void = {
	OpenURL(c::fromstr(url));
};

@symbol("TakeScreenshot") fn TakeScreenshot(*c::char) void;	// Takes a screenshot of current screen (filename extension defines format)
@symbol("OpenURL") fn OpenURL(*c::char) void;			// Open URL with default system browser (if available)

//------------------------------------------------------------------------------------
// Input Handling Functions (Module: core)
//------------------------------------------------------------------------------------

// Input-related functions: keyboard
export @symbol("IsKeyPressed") fn is_key_pressed(key: int) bool;		// Check if a key has been pressed once
export @symbol("IsKeyPressedRepeat") fn is_key_pressed_repeat(key: int) bool;	// Check if a key has been pressed again (Only PLATFORM_DESKTOP)
export @symbol("IsKeyDown") fn is_key_down(key: int) bool;			// Check if a key is being pressed
export @symbol("IsKeyReleased") fn is_key_released(key: int) bool;		// Check if a key has been released once
export @symbol("IsKeyUp") fn is_key_up(key: int) bool;				// Check if a key is NOT being pressed
export @symbol("GetKeyPressed") fn get_key_pressed() int;			// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
export @symbol("GetCharPressed") fn get_char_pressed() int;			// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
export @symbol("SetExitKey") fn set_exit_key(key: int) void;			// Set a custom key to exit program (default is ESC)

// Input-related functions: gamepad
export fn set_gamepad_mappings(mappings: str) void = {
	SetGamepadMappings(c::fromstr(mappings));
};

export @symbol("IsGamepadAvaible") fn is_gamepad_avaible(gamepad: int) bool;					// Check if a gamepad is available
export @symbol("GetGamepadName") fn get_gamepad_name(gamepad: int) const *c::char;				// Get gamepad internal name id
export @symbol("IsGamepadButtonPressed") fn is_gamepad_button_pressed(gamepad: int, button: int) bool;		// Check if a gamepad button has been pressed once
export @symbol("IsGamepadButtonDown") fn is_gamepad_button_down(gamepad: int, button: int) bool;		// Check if a gamepad button is being pressed
export @symbol("IsGamepadButtonReleased") fn is_gamepad_button_released(gamepad: int, button: int) bool;	// Check if a gamepad button has been released once
export @symbol("IsGamepadButtonUp") fn is_gamepad_button_up(gamepad: int, button: int) bool;			// Check if a gamepad button is NOT being pressed
export @symbol("GetGamepadButtonPressed") fn get_gamepad_button_pressed() int;					// Get the last gamepad button pressed
export @symbol("GetGamepadAxisCount") fn get_gamepad_axis_count() int;						// Get gamepad axis count for a gamepad
export @symbol("GetGamepadAxisMovement") fn get_gamepad_axis_movement(gamepad: int, axis: int) f32;		// Get axis movement value for a gamepad axis
@symbol("SetGamepadMappings") fn SetGamepadMappings(*c::char) int;						// Set internal gamepad mappings (SDL_GameControllerDB)

// Input-related functions: mouse
export @symbol("IsMouseButtonPressed") fn is_mouse_button_pressed(mouse_button: int) bool;	// Check if a mouse button has been pressed once
export @symbol("IsMouseButtonDown") fn is_mouse_button_down(mouse_button: int) bool;		// Check if a mouse button is being pressed
export @symbol("IsMouseButtonReleased") fn is_mouse_button_released(mouse_button: int) bool;	// Check if a mouse button has been released once
export @symbol("IsMouseButtonUp") fn is_mouse_button_up(mouse_button: int) bool;		// Check if a mouse button is NOT being pressed
export @symbol("GetMouseX") fn get_mouse_x() int;						// Get mouse position X
export @symbol("GetMouseY") fn get_mouse_y() int;						// Get mouse position Y
export @symbol("GetMousePosition") fn get_mouse_position() Vector2;				// Get mouse position XY
export @symbol("GetMouseDelta") fn get_mouse_delta() Vector2;					// Get mouse delta between frames
export @symbol("SetMousePosition") fn set_mouse_position(x: int, y: int) void;			// Set mouse position XY
export @symbol("SetMouseOffset") fn set_mouse_offset(offset_x: int, offset_y: int) void;	// Set mouse offset
export @symbol("SetMouseScale") fn set_mouse_scale(scale_x: f32, scale_y: f32) void;		// Set mouse scaling
export @symbol("GetMouseWheelMove") fn get_mouse_wheel_move() f32;				// Get mouse wheel movement for X or Y, whichever is larger
export @symbol("GetMouseWheelMoveV") fn get_mouse_wheel_move_v() Vector2;			// Get mouse wheel movement for both X and Y
export @symbol("SetMouseCursor") fn set_mouse_cursor(cursor: int) void;				// Set mouse cursor

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
export @symbol("DrawRectangleRec") fn draw_rectangle_rec(rec: Rectangle, color: Color) void;
export @symbol("DrawRectanglePro") fn draw_rectangle_pro(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) void;
export @symbol("DrawRectangleGradientV") fn draw_rectangle_gradient_v(x: int, y: int, w: int, h: int, color_1: Color, color_2: Color) void;
export @symbol("DrawRectangleGradientH") fn draw_rectangle_gradient_h(x: int, y: int, w: int, h: int, color_1: Color, color_2: Color) void;
export @symbol("DrawRectangleGradientEx") fn draw_rectangle_gradient_ex(rec: Rectangle, color_1: Color, color_2: Color, color_3: Color, color_4: Color, ) void;
export @symbol("DrawRectangleLines") fn draw_rectangle_lines(x: int, y: int, w: int, h: int, color: Color) void;
export @symbol("DrawRectangleLinesEx") fn draw_rectangle_lines_ex(rec: Rectangle, line_thic: f32, color: Color) void;
export @symbol("DrawRectangleRounded") fn draw_rectangle_rounded(rec: Rectangle, roundness: f32, segments: int, color: Color) void;
export @symbol("DrawRectangleRoundedLines") fn draw_rectangle_rounded_lines(rec: Rectangle, roundness: f32, segments: int, line_thic: f32, color: Color) void;
export @symbol("DrawTriangle") fn draw_triangle(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
export @symbol("DrawTriangleLines") fn draw_triangle_lines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
// TODO:
// DrawTriangleFan
// DrawTriangleStrip
export @symbol("DrawPoly") fn draw_poly(center: Vector2, sides: int, radius: f32, rotation: f32, color: Color) void;
export @symbol("DrawPolyLines") fn draw_poly_lines(center: Vector2, sides: int, radius: f32, rotation: f32, color: Color) void;
export @symbol("DrawPolyLinesEx") fn draw_poly_lines_ex(center: Vector2, sides: int, radius: f32, rotation: f32, line_thic: f32,color: Color) void;

// module: rtextures
// Image loading functions
export fn load_image(filename: str) Image = { return LoadImage(c::fromstr(filename)); };
@symbol("LoadImage") fn LoadImage(*c::char) Image;

// Texture loading functions
export fn load_texture(filename: str) Texture2D = { return LoadTexture(c::fromstr(filename)); };
@symbol("LoadTexture") fn LoadTexture(*c::char) Texture2D;
export @symbol("LoadTextureFromImage") fn load_texture_from_image(image: Image) Texture2D;
export @symbol("UnloadTexture") fn unload_texture(texture: Texture2D) void;

// Texture drawing functions
export @symbol("DrawTexture") fn draw_texture(texture: Texture, x: int, y: int, tint: Color) void;

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


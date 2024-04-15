use types::c;

// Structs
export type Vector2 = struct { x: f32, y: f32 };
export type Vector3 = struct { x: f32, y: f32, z: f32 };
export type Vector4 = struct { x: f32, y: f32, z: f32, w: f32 };
export type Quaternion = Vector4;

export type Matrix = struct {
	m0: f32, m4: f32, m8: f32, m12: f32,
	m1: f32, m5: f32, m9: f32, m13: f32,
	m2: f32, m6: f32, m10: f32, m14: f32,
	m3: f32, m7: f32, m11: f32, m15: f32,
};

export type Color = struct { r: u8, g: u8, b: u8, a: u8 };

export type Rectangle = struct {
	x:		f32,
	y:		f32,
	width:		f32,
	height:		f32,
};

export type Triangle = struct {
	point_1:	Vector2,
	point_2:	Vector2,
	point_3:	Vector2,
};

export type Image = struct {
	data:		*opaque,
	width:		int,
	height:		int,
	mipmaps:	int,
	format:		int,
};

export type Texture = struct {
	id: 		u32,
	width:		int,
	height:		int,
	mipmaps:	int,
	format:		int,
};

export type Texture2D = Texture;
export type TextureCubemap = Texture;

export type RenderTexture = struct {
	id:		u32,
	texture:	Texture,
	depth:		Texture,
};

export type RenderTexture2D = RenderTexture;

export type NPatchInfo = struct {
	source:		Rectangle,
	left:		int,
	top:		int,
	right:		int,
	bottom:		int,
	layout:		int,
};

export type GlyphInfo = struct {
	value:		int,
	offset_x:	int,
	offset_y:	int,
	advance_x:	int,
	image:		Image,
};

export type Font = struct {
	base_size:	int,
	glyph_count:	int,
	glyph_padding:	int,
	texture:	Texture2D,
	recs:		*Rectangle,
	glyphs:		*GlyphInfo,
};

export type Camera2D = struct {
	cam_offset:	Vector2,
	target:		Vector2,
	rotation:	f32,
	zoom:		f32,
};

export type Wave = struct {
	frame_count:	u32,
	sample_rate:	u32,
	sample_size:	u32,
	channels:	u32,
	data:		*opaque,
};

export type rAudioBuffer = *rAudioBuffer;
export type rAudioProcessor = *rAudioProcessor;

export type AudioStream = struct {
	buffer:		rAudioBuffer,
	processor:	rAudioProcessor,

	sample_rate:	u32,
	sample_size:	u32,
	channels:	u32,
};

export type Sound = struct {
	stream:		AudioStream,
	frame_count:	u32,
};

export type Music = struct {
	stream:		AudioStream,
	frame_count:	u32,
	looping:	bool,
	context_type:	int,
	context_data:	*opaque
};

export type FilePathList = struct {
	capacity:	u32,
	count:		u32,
	paths:		**str
};

// Enums
export type ConfigFlags = enum {
	FLAG_FULLSCREEN_MODE    = 0x00000002,
	FLAG_WINDOW_RESIZABLE   = 0x00000004,
	FLAG_WINDOW_UNDECORATED = 0x00000008,
	FLAG_WINDOW_HIDDEN      = 0x00000080,
	FLAG_WINDOW_MINIMIZED   = 0x00000200,
	FLAG_WINDOW_MAXIMIZED   = 0x00000400,
	FLAG_WINDOW_UNFOCUSED   = 0x00000800,
	FLAG_WINDOW_TOPMOST     = 0x00001000,
	FLAG_WINDOW_ALWAYS_RUN  = 0x00000100,
	FLAG_WINDOW_TRANSPARENT = 0x00000010,
};

export type KeyboardKey = enum {
	KEY_NULL            = 0,
	// Alphanumeric keys
	KEY_APOSTROPHE      = 39,
	KEY_COMMA           = 44,
	KEY_MINUS           = 45,
	KEY_PERIOD          = 46,
	KEY_SLASH           = 47,
	KEY_ZERO            = 48,
	KEY_ONE             = 49,
	KEY_TWO             = 50,
	KEY_THREE           = 51,
	KEY_FOUR            = 52,
	KEY_FIVE            = 53,
	KEY_SIX             = 54,
	KEY_SEVEN           = 55,
	KEY_EIGHT           = 56,
	KEY_NINE            = 57,
	KEY_SEMICOLON       = 59,
	KEY_EQUAL           = 61,
	KEY_A               = 65,
	KEY_B               = 66,
	KEY_C               = 67,
	KEY_D               = 68,
	KEY_E               = 69,
	KEY_F               = 70,
	KEY_G               = 71,
	KEY_H               = 72,
	KEY_I               = 73,
	KEY_J               = 74,
	KEY_K               = 75,
	KEY_L               = 76,
	KEY_M               = 77,
	KEY_N               = 78,
	KEY_O               = 79,
	KEY_P               = 80,
	KEY_Q               = 81,
	KEY_R               = 82,
	KEY_S               = 83,
	KEY_T               = 84,
	KEY_U               = 85,
	KEY_V               = 86,
	KEY_W               = 87,
	KEY_X               = 88,
	KEY_Y               = 89,
	KEY_Z               = 90,
	KEY_LEFT_BRACKET    = 91,
	KEY_BACKSLASH       = 92,
	KEY_RIGHT_BRACKET   = 93,
	KEY_GRAVE           = 96,
	// Function keys
	KEY_SPACE           = 32,
	KEY_ESCAPE          = 256,
	KEY_ENTER           = 257,
	KEY_TAB             = 258,
	KEY_BACKSPACE       = 259,
	KEY_INSERT          = 260,
	KEY_DELETE          = 261,
	KEY_RIGHT           = 262,
	KEY_LEFT            = 263,
	KEY_DOWN            = 264,
	KEY_UP              = 265,
	KEY_PAGE_UP         = 266,
	KEY_PAGE_DOWN       = 267,
	KEY_HOME            = 268,
	KEY_END             = 269,
	KEY_CAPS_LOCK       = 280,
	KEY_SCROLL_LOCK     = 281,
	KEY_NUM_LOCK        = 282,
	KEY_PRINT_SCREEN    = 283,
	KEY_PAUSE           = 284,
	KEY_F1              = 290,
	KEY_F2              = 291,
	KEY_F3              = 292,
	KEY_F4              = 293,
	KEY_F5              = 294,
	KEY_F6              = 295,
	KEY_F7              = 296,
	KEY_F8              = 297,
	KEY_F9              = 298,
	KEY_F10             = 299,
	KEY_F11             = 300,
	KEY_F12             = 301,
	KEY_LEFT_SHIFT      = 340,
	KEY_LEFT_CONTROL    = 341,
	KEY_LEFT_ALT        = 342,
	KEY_LEFT_SUPER      = 343,
	KEY_RIGHT_SHIFT     = 344,
	KEY_RIGHT_CONTROL   = 345,
	KEY_RIGHT_ALT       = 346,
	KEY_RIGHT_SUPER     = 347,
	KEY_KB_MENU         = 348,
	// Keypad keys
	KEY_KP_0            = 320,
	KEY_KP_1            = 321,
	KEY_KP_2            = 322,
	KEY_KP_3            = 323,
	KEY_KP_4            = 324,
	KEY_KP_5            = 325,
	KEY_KP_6            = 326,
	KEY_KP_7            = 327,
	KEY_KP_8            = 328,
	KEY_KP_9            = 329,
	KEY_KP_DECIMAL      = 330,
	KEY_KP_DIVIDE       = 331,
	KEY_KP_MULTIPLY     = 332,
	KEY_KP_SUBTRACT     = 333,
	KEY_KP_ADD          = 334,
	KEY_KP_ENTER        = 335,
	KEY_KP_EQUAL        = 336,
};

export type MouseButton = enum {
	MOUSE_BUTTON_LEFT    = 0,
	MOUSE_BUTTON_RIGHT   = 1,
	MOUSE_BUTTON_MIDDLE  = 2,
	MOUSE_BUTTON_SIDE    = 3,
	MOUSE_BUTTON_EXTRA   = 4,
	MOUSE_BUTTON_FORWARD = 5,
	MOUSE_BUTTON_BACK    = 6,
};

export type MouseCursor = enum {
	MOUSE_CURSOR_DEFAULT       = 0,
	MOUSE_CURSOR_ARROW         = 1,
	MOUSE_CURSOR_IBEAM         = 2,
	MOUSE_CURSOR_CROSSHAIR     = 3,
	MOUSE_CURSOR_POINTING_HAND = 4,
	MOUSE_CURSOR_RESIZE_EW     = 5,
	MOUSE_CURSOR_RESIZE_NS     = 6,
	MOUSE_CURSOR_RESIZE_NWSE   = 7,
	MOUSE_CURSOR_RESIZE_NESW   = 8,
	MOUSE_CURSOR_RESIZE_ALL    = 9,
	MOUSE_CURSOR_NOT_ALLOWED   = 10
};

export type GamepadButton = enum {
	GAMEPAD_BUTTON_UNKNOWN = 0,
	GAMEPAD_BUTTON_LEFT_FACE_UP,
	GAMEPAD_BUTTON_LEFT_FACE_RIGHT,
	GAMEPAD_BUTTON_LEFT_FACE_DOWN,
	GAMEPAD_BUTTON_LEFT_FACE_LEFT,
	GAMEPAD_BUTTON_RIGHT_FACE_UP,
	GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,
	GAMEPAD_BUTTON_RIGHT_FACE_DOWN,
	GAMEPAD_BUTTON_RIGHT_FACE_LEFT,
	GAMEPAD_BUTTON_LEFT_TRIGGER_1,
	GAMEPAD_BUTTON_LEFT_TRIGGER_2,
	GAMEPAD_BUTTON_RIGHT_TRIGGER_1,
	GAMEPAD_BUTTON_RIGHT_TRIGGER_2,
	GAMEPAD_BUTTON_MIDDLE_LEFT,
	GAMEPAD_BUTTON_MIDDLE,
	GAMEPAD_BUTTON_MIDDLE_RIGHT,
	GAMEPAD_BUTTON_LEFT_THUMB,
	GAMEPAD_BUTTON_RIGHT_THUMB
};

export type GamepadAxis = enum {
	GAMEPAD_AXIS_LEFT_X        = 0,
	GAMEPAD_AXIS_LEFT_Y        = 1,
	GAMEPAD_AXIS_RIGHT_X       = 2,
	GAMEPAD_AXIS_RIGHT_Y       = 3,
	GAMEPAD_AXIS_LEFT_TRIGGER  = 4,
	GAMEPAD_AXIS_RIGHT_TRIGGER = 5
};

export type PixelFormat = enum {
	PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,
	PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,
	PIXELFORMAT_UNCOMPRESSED_R5G6B5,
	PIXELFORMAT_UNCOMPRESSED_R8G8B8,
	PIXELFORMAT_UNCOMPRESSED_R5G5B5A1,
	PIXELFORMAT_UNCOMPRESSED_R4G4B4A4,
	PIXELFORMAT_UNCOMPRESSED_R8G8B8A8,
	PIXELFORMAT_UNCOMPRESSED_R32,
	PIXELFORMAT_UNCOMPRESSED_R32G32B32,
	PIXELFORMAT_UNCOMPRESSED_R32G32B32A32,
	PIXELFORMAT_UNCOMPRESSED_R16,
	PIXELFORMAT_UNCOMPRESSED_R16G16B16,
	PIXELFORMAT_UNCOMPRESSED_R16G16B16A16,
	PIXELFORMAT_COMPRESSED_DXT1_RGB,
	PIXELFORMAT_COMPRESSED_DXT1_RGBA,
	PIXELFORMAT_COMPRESSED_DXT3_RGBA,
	PIXELFORMAT_COMPRESSED_DXT5_RGBA,
	PIXELFORMAT_COMPRESSED_ETC1_RGB,
	PIXELFORMAT_COMPRESSED_ETC2_RGB,
	PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA,
	PIXELFORMAT_COMPRESSED_PVRT_RGB,
	PIXELFORMAT_COMPRESSED_PVRT_RGBA,
	PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA,
	PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA
};

export type FontType = enum {
	FONT_DEFAULT = 0,
	FONT_BITMAP,
	FONT_SDF
};

export type NPatchLayout = enum {
	NPATCH_NINE_PATCH = 0,          // Npatch layout: 3x3 tiles
	NPATCH_THREE_PATCH_VERTICAL,    // Npatch layout: 1x3 tiles
	NPATCH_THREE_PATCH_HORIZONTAL   // Npatch layout: 3x1 tiles};
};

// Gruvbox colors
export const GRUV_BG_DARK		= Color { r = 40,  g = 40,  b = 40,  a = 255 };
export const GRUV_FG_DARK		= Color { r = 168, g = 153, b = 132, a = 255 };
export const GRUV_RED_DARK		= Color { r = 204, g = 36,  b = 29,  a = 255 };
export const GRUV_GREEN_DARK		= Color { r = 152, g = 151, b = 26,  a = 255 };
export const GRUV_YELLOW_DARK		= Color { r = 215, g = 153, b = 33,  a = 255 };
export const GRUV_BLUE_DARK		= Color { r = 69,  g = 133, b = 136, a = 255 };
export const GRUV_PURPLE_DARK		= Color { r = 177, g = 98,  b = 134, a = 255 };
export const GRUV_AQUA_DARK		= Color { r = 104, g = 157, b = 106, a = 255 };
export const GRUV_ORANGE_DARK		= Color { r = 214, g = 93,  b = 14,  a = 255 };
export const GRUV_BG_LIGHT		= Color { r = 60,  g = 56,  b = 54,  a = 255 };
export const GRUV_FG_LIGHT		= Color { r = 235, g = 219, b = 178, a = 255 };
export const GRUV_RED_LIGHT		= Color { r = 251, g = 73,  b = 52,  a = 255 };
export const GRUV_GREEN_LIGHT		= Color { r = 184, g = 187, b = 38,  a = 255 };
export const GRUV_YELLOW_LIGHT		= Color { r = 250, g = 189, b = 47,  a = 255 };
export const GRUV_BLUE_LIGHT		= Color { r = 131, g = 165, b = 152, a = 255 };
export const GRUV_PURPLE_LIGHT		= Color { r = 211, g = 134, b = 155, a = 255 };
export const GRUV_AQUA_LIGHT		= Color { r = 142, g = 192, b = 124, a = 255 };
export const GRUV_ORANGE_LIGHT		= Color { r = 254, g = 128, b = 25,  a = 255 };

// Raylib colors
export const LIGHTGRAY			= Color { r = 200, g = 200, b = 200, a = 255 };
export const GRAY			= Color { r = 130, g = 130, b = 130, a = 255 };
export const DARKGRAY			= Color { r = 80,  g = 80,  b = 80,  a = 255 };
export const YELLOW			= Color { r = 253, g = 249, b = 0,   a = 255 };
export const GOLD			= Color { r = 255, g = 203, b = 0,   a = 255 };
export const ORANGE			= Color { r = 255, g = 161, b = 0,   a = 255 };
export const PINK			= Color { r = 255, g = 109, b = 194, a = 255 };
export const RED			= Color { r = 230, g = 41,  b = 55,  a = 255 };
export const MAROON			= Color { r = 190, g = 33,  b = 55,  a = 255 };
export const GREEN			= Color { r = 0,   g = 228, b = 48,  a = 255 };
export const LIME			= Color { r = 0,   g = 158, b = 47,  a = 255 };
export const DARKGREEN			= Color { r = 0,   g = 117, b = 44,  a = 255 };
export const SKYBLUE			= Color { r = 102, g = 191, b = 255, a = 255 };
export const BLUE			= Color { r = 0,   g = 121, b = 241, a = 255 };
export const DARKBLUE			= Color { r = 0,   g = 82,  b = 172, a = 255 };
export const PURPLE			= Color { r = 200, g = 122, b = 255, a = 255 };
export const VIOLET			= Color { r = 135, g = 60,  b = 190, a = 255 };
export const DARKPURPLE			= Color { r = 112, g = 31,  b = 126, a = 255 };
export const BEIGE			= Color { r = 211, g = 176, b = 131, a = 255 };
export const BROWN			= Color { r = 127, g = 106, b = 79,  a = 255 };
export const DARKBROWN			= Color { r = 76,  g = 63,  b = 47,  a = 255 };
export const WHITE			= Color { r = 255, g = 255, b = 255, a = 255 };
export const BLACK			= Color { r = 0,   g = 0,   b = 0,   a = 255 };
export const BLANK			= Color { r = 0,   g = 0,   b = 0,   a = 0 };
export const MAGENTA			= Color { r = 255, g = 0,   b = 255, a = 255 };
export const RAYWHITE			= Color { r = 245, g = 245, b = 245, a = 255 };

// Window-Related functions
@symbol("InitWindow") fn InitWindow(size, size, *c::char) void;
@symbol("SetWindowTitle") fn SetWindowTitle(*c::char) void;
@symbol("GetMonitorName") fn GetMonitorName(monitor: int) const *c::char;
export fn init_window(width: size, height: size, title: str) void = InitWindow(width, height, c::fromstr(title));
export @symbol("CloseWindow") fn close_window() void;
export @symbol("WindowShouldClose") fn window_should_close() bool;
export fn set_window_title(title: str) void = SetWindowTitle(c::fromstr(title));
export @symbol("GetScreenWidth") fn get_screen_width() int;
export @symbol("GetScreenHeight") fn get_screen_height() int;
export @symbol("GetRenderWidth") fn get_render_width() int;
export @symbol("GetRenderHeight") fn get_render_height() int;
export @symbol("GetCurrentMonitor") fn get_current_monitor() int;
export @symbol("GetMonitorWidth") fn get_monitor_width(monitor: int) int;
export @symbol("GetMonitorHeight") fn get_monitor_height(monitor: int) int;
export @symbol("GetMonitorRefreshRate") fn get_monitor_refresh_rate(monitor: int) int;
export @symbol("GetWindowPosition") fn get_window_position() Vector2;
export @symbol("GetWindowScaleDPI") fn get_window_scale_dpi() Vector2;
export fn get_monitor_name(monitor: int) str = return c::tostr(GetMonitorName(monitor))!;
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
// GetMonitorCount
// GetMonitorPosition
// GetMonitorPhysicalWidth
// GetMonitorPhysicalHeight
// SetClipboardText
// *GetClipboardText
// EnableEventWaiting
// DisableEventWaiting

// Cursor-Related functions
export @symbol("ShowCursor") fn show_cursor() void;
export @symbol("HideCursor") fn hide_cursor() void;
export @symbol("IsCursorHidden") fn is_cursor_hidden() bool;
export @symbol("EnableCursor") fn enable_cursor() void;
export @symbol("DisableCursor") fn disable_cursor() void;
export @symbol("IsCursorOnScreen") fn is_cursor_on_screen() bool;

// Drawing-Related functions
export @symbol("ClearBackground") fn clear_background(color: Color) void;
export @symbol("BeginDrawing") fn begin_drawing() void;
export @symbol("EndDrawing") fn end_drawing() void;
export @symbol("BeginMode2D") fn begin_mode_2d(camera: Camera2D) void;
export @symbol("EndMode2D") fn end_mode_2d() void;
export @symbol("BeginTextureMode") fn begin_texture_mode(target: RenderTexture2D) void;
export @symbol("EndTextureMode") fn end_texture_mode() void;
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
export @symbol("SetTargetFPS") fn set_target_fps(fps: int) void;
export @symbol("GetFrameTime") fn get_frame_time() f32;
export @symbol("GetTime") fn get_time() f64;
export @symbol("GetFPS") fn get_fps() int;

// Misc. functions
@symbol("TakeScreenshot") fn TakeScreenshot(*c::char) void;
@symbol("OpenURL") fn OpenURL(*c::char) void;
export fn take_screenshot(filename: str) void = TakeScreenshot(c::fromstr(filename));
export fn open_url(url: str) void = OpenURL(c::fromstr(url));

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

// Input-related functions: gamepad
@symbol("GetGamepadName") fn GetGamepadName(gamepad: int) const *c::char;
@symbol("SetGamepadMappings") fn SetGamepadMappings(*c::char) int;
export @symbol("IsGamepadAvaible") fn is_gamepad_avaible(gamepad: int) bool;
export fn get_gamepad_name(gamepad: int) str = return c::tostr(GetGamepadName(gamepad))!;
export @symbol("IsGamepadButtonPressed") fn is_gamepad_button_pressed(gamepad: int, button: int) bool;
export @symbol("IsGamepadButtonDown") fn is_gamepad_button_down(gamepad: int, button: int) bool;
export @symbol("IsGamepadButtonReleased") fn is_gamepad_button_released(gamepad: int, button: int) bool;
export @symbol("IsGamepadButtonUp") fn is_gamepad_button_up(gamepad: int, button: int) bool;
export @symbol("GetGamepadButtonPressed") fn get_gamepad_button_pressed() int;
export @symbol("GetGamepadAxisCount") fn get_gamepad_axis_count() int;
export @symbol("GetGamepadAxisMovement") fn get_gamepad_axis_movement(gamepad: int, axis: int) f32;
export fn set_gamepad_mappings(mappings: str) int = SetGamepadMappings(c::fromstr(mappings));

// Input-related functions: mouse
export @symbol("IsMouseButtonPressed") fn is_mouse_button_pressed(mouse_button: int) bool;
export @symbol("IsMouseButtonDown") fn is_mouse_button_down(mouse_button: int) bool;
export @symbol("IsMouseButtonReleased") fn is_mouse_button_released(mouse_button: int) bool;
export @symbol("IsMouseButtonUp") fn is_mouse_button_up(mouse_button: int) bool;
export @symbol("GetMouseX") fn get_mouse_x() int;
export @symbol("GetMouseY") fn get_mouse_y() int;
export @symbol("GetMousePosition") fn get_mouse_position() Vector2;
export @symbol("GetMouseDelta") fn get_mouse_delta() Vector2;
export @symbol("SetMousePosition") fn set_mouse_position(x: int, y: int) void;
export @symbol("SetMouseOffset") fn set_mouse_offset(offset_x: int, offset_y: int) void;
export @symbol("SetMouseScale") fn set_mouse_scale(scale_x: f32, scale_y: f32) void;
export @symbol("GetMouseWheelMove") fn get_mouse_wheel_move() f32;
export @symbol("GetMouseWheelMoveV") fn get_mouse_wheel_move_v() Vector2;
export @symbol("SetMouseCursor") fn set_mouse_cursor(cursor: int) void;

// module: rshapes
// NOTE: It can be useful when using basic shapes and one single font,
// defining a font char white rectangle would allow drawing everything in a single draw call
export @symbol("SetShapesTexture") fn set_shapes_texture(texture: Texture2D, source: Rectangle) void;

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
export fn draw_triangle_v(points: Triangle, color: Color) void = {
	draw_triangle(points.point_1, points.point_2, points.point_3, color);
};
export @symbol("DrawTriangleLines") fn draw_triangle_lines(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) void;
// TODO:
// DrawTriangleFan
// DrawTriangleStrip
export @symbol("DrawPoly") fn draw_poly(center: Vector2, sides: int, radius: f32, rotation: f32, color: Color) void;
export @symbol("DrawPolyLines") fn draw_poly_lines(center: Vector2, sides: int, radius: f32, rotation: f32, color: Color) void;
export @symbol("DrawPolyLinesEx") fn draw_poly_lines_ex(center: Vector2, sides: int, radius: f32, rotation: f32, line_thic: f32,color: Color) void;

// Basic shapes collision detection functions
export @symbol("CheckCollisionRecs") fn check_collision_recs(rec_1: Rectangle, rec_2: Rectangle) bool;
export @symbol("CheckCollisionPointTriangle") fn check_collision_point_triangle(point: Vector2, v1: Vector2, v2: Vector2, v3: Vector2) bool;
export @symbol("CheckCollisionLines") fn check_collision_lines(pos_1_start: Vector2, pos_1_end: Vector2, pos_2_start: Vector2, pos_2_end: Vector2, collision_point: *Vector2) bool;

// module: rtextures
// Image loading functions
@symbol("LoadImage") fn LoadImage(*c::char) Image;
export fn load_image(filename: str) Image = return LoadImage(c::fromstr(filename));

// Texture loading functions
@symbol("LoadTexture") fn LoadTexture(*c::char) Texture2D;
export fn load_texture(filename: str) Texture2D = return LoadTexture(c::fromstr(filename));
export @symbol("LoadTextureFromImage") fn load_texture_from_image(image: Image) Texture2D;
export @symbol("UnloadTexture") fn unload_texture(texture: Texture2D) void;

// Texture drawing functions
export @symbol("DrawTexture") fn draw_texture(texture: Texture, x: int, y: int, tint: Color) void;
export @symbol("DrawTextureV") fn draw_texture_v(texture: Texture, position: Vector2, tint: Color) void;
export @symbol("DrawTextureEx") fn draw_texture_ex(texture: Texture, position: Vector2, rotation: f32, scale: f32, tint: Color) void;
export @symbol("DrawTextureRec") fn draw_texture_rec(texture: Texture, source: Rectangle, position: Vector2, tint: Color) void;
export @symbol("DrawTexturePro") fn draw_texture_pro(texture: Texture, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;
export @symbol("DrawTextureNPatch") fn draw_texture_npatch(texture: Texture, npatch_info: NPatchInfo, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) void;

// Color/Pixel related functions
export @symbol("GetColor") fn get_color(color: u32) Color;

// module: rtext
// Text-Drawing functions
@symbol("DrawText") fn DrawText(*c::char, size, size, size, Color) void;
export @symbol("DrawFPS") fn draw_fps(x: int, y: int) void;
export fn draw_text(title: str, x: size, y: size, text_size: size, color: Color) void = DrawText(c::fromstr(title), x, y, text_size, color);

// Text font info functions
export @symbol("SetTextLineSpacing") fn set_text_line_spacing(spacing: int) void;

// module: raudio
// Audio device management functions
export @symbol("InitAudioDevice") fn init_audio_device() void;
export @symbol("CloseAudioDevice") fn close_audio_device() void;
export @symbol("IsAudioDeviceReady") fn is_audio_device_ready() bool;
export @symbol("SetMasterVolume") fn set_master_volume(volume: f32) void;
export @symbol("GetMasterVolume") fn get_master_volume() f32;

// Wave/Sound loading/unloading functions
@symbol("LoadWave") fn LoadWave(*c::char) Wave;
@symbol("LoadSound") fn LoadSound(*c::char) Sound;
@symbol("ExportWave") fn ExportWave(Wave, *c::char) bool;
@symbol("ExportWaveAsCode") fn ExportWaveAsCode(Wave, *c::char) bool;
export fn load_wave(filename: str) Wave = return LoadWave(c::fromstr(filename));
export @symbol("IsWaveReady") fn is_wave_ready(wave: Wave) bool;
export fn load_sound(filename: str) Sound = return LoadSound(c::fromstr(filename));
export @symbol("LoadSoundFromWave") fn load_sound_from_wave(wave: Wave) Sound;
export @symbol("LoadSoundAlias") fn load_sound_alias(source: Sound) Sound;
export @symbol("IsSoundReady") fn is_sound_ready(sound: Sound) bool;
export @symbol("UpdateSound") fn update_sound(sound: Sound, data: *opaque, sample_count: int) void;
export @symbol("UnloadWave") fn unload_wave(wave: Wave) void;
export @symbol("UnloadSound") fn unload_sound(sound: Sound) void;
export @symbol("UnloadSoundAlias") fn unload_sound_alias(alias: Sound) void;
export fn export_wave(wave: Wave, filename: str) bool = ExportWave(wave, c::fromstr(filename));
export fn export_wave_as_code(wave: Wave, filename: str) bool = ExportWaveAsCode(wave, c::fromstr(filename));

// Wave/Sound management functions
export @symbol("PlaySound") fn play_sound(sound: Sound) void;
export @symbol("StopSound") fn stop_sound(sound: Sound) void;
export @symbol("PauseSound") fn pause_sound(sound: Sound) void;
export @symbol("ResumeSound") fn resume_sound(sound: Sound) void;
export @symbol("IsSoundPlaying") fn is_sound_playing(sound: Sound) bool;
export @symbol("SetSoundVolume") fn set_sound_volume(sound: Sound, volume: f32) void;
export @symbol("SetSoundPitch") fn set_sound_pitch(sound: Sound, pitch: f32) void;
export @symbol("SetSoundPan") fn set_sound_pan(sound: Sound, pan: f32) void;
export @symbol("WaveCopy") fn wave_copy(wave: Wave) Wave;
export @symbol("WaveCrop") fn wave_crop(wave: *Wave, init_sample: int, final_sample: int) void;
export @symbol("WaveFormat") fn wave_format(wave: *Wave, sample_rate: int, sample_size: int, channels: int) void;
export @symbol("LoadWaveSamples") fn load_wave_samples(wave: Wave) *f32;
export @symbol("UnloadWaveSamples") fn unload_wave_samples(samples: *f32) void;

// Music management functions
@symbol("LoadMusicStream") fn LoadMusicStream(*c::char) Music;
@symbol("LoadMusicStreamFromMemory") fn LoadMusicStreamFromMemory(*c::char, *c::char, int) Music;
export fn load_music_stream(filename: str) Music = return LoadMusicStream(c::fromstr(filename));
export fn load_music_stream_from_memory(filetype: str, data: str, datasize: int) Music = { 
	return LoadMusicStreamFromMemory(c::fromstr(filetype), c::fromstr(data), datasize);
};
export @symbol("IsMusicReady") fn is_music_ready(music: Music) bool;
export @symbol("UnloadMusicStream") fn unload_music_stream(music: Music) void;
export @symbol("PlayMusicStream") fn play_music_stream(music: Music) void;
export @symbol("IsMusicStreamPlaying") fn is_music_stream_playing(music: Music) bool;
export @symbol("UpdateMusicStream") fn update_music_stream(music: Music) void;
export @symbol("StopMusicStream") fn stop_music_stream(music: Music) void;
export @symbol("PauseMusicStream") fn pause_music_stream(music: Music) void;
export @symbol("ResumeMusicStream") fn resume_music_stream(music: Music) void;
export @symbol("SeekMusicStream") fn seek_music_stream(music: Music, position: f32) void;
export @symbol("SetMusicVolume") fn set_music_volume(music: Music, volume: f32) void;
export @symbol("SetMusicPitch") fn set_music_pitch(music: Music, pitch: f32) void;
export @symbol("SetMusicPan") fn set_music_pan(music: Music, pan: f32) void;
export @symbol("GetMusicTimeLength") fn get_music_time_length(music: Music) f32;
export @symbol("GetMusicTimePlayed") fn get_music_time_played(music: Music) f32;

// TODO:
//    // AudioStream management functions
//    AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)
//    bool IsAudioStreamReady(AudioStream stream);                    // Checks if an audio stream is ready
//    void UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory
//    void UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data
//    bool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill
//    void PlayAudioStream(AudioStream stream);                       // Play audio stream
//    void PauseAudioStream(AudioStream stream);                      // Pause audio stream
//    void ResumeAudioStream(AudioStream stream);                     // Resume audio stream
//    bool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing
//    void StopAudioStream(AudioStream stream);                       // Stop audio stream
//    void SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)
//    void SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)
//    void SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)
//    void SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams
//    void SetAudioStreamCallback(AudioStream stream, AudioCallback callback); // Audio thread callback to request new data

//    void AttachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Attach audio stream processor to stream, receives the samples as <float>s
//    void DetachAudioStreamProcessor(AudioStream stream, AudioCallback processor); // Detach audio stream processor from stream

//    void AttachAudioMixedProcessor(AudioCallback processor); // Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
//    void DetachAudioMixedProcessor(AudioCallback processor); // Detach audio stream processor from the entire audio pipeline

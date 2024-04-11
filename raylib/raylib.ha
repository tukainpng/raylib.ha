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

// Gruvbox colors
export const BG_DARK		= Color { r = 40,  g = 40,  b = 40,  a = 255 };
export const FG_DARK		= Color { r = 168, g = 153, b = 132, a = 255 };
export const RED_DARK		= Color { r = 204, g = 36,  b = 29,  a = 255 };
export const GREEN_DARK		= Color { r = 152, g = 151, b = 26,  a = 255 };
export const YELLOW_DARK	= Color { r = 215, g = 153, b = 33,  a = 255 };
export const BLUE_DARK		= Color { r = 69,  g = 133, b = 136, a = 255 };
export const PURPLE_DARK	= Color { r = 177, g = 98,  b = 134, a = 255 };
export const AQUA_DARK		= Color { r = 104, g = 157, b = 106, a = 255 };
export const ORANGE_DARK	= Color { r = 214, g = 93,  b = 14,  a = 255 };
export const BG_LIGHT		= Color { r = 60,  g = 56,  b = 54,  a = 255 };
export const FG_LIGHT		= Color { r = 235, g = 219, b = 178, a = 255 };
export const RED_LIGHT		= Color { r = 251, g = 73,  b = 52,  a = 255 };
export const GREEN_LIGHT	= Color { r = 184, g = 187, b = 38,  a = 255 };
export const YELLOW_LIGHT	= Color { r = 250, g = 189, b = 47,  a = 255 };
export const BLUE_LIGHT		= Color { r = 131, g = 165, b = 152, a = 255 };
export const PURPLE_LIGHT	= Color { r = 211, g = 134, b = 155, a = 255 };
export const AQUA_LIGHT		= Color { r = 142, g = 192, b = 124, a = 255 };
export const ORANGE_LIGHT	= Color { r = 254, g = 128, b = 25,  a = 255 };

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


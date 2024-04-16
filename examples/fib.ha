use types::c;
use raylib::*;

def TITLE = "Fibonacci";

def SCREEN_RESOLUTION = Vector2 {
	x = 800.0,
	y = 600.0,
};

export fn main() void = {
	let center = Vector2 {
		x = SCREEN_RESOLUTION.x / 2.0,
		y = SCREEN_RESOLUTION.y / 2.0,
	};

	init_window(SCREEN_RESOLUTION.x: int, SCREEN_RESOLUTION.y: int, TITLE);
		for (!window_should_close()) {
			set_window_title(TITLE);
			begin_drawing();
				clear_background(DARKGRAY);
				draw_circle_sector(center, 15.0, 0.0, 90.0, 30, DARKBLUE);
				draw_circle_sector_lines(center, 15.0, 0.0, 90.0, 30, BLACK);
				draw_text("15", SCREEN_RESOLUTION.x: int / 2, SCREEN_RESOLUTION.y: int / 2, 5, RAYWHITE);

				draw_circle_sector(center, 15.0, 360.0, 270.0, 30, DARKGREEN);
				draw_circle_sector_lines(center, 15.0, 360.0, 270.0, 30, BLACK);
				draw_text("15", SCREEN_RESOLUTION.x: int / 2, SCREEN_RESOLUTION.y: int / 2 - 10, 5, RAYWHITE);

				draw_circle_sector(Vector2 { x = center.x, y = center.y + 15.0 }, 30.0, 270.0, 180.0, 30, DARKPURPLE);
				draw_circle_sector_lines(Vector2 { x = center.x, y = center.y + 15.0 }, 30.0, 270.0, 180.0, 30, BLACK);
				draw_text("30", SCREEN_RESOLUTION.x: int / 2 - 15, SCREEN_RESOLUTION.y: int / 2 - 5, 5, RAYWHITE);

				draw_circle_sector(Vector2 { x = center.x + 15.0, y = center.y + 15.0 }, 45.0, 180.0, 90.0, 30, DARKBROWN);
				draw_circle_sector_lines(Vector2 { x = center.x + 15.0, y = center.y + 15.0 }, 45.0, 180.0, 90.0, 30, BLACK);
				draw_text("45", SCREEN_RESOLUTION.x: int / 2 - 10, SCREEN_RESOLUTION.y: int / 2 + 30, 10, RAYWHITE);

				draw_circle_sector(Vector2 { x = center.x + 15.0, y = center.y - 15.0 }, 75.0, 90.0, 0.0, 30, BLUE);
				draw_circle_sector_lines(Vector2 { x = center.x + 15.0, y = center.y - 15.0 }, 75.0, 90.0, 0.0, 30, BLACK);
				draw_text("75", SCREEN_RESOLUTION.x: int / 2 + 30, SCREEN_RESOLUTION.y: int / 2 + 15, 15, RAYWHITE);

				draw_circle_sector(Vector2 { x = center.x - 30.0, y = center.y - 15.0 }, 120.0, 360.0, 270.0, 30, GREEN);
				draw_circle_sector_lines(Vector2 { x = center.x - 30.0, y = center.y - 15.0 }, 120.0, 360.0, 270.0, 30, BLACK);
				draw_text("120", SCREEN_RESOLUTION.x: int / 2, SCREEN_RESOLUTION.y: int / 2 - 75, 20, RAYWHITE);

				draw_circle_sector(Vector2 { x = center.x - 30.0, y = center.y + 60.0 }, 195.0, 270.0, 180.0, 30, PURPLE);
				draw_circle_sector_lines(Vector2 { x = center.x - 30.0, y = center.y + 60.0 }, 195.0, 270.0, 180.0, 30, BLACK);
				draw_text("195", SCREEN_RESOLUTION.x: int / 2 - 120, SCREEN_RESOLUTION.y: int / 2 - 30, 25, RAYWHITE);

				draw_circle_sector(Vector2 { x = center.x + 90.0, y = center.y + 60.0 }, 315.0, 180.0, 90.0, 30, BROWN);
				draw_circle_sector_lines(Vector2 { x = center.x + 90.0, y = center.y + 60.0 }, 315.0, 180.0, 90.0, 30, BLACK);
				draw_text("315", SCREEN_RESOLUTION.x: int / 2 - 60, SCREEN_RESOLUTION.y: int / 2 + 165, 35, RAYWHITE);
			end_drawing();
			if (is_key_pressed(KeyboardKey::KEY_P)) take_screenshot("fib.png");
		};
	close_window();
};

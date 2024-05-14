#include <raylib.h>
#include "game.h"

bool debug_info(int monitor)
{
  if (IsGamepadButtonDown(0, GAMEPAD_BUTTON_RIGHT_THUMB) || IsKeyDown(KEY_I))
  {
    // Background
    DrawRectangle(
        (int) SCREEN_RESOLUTION.x / 8, // Width
        60,                            // Height
        320,                           // X Position
        320,                           // Y Position
        GetColor(0x1d202177)
    );

    // Content
    DrawText(TITLE, (int)SCREEN_RESOLUTION.x / 8 + 5, 60, 20, WHITE);
    DrawText("Controller:", (int)SCREEN_RESOLUTION.x / 8 + 5, 80, 20, WHITE);
    DrawText(GetGamepadName(0), (int)SCREEN_RESOLUTION.x / 8 + 5, 100, 15, WHITE);
    DrawFPS((int)SCREEN_RESOLUTION.x / 8 + 5, 350);
    return true;
  }
  return false;
}

int main()
{

  struct Player player = {
    .position   = { 320.0, 240.0 },
    .dimensions = { 30.0, 30.0 },
    .collisions = { 0.0, 0.0, 38.0, 60.0 },
    .color      = BLACK,
    .speed      = 300.0f,
  };

  struct Camera2D camera = {
    .offset = { SCREEN_RESOLUTION.x / 2.0f, SCREEN_RESOLUTION.y / 2.0f },
    .target = {
      player.position.x + player.dimensions.x / 2.0f,
      player.position.y + player.dimensions.y / 2.0f
    },
    .rotation = 0.0f,
    .zoom = 1.0f
  };

  InitWindow(1280, 720, TITLE);
    int monitor = GetCurrentMonitor();
    int refresh_rate = GetMonitorRefreshRate(monitor);

    // Textures
    Texture2D ruins = LoadTexture("./images/ruins.png");
    Texture2D chara = LoadTexture("./images/player.png");

    // Audio
    InitAudioDevice();
    Music music = LoadMusicStream("./sounds/ruins.mp3");
    music.looping = true;
    Sound menu_enter = LoadSound("./sounds/snd_bell.wav");
    Sound menu_quit = LoadSound("./sounds/snd_select.wav");
    SetMusicVolume(music, 0.5f);
    PlayMusicStream(music);

    // Target FPS
    SetTargetFPS(refresh_rate * 2);

    while (!WindowShouldClose())
    {
      SetWindowTitle(TITLE);

      if (IsGamepadButtonPressed(0, GAMEPAD_BUTTON_RIGHT_THUMB)
          || IsKeyPressed(KEY_I))
        PlaySound(menu_enter);
      if (IsGamepadButtonReleased(0, GAMEPAD_BUTTON_RIGHT_THUMB)
          || IsKeyReleased(KEY_I))
        PlaySound(menu_quit);

      UpdateMusicStream(music);
      if (IsMusicStreamPlaying(music) == true) {
        if (IsKeyPressed(KEY_P)
            || IsGamepadButtonPressed(0, GAMEPAD_BUTTON_LEFT_THUMB))
          PauseMusicStream(music);
      } else {
        if (IsKeyPressed(KEY_P)
            || IsGamepadButtonPressed(0, GAMEPAD_BUTTON_LEFT_THUMB))
          PlayMusicStream(music);
      };

      BeginDrawing();
        ClearBackground(BLACK);
        HideCursor();
        BeginMode2D(camera);

          // Gamepad
          if (GetGamepadAxisMovement(0, GAMEPAD_AXIS_LEFT_X) > 0.0f)
            player.position.x += player.speed * GetFrameTime();

          if (GetGamepadAxisMovement(0, GAMEPAD_AXIS_LEFT_X) < 0.0f)
            player.position.x -= player.speed * GetFrameTime();

          if (GetGamepadAxisMovement(0, GAMEPAD_AXIS_LEFT_Y) > 0.0f)
            player.position.y += player.speed * GetFrameTime();

          if (GetGamepadAxisMovement(0, GAMEPAD_AXIS_LEFT_Y) < 0.0f)
            player.position.y -= player.speed * GetFrameTime();

          // Keyboard
          SetExitKey(KEY_Q);

          if (IsKeyDown(KEY_W))
            player.position.y -= player.speed * GetFrameTime();

          if (IsKeyDown(KEY_A))
            player.position.x -= player.speed * GetFrameTime();

          if (IsKeyDown(KEY_S))
            player.position.y += player.speed * GetFrameTime();

          if (IsKeyDown(KEY_D))
            player.position.x += player.speed * GetFrameTime();

          camera.target.x = 320.0f;
          camera.target.y = 240.0f;

          // Background
          DrawTexture(ruins, 0, 0, GetColor(0xFFFFFFFF));

          // Player
          player.collisions = (Rectangle){
            .x = player.position.x,
            .y = player.position.y,
            .width = 38.0f,
            .height = 60.0f
          };

          DrawTexture(
              chara,
              (int)player.position.x,
              (int)player.position.y,
              GetColor(0xFFFFFFFF)
          );

          // Map limits

          // Top
          if (CheckCollisionRecs(
                (Rectangle){
                  .x = 0.0f,
                  .y = 0.0f,
                  .width = SCREEN_RESOLUTION.x,
                  .height = 120.0f,
                  }, player.collisions))
          {
            player.position.y += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          // Left-side
          if(CheckCollisionRecs(
                (Rectangle){
                .x = 110.0f,
                .y = 140.0f,
                .width = 2.0f,
                .height = 10.0f,
                }, player.collisions))
          {
            player.position.x += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 90.0f,
                .y = 160.0f,
                .width = 20.0f,
                .height = 2.0f,
                }, player.collisions))
          {
            player.position.y += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 80.0f,
                .y = 200.0f,
                .width = 2.0f,
                .height = 140.0f,
                }, player.collisions))
          {
            player.position.x += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          Vector2 left_corner_1_point_1 = { 80.0f, 360.0f  };
          Vector2 left_corner_1_point_2 = { 80.0f, 400.0f  };
          Vector2 left_corner_1_point_3 = { 120.0f, 400.0f };
          Vector2 left_corner_1_point_player = {
            player.position.x,
            player.position.y + 30.0
          };
          if (CheckCollisionPointTriangle(
                left_corner_1_point_player,
                left_corner_1_point_1,
                left_corner_1_point_2,
                left_corner_1_point_3))
          {
            player.position.x += 2.5f;
            player.position.y -= 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 120.0f,
                .y = 410.0f,
                .width = 40.0f,
                .height = 20.0f,
                }, player.collisions))
          {
            player.position.y -= 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          Vector2 left_corner_2_point_1 = { 160.0f, 400.0f };
          Vector2 left_corner_2_point_2 = { 160.0f, 440.0f };
          Vector2 left_corner_2_point_3 = { 200.0f, 440.0f };
          Vector2 left_corner_2_point_player = {
            player.position.x,
            player.position.y + 30.0f
          };
          if (CheckCollisionPointTriangle(
                left_corner_2_point_player,
                left_corner_2_point_1,
                left_corner_2_point_2,
                left_corner_2_point_3))
          {
            player.position.x += 2.5;
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          // Bottom
          if (CheckCollisionRecs(
                (Rectangle){
                .x = 0.0f,
                .y = 450.0f,
                .width = 650.0f,
                .height = 2.0f,
                }, player.collisions))
          {
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          // Right-side
          if (CheckCollisionRecs(
                (Rectangle){
                .x = 490.0f,
                .y = 140.0f,
                .width = 2.0f,
                .height = 50.0f,
                }, player.collisions))
          {
            player.position.x -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 510.0f,
                .y = 200.0f,
                .width = 25.0f,
                .height = 2.0f,
                }, player.collisions))
          {
            player.position.y += 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 530.0f,
                .y = 200.0f,
                .width = 2.0f,
                .height = 30.0f,
                }, player.collisions))
          {
            player.position.x -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 535.0f,
                .y = 240.0f,
                .width = 25.0f,
                .height = 2.0f,
                }, player.collisions))
          {
            player.position.y += 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 570.0f,
                .y = 240.0f,
                .width = 2.0f,
                .height = 150.0f,
                }, player.collisions))
          {
            player.position.x -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                .x = 540.0f,
                .y = 390.0f,
                .width = 20.0f,
                .height = 10.0f
                }, player.collisions))
          {
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          Vector2 right_corner_point_1 = { 560.0f, 360.0f };
          Vector2 right_corner_point_2 = { 480.0f, 440.0f };
          Vector2 right_corner_point_3 = { 560.0f, 440.0f };
          Vector2 right_corner_point_player = {
            player.position.x + 40.0f,
            player.position.y + 30.0f
          };
          if (CheckCollisionPointTriangle(
                right_corner_point_player,
                right_corner_point_1,
                right_corner_point_2,
                right_corner_point_3))
          {
            player.position.x -= 2.5;
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          debug_info(monitor);
        EndMode2D();
      EndDrawing();
    }

    UnloadTexture(ruins);
    UnloadTexture(chara);
    CloseAudioDevice();
    CloseWindow();
    return 0;
}

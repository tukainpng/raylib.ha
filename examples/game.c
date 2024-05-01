#include <raylib.h>

char TITLE[] = "Game Example";
Vector2 SCREEN_RESOLUTION = { 1280.0, 720.0 };

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

void main()
{
  struct Player {
    Vector2 position;
    Vector2 dimensions;
    Rectangle collisions;
    Color color;
    float speed;
  } Player;

  struct Player player = {
    (Vector2){ 320.0, 240.0 },
    (Vector2){ 30.0, 30.0 },
    (Rectangle){ 0.0, 0.0, 38.0, 60.0 },
    BLACK,
    300.0f
  };

  struct Camera2D camera = {
    (Vector2){ SCREEN_RESOLUTION.x / 2.0f, SCREEN_RESOLUTION.y / 2.0f },
    (Vector2){
      player.position.x + player.dimensions.x / 2.0f,
      player.position.y + player.dimensions.y / 2.0f
    },
    0.0f,
    1.0f
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
            player.position.x,
            player.position.y,
            38.0f,
            60.0f
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
                  0.0f, 0.0f,
                  SCREEN_RESOLUTION.x,
                  120.0f
                  }, player.collisions)
          )
          {
            player.position.y += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          // Left-side
          if(CheckCollisionRecs(
                (Rectangle){
                110.0f,
                140.0f,
                2.0f,
                10.0f },
                player.collisions)
          )
          {
            player.position.x += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          if (CheckCollisionRecs(
                (Rectangle){
                90.0f,
                160.0f,
                20.0f,
                2.0f },
                player.collisions)
          )
          {
            player.position.y += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          if (CheckCollisionRecs(
                (Rectangle){
                80.0f,
                200.0f,
                2.0f,
                140.0f },
                player.collisions)
            )
          {
            player.position.x += 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          Vector2 left_corner_1_point_1 = (Vector2){ 80.0f, 360.0f  };
          Vector2 left_corner_1_point_2 = (Vector2){ 80.0f, 400.0f  };
          Vector2 left_corner_1_point_3 = (Vector2){ 120.0f, 400.0f };
          Vector2 left_corner_1_point_player = (Vector2){
            player.position.x,
            player.position.y + 30.0
          };
          if (CheckCollisionPointTriangle(
                left_corner_1_point_player,
                left_corner_1_point_1,
                left_corner_1_point_2,
                left_corner_1_point_3)
            )
          {
            player.position.x += 2.5f;
            player.position.y -= 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          if (CheckCollisionRecs(
                (Rectangle){
                120.0f,
                410.0f,
                40.0f,
                20.0f },
                player.collisions)
          )
          {
            player.position.y -= 2.5f;
            player.speed = 0.0f;
          } else player.speed = 300.0f;

          Vector2 left_corner_2_point_1 = (Vector2){ 160.0f, 400.0f };
          Vector2 left_corner_2_point_2 = (Vector2){ 160.0f, 440.0f };
          Vector2 left_corner_2_point_3 = (Vector2){ 200.0f, 440.0f };
          Vector2 left_corner_2_point_player = (Vector2){
            player.position.x,
            player.position.y + 30.0f
          };
          if (CheckCollisionPointTriangle(
                left_corner_2_point_player,
                left_corner_2_point_1,
                left_corner_2_point_2,
                left_corner_2_point_3)
          )
          {
            player.position.x += 2.5;
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          // Bottom
          if (CheckCollisionRecs(
                (Rectangle){
                0.0f,
                450.0f,
                650.0f,
                2.0f },
                player.collisions)
          )
          {
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          // Right-side
          if (CheckCollisionRecs(
                (Rectangle){
                490.0f,
                140.0f,
                2.0f,
                50.0f },
                player.collisions)
          )
          {
            player.position.x -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                510.0f,
                200.0f,
                25.0f,
                2.0f },
                player.collisions)
          )
          {
            player.position.y += 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                530.0f,
                200.0f,
                2.0f,
                30.0f },
                player.collisions)
          )
          {
            player.position.x -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                535.0f,
                240.0f,
                25.0f,2.0f },
                player.collisions)
          )
          {
            player.position.y += 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                570.0f,
                240.0f,
                2.0f,
                150.0f },
                player.collisions)
          )
          {
            player.position.x -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          if (CheckCollisionRecs(
                (Rectangle){
                540.0f,
                390.0f,
                20.0f,
                10.0f },
                player.collisions)
          )
          {
            player.position.y -= 2.5;
            player.speed = 0.0;
          } else player.speed = 300.0;

          Vector2 right_corner_point_1 = (Vector2){ 560.0f, 360.0f };
          Vector2 right_corner_point_2 = (Vector2){ 480.0f, 440.0f };
          Vector2 right_corner_point_3 = (Vector2){ 560.0f, 440.0f };
          Vector2 right_corner_point_player = (Vector2){
            player.position.x + 40.0f,
            player.position.y + 30.0f
          };
          if (CheckCollisionPointTriangle(
                right_corner_point_player,
                right_corner_point_1,
                right_corner_point_2,
                right_corner_point_3)
          )
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
}

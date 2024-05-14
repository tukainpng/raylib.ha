// Definições básicas para o game.c

char TITLE[] = "Game example";
Vector2 SCREEN_RESOLUTION = { 1280.0, 720.0 };

struct Player {
    Vector2 position;
    Vector2 dimensions;
    Rectangle collisions;
    Color color;
    float speed;
};

import raylib;
import std.stdio;
import std.string;

import enums;
import world.world;

struct StringOutput
{
	immutable char* output;
	int size;
	float spacing;
	Vector2 dims;
	Vector2 screenPos;
	Color color;
	Font font;
}

void main()
{
	// REQUIRED FIRST by raylib-d
	validateRaylibBinding();

	InitWindow(800, 600, "Remnants");

	// Load font AFTER window initialization
	Font font = LoadFont("res/fonts/Kenney Mini.ttf");

	const int FPS = 60;
	SetTargetFPS(FPS);

	int frame = 1;

	World world = new World(GetScreenWidth(), GetScreenHeight());

	auto title = prepString("Remnants", 36, 1.0f, font);
	title.screenPos.x = GetScreenWidth() / 2 - title.dims.x / 2;
	title.screenPos.y = GetScreenHeight() / 2 - title.dims.y;
	auto pressPlay = prepString("press enter to play", 24, 1.0f, font);
	pressPlay.screenPos.x = GetScreenWidth() / 2 - pressPlay.dims.x / 2;
	pressPlay.screenPos.y = GetScreenHeight() / 2 + pressPlay.dims.y * 4;

	GameState gameState = GameState.GAMEPLAY;

	while (!WindowShouldClose())
	{
		switch (gameState)
		{
		case GameState.TITLE:
			if (IsKeyPressed(KeyboardKey.KEY_ENTER))
			{
				gameState = GameState.GAMEPLAY;
			}
			break;
		case GameState.GAMEPLAY:
			if (IsKeyPressed(KeyboardKey.KEY_UP))
			{
				world.changeLevel(Direction.UP);
			}
			else if (IsKeyPressed(KeyboardKey.KEY_DOWN))
			{
				world.changeLevel(Direction.DOWN);
			}
			break;
		case GameState.GAMEOVER:
		default:
			break;
		}

		switch (gameState)
		{
		case GameState.TITLE:
			BeginDrawing();
			ClearBackground(Colors.DARKGRAY);
			drawString(title);
			drawString(pressPlay);
			EndDrawing();
			break;
		case GameState.GAMEPLAY:
			BeginDrawing();
			ClearBackground(Colors.DARKGRAY);
			world.draw(font, 32);
			EndDrawing();
			break;
		case GameState.GAMEOVER:
		default:
			break;
		}

		++frame;
	}

	CloseWindow();
	UnloadFont(font);
}

StringOutput prepString(string output, int size, float spacing, Font font)
{
	auto cStr = toStringz(output);
	auto dims = MeasureTextEx(font, cStr, size, spacing);
	return StringOutput(
		cStr,
		size,
		spacing,
		dims,
		Vector2(0, 0),
		Colors.WHITE,
		font
	);
}

void drawString(StringOutput s)
{
	DrawTextEx(s.font, s.output, s.screenPos, s.size, s.spacing, Colors.RAYWHITE);
}

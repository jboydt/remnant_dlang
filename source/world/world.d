module world.world;

import raylib;
import std.format;
import std.stdio;
import std.string;

import enums;
import world.level;

class World
{
  uint level;
  Level[10] levels;

  float screenWidth;
  float screenHeight;

  this (float sw, float sh)
  {
    screenWidth = sw;
    screenHeight = sh;
  }

  void draw(Font font, float fontSize)
  {
    string output = format("World, Level: %d", level + 1);
    Vector2 pos = Vector2(10, screenHeight / 2);

    DrawTextEx(font, toStringz(output), pos, fontSize, 1.0, Colors.RAYWHITE);
  }

  bool changeLevel(Direction d)
  {
    if (d == Direction.UP && level + 1 < levels.length)
    {
      ++level;
      return true;
    }
    else if (d == Direction.DOWN && level > 0)
    {
      --level;
      return true;
    }
    return false;
  }
}
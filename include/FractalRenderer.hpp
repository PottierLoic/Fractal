#pragma once

#include <iostream>
#include <string>
#include <SFML/Graphics.hpp>
#include <GL/gl.h>

#include "Constants.hpp"
#include "ColorPalette.hpp"

const std::vector<const char*> FRACTAL_NAMES = {
  "Mandelbrot",
  "Julia",
  "Burning Ship"
};

const std::vector<const char*> SHADERS_PATH = {
  "../shaders/mandelbrot.glsl",
  "../shaders/julia.glsl",
  "../shaders/burningship.glsl"
};


class FractalRenderer {
public:
  sf::RenderWindow& window;
  sf::Clock clock;
  sf::Texture texture;
  sf::Sprite sprite;
  sf::Shader shader;

  std::string shaderPath = "../shaders/mandelbrot.glsl";
  ColorPalette colorPalette = PALETTE_BLACK_WHITE;

  /* Renderer config. */
  int type = 0;
  int maxIterations = 100;
  sf::Vector2f position = sf::Vector2f(0.0f, 0.0f);
  int paletteType = 0;
  int colorRepetition = 1;

  /* Renderer old config. */
  int oldType = 0;
  int oldMaxIteration = 100;
  sf::Vector2f oldPosition = sf::Vector2f(0.0f, 0.0f);
  int oldPaletteType = 0;
  int oldColorRepetition = 1;

  /* Main constructor. */
  FractalRenderer(sf::RenderWindow& windows);
  /* Load all the config variables that have changed. */
  void changeConfig();
  void changeShader();
  void changeIterations();
  void changePosition();
  void changeColorPalette();
  void changeColorRepetition();

  /* Execute loaded shader and sends it's results to the screen */
  void render();
};
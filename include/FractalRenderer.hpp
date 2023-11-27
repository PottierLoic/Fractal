#pragma once

#include <iostream>
#include <string>
#include <SFML/Graphics.hpp>
#include <GL/gl.h>

#include "Constants.hpp"

class FractalRenderer {
public:
  sf::RenderWindow& window;
  sf::Clock clock;
  sf::Texture texture;
  sf::Sprite sprite;
  sf::Shader shader;

  std::string shaderPath = "../shaders/mandelbrot.glsl";
  int type = 0;
  int maxIterations = 100;

  FractalRenderer(sf::RenderWindow& windows);
  void changeConfig();
  void render();
};
#pragma once

#include <iostream>
#include <SFML/Graphics.hpp>
#include <GL/gl.h>

#include "Constants.hpp"

class FractalRenderer {
public:
  FractalRenderer(const std::string& shaderPath);
  void run();
  void changeConfig(const std::string& shaderPath, const int iteration, const int colorPalette, const bool smoothState)

private:
  int fractalType = 0;
  int maxIterations = 100;
  int colorPalette = 0;
  bool smooth = true;

  void handleEvents();
  void render();

  sf::RenderWindow window;
  sf::Clock clock;
  sf::Texture texture;
  sf::Sprite sprite;
  sf::Shader shader;
};
#pragma once

#include <iostream>
#include <SFML/Graphics.hpp>
#include <GL/gl.h>

#include "Constants.hpp"

class FractalRenderer {
public:
  FractalRenderer(const std::string& shaderPath);
  void run();
  void changeShader(const std::string& newShaderPath);


private:
  void handleEvents();
  void render();

  sf::RenderWindow window;
  sf::Clock clock;
  sf::Texture texture;
  sf::Sprite sprite;
  sf::Shader shader;
};
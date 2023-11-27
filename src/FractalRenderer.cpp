#include "FractalRenderer.hpp"

FractalRenderer::FractalRenderer(sf::RenderWindow& window) : window(window) {

  texture.create(Constants::WIDTH, Constants::HEIGHT);
  sprite.setTexture(texture);

  if (!shader.loadFromFile(shaderPath, sf::Shader::Fragment)) {
    std::cerr << "Error loading shader." << std::endl;
    std::exit(EXIT_FAILURE);
  }

  shader.setUniform("resolution", sf::Vector2f(Constants::WIDTH, Constants::HEIGHT));
  shader.setUniform("maxIterations", maxIterations);
}

void FractalRenderer::changeConfig() {
  shader.setUniform("maxIterations", maxIterations);
}

void FractalRenderer::render() {
  glClear(GL_COLOR_BUFFER_BIT);
  sf::Shader::bind(&shader);
  window.draw(sprite);
  sf::Shader::bind(nullptr);
}

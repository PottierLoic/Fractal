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
  if (type != oldType) { changeShader(); }
  if (maxIterations != oldMaxIteration) { changeIterations(); }
  if (position != oldPosition) { changePosition(); }
  if (paletteType != oldPaletteType) { changeColorPalette(); }
  if (colorRepetition != oldColorRepetition) { changeColorRepetition(); }
}

void FractalRenderer::changeShader() {
  oldType = type;
  if (!shader.loadFromFile(SHADERS_PATH[type], sf::Shader::Fragment)) {
    std::cerr << "Error loading shader." << std::endl;
    std::exit(EXIT_FAILURE);
  }
}

void FractalRenderer::changeIterations() {
  oldMaxIteration = maxIterations;
  shader.setUniform("maxIterations", maxIterations);
}

void FractalRenderer::changePosition() {
  oldPosition = position;
  shader.setUniform("position", position);
}

void FractalRenderer::changeColorPalette() {
  oldPaletteType = paletteType;
  colorPalette = PALETTES[paletteType];
  // should set uniform
}

void FractalRenderer::changeColorRepetition() {
  oldColorRepetition = colorRepetition;
  // should set uniform
}

void FractalRenderer::render() {
  glClear(GL_COLOR_BUFFER_BIT);
  sf::Shader::bind(&shader);
  window.draw(sprite);
  sf::Shader::bind(nullptr);
}

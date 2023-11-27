#include "FractalRenderer.hpp"
#include "Constants.hpp"

FractalRenderer::FractalRenderer(const std::string& shaderPath) {
  window.create(sf::VideoMode(Constants::WIDTH, Constants::HEIGHT), "Fractal Renderer");

  texture.create(Constants::WIDTH, Constants::HEIGHT);
  sprite.setTexture(texture);

  if (!shader.loadFromFile(shaderPath, sf::Shader::Fragment)) {
    std::cerr << "Error while loading shader." << std::endl;
    std::exit(EXIT_FAILURE);
  }

  shader.setUniform("resolution", sf::Vector2f(Constants::WIDTH, Constants::HEIGHT));
}

void FractalRenderer::run() {
  while (window.isOpen()) {
    handleEvents();
    render();
  }
}

  void changeConfig(const std::string& shaderPath, const int iteration, const int colorPalette, const bool smoothState) {
    // TODO: Implement this and delete bellow 
  }

void FractalRenderer::changeShader(const std::string& shaderPath) {
  if (!shader.loadFromFile(shaderPath, sf::Shader::Fragment)) {
    std::cerr << "Error while loading new shader." << std::endl;
  }
}

void FractalRenderer::handleEvents() {
  sf::Event event;
  while (window.pollEvent(event)) {
    if (event.type == sf::Event::Closed) {
      window.close();
    }
  }
}

void FractalRenderer::render() {
  shader.setUniform("time", clock.getElapsedTime().asSeconds());
  glClear(GL_COLOR_BUFFER_BIT);
  sf::Shader::bind(&shader);
  window.draw(sprite);
  sf::Shader::bind(nullptr);
  window.display();
}

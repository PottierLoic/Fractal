#include <iostream>

#include <SFML/Graphics.hpp>
#include <imgui.h>
#include <imgui-SFML.h>

#include "Constants.hpp"
#include "FractalRenderer.hpp"

int main() {
  sf::RenderWindow window(sf::VideoMode(Constants::WIDTH, Constants::HEIGHT), "Fractal Explorer");
  window.setFramerateLimit(60);
  if (!ImGui::SFML::Init(window)) {
    std::cerr << "Error initializing SFML window" << std::endl;
  }

  FractalRenderer renderer = FractalRenderer(window);

  sf::Clock deltaClock;

  while (window.isOpen()) {
    bool configChanged = false;
    sf::Event event;
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed) {
        window.close();
      }
      ImGui::SFML::ProcessEvent(event);
    }

    ImGui::SFML::Update(window, deltaClock.restart());

    // ImGui frame
    ImGui::Begin("Configuration");
    ImGui::Text("FractalType");
    configChanged = ImGui::Combo("##FractalType", &renderer.type, "Mandelbrot\0Julia\0") || configChanged;
    ImGui::Text("Iterations");
    configChanged = ImGui::SliderInt("##Iterations", &renderer.maxIterations, 1, 10000) || configChanged;
    ImGui::End();

    if (configChanged) {
      renderer.changeConfig();
    }

    // Rendering
    window.clear();
    renderer.render();
    ImGui::SFML::Render(window);
    window.display();
  }

  ImGui::SFML::Shutdown();
  return 0;
}

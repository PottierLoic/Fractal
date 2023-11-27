#include <iostream>

#include <SFML/Graphics.hpp>
#include <imgui.h>
#include <imgui-SFML.h>

#include "Constants.hpp"
#include "ColorPalette.hpp"

void debugDifference(int type, int iter, int palette, bool smooth) {
  std::cout << "Current configuration:" << std::endl;
  std::cout << "Fractal: " << type << std::endl;
  std::cout << "Iterations: " << iter << std::endl;
  std::cout << "Color palette: " << palette << std::endl;
  std::cout << "Smooth activated: " << smooth << std::endl;
}

int main() {
  sf::RenderWindow window(sf::VideoMode(Constants::WIDTH, Constants::HEIGHT), "Fractal Explorer");
  window.setFramerateLimit(60);
  if (ImGui::SFML::Init(window)) {
    std::cerr << "Error initializing SFML window" << std::endl;
  }

  sf::Clock deltaClock;

  int fractalType = 0;
  int iterations = 100;
  int palette = 0;
  bool smooth = true;

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      ImGui::SFML::ProcessEvent(event);
      if (event.type == sf::Event::Closed) {
        window.close();
      }
    }

    ImGui::SFML::Update(window, deltaClock.restart());

    // ImGui frame
    bool configChanged = false;

    ImGui::Begin("Configuration");
    ImGui::Text("FractalType");
    configChanged = ImGui::Combo("##FractalType", &fractalType, "Mandelbrot\0Julia\0") || configChanged;
    ImGui::Text("Iterations");
    configChanged = ImGui::SliderInt("##Iterations", &iterations, 1, 10000) || configChanged;

    ImGui::Text("Color palette");
    configChanged = ImGui::Combo("##ColorPalettes", &palette, PALETTE_NAMES.data(), static_cast<int>(PALETTES.size())) || configChanged;

    ImGui::Text("Smooth colors");
    configChanged = ImGui::Checkbox("##", &smooth) || configChanged;
    ImGui::End();

    if (configChanged) {
      //debugDifference(fractalType, iterations, palette, smooth);
    }

    // Rendering
    window.clear();

    ImGui::SFML::Render(window);
    window.display();
  }

  ImGui::SFML::Shutdown();
  return 0;
}

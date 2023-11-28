#include <iostream>

#include <SFML/Graphics.hpp>
#include <imgui.h>
#include <imgui-SFML.h>

#include "Constants.hpp"
#include "ColorPalette.hpp"
#include "FractalRenderer.hpp"

int main() {
  sf::RenderWindow window(sf::VideoMode(Constants::WIDTH, Constants::HEIGHT), "Fractal Explorer");
  window.setFramerateLimit(60);
  if (!ImGui::SFML::Init(window)) {
    std::cerr << "Error initializing SFML window" << std::endl;
  }

  // FractalRenderer renderer = FractalRenderer(window);

  sf::Clock deltaClock;

  /* DEBUG ----------------*/
  int type = 0;
  int maxIter = 100;
  sf::Vector2f position = sf::Vector2f(0.0f, 0.0f);
  float zoom = 1.0f;
  int palette = 0;
  float repetition = 1;
  /* DEBUG ----------------*/

  bool ui = true;

  while (window.isOpen()) {
    bool configChanged = false;
    sf::Event event;
    while (window.pollEvent(event)) {
      switch (event.type) {
        case sf::Event::Closed:
          window.close();
          break;
        case sf::Event::KeyPressed:
          if (event.key.code == sf::Keyboard::Escape) { window.close(); }
          if (event.key.code == sf::Keyboard::Enter) { ui = !ui; }
          break;
        default:
          break;
      }
      ImGui::SFML::ProcessEvent(event);
    }

    ImGui::SFML::Update(window, deltaClock.restart());

    // ImGui frame
    if (ui) {
      ImGui::SetNextWindowPos(ImVec2(10, 10), ImGuiCond_Always);
      ImGui::SetNextWindowSize(ImVec2(275, 310), ImGuiCond_Always);
      ImGui::Begin("Configuration");

      ImGui::Text("FractalType");
      configChanged = ImGui::Combo("##FractalType", &type, FRACTAL_NAMES.data(), static_cast<int>(SHADERS_PATH.size())) || configChanged;

      ImGui::Text("Iterations");
      configChanged = ImGui::SliderInt("##Iterations", &maxIter, 1, 10000) || configChanged;

      ImGui::Text("Position");
      configChanged = ImGui::InputFloat("X##Position", &position.x) || configChanged;
      configChanged = ImGui::InputFloat("Y##Position", &position.y) || configChanged;;

      ImGui::Text("Zoom");
      configChanged = ImGui::InputFloat("##Zoon", &zoom) || configChanged;

      ImGui::Text("Color palette");
      configChanged = ImGui::Combo("##ColorPalette", &palette, PALETTE_NAMES.data(), static_cast<int>(PALETTES.size())) || configChanged;

      ImGui::Text("Color repetition");
      configChanged = ImGui::SliderFloat("##ColorRepetition", &repetition, 0, 10) || configChanged;

      ImGui::TextColored(ImVec4(0.9f, 0.9f, 0.9f, 0.7f), "Press enter to hide/show this panel.");

      ImGui::End();
    }

    if (configChanged) {
      std::cout << "Configuration changed" << std::endl;
      // renderer.changeConfig();
    }

    // Rendering
    window.clear();
    // renderer.render();
    ImGui::SFML::Render(window);
    window.display();
  }

  ImGui::SFML::Shutdown();
  return 0;
}

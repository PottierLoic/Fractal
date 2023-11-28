#include <iostream>

#include <SFML/Graphics.hpp>
#include <imgui.h>
#include <imgui-SFML.h>

#include "Constants.hpp"
#include "ColorPalette.hpp"
#include "FractalRenderer.hpp"

int main() {
  sf::RenderWindow window(sf::VideoMode(Constants::WIDTH, Constants::HEIGHT), "Fractal Explorer");
  window.setFramerateLimit(240);
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
        case sf::Event::MouseButtonPressed:
          if (!ImGui::GetIO().WantCaptureMouse) {
            if (event.mouseButton.button == sf::Mouse::Left && !ImGui::IsWindowHovered()) {
              std::cout << "Left mouse button clicked!" << std::endl;
            }
          }
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
      ImGui::SetNextWindowSize(ImVec2(275, 320), ImGuiCond_Always);
      ImGui::Begin("Configuration");

      ImGui::Text("Fractal Type");
      if (ImGui::Combo("##FractalType", &type, FRACTAL_NAMES.data(), static_cast<int>(SHADERS_PATH.size()))) {
        std::cout << "Fractal type changed." << std::endl;
        //renderer.changeShader();
      }

      ImGui::Text("Iterations");
      if (ImGui::SliderInt("##Iterations", &maxIter, 1, 10000)) {
        std::cout << "Maximum iterations changed." << std::endl;
        //renderer.changeIteration();
      }

      ImGui::Text("Position");
      if (ImGui::InputFloat("X##Position", &position.x) || ImGui::InputFloat("Y##Position", &position.y)) {
        std::cout << "Position changed." << std::endl;
        //renderer.changePosition();
      }

      ImGui::Text("Zoom");
      if (ImGui::InputFloat("##Zoon", &zoom)) {
        std::cout << "Zoom changed." << std::endl;
        //renderer.changeZoom();
      }

      ImGui::Text("Color palette");
      if (ImGui::Combo("##ColorPalette", &palette, PALETTE_NAMES.data(), static_cast<int>(PALETTES.size()))) {
        std::cout << "Color palette changed." << std::endl;
        //renderer.changeColorPalette();
      }

      ImGui::Text("Color repetition");
      if (ImGui::SliderFloat("##ColorRepetition", &repetition, 0, 10)) {
        std::cout << "Color repetition rate changed." << std::endl;
        //renderer.changeRepetition();
      }

      ImGui::TextColored(ImVec4(0.9f, 0.9f, 0.9f, 0.7f), "Press enter to hide/show this panel.");
      ImGui::End();

      // Create another window for FPS
      ImGui::SetNextWindowPos(ImVec2(1650, 885), ImGuiCond_Always);
      ImGui::SetNextWindowSize(ImVec2(250, 75), ImGuiCond_Always);
      ImGui::Begin("Statistics");
      ImGui::Text("FPS: %.1f", ImGui::GetIO().Framerate);
      ImGui::Text("Last frame computation: %.3f ms", ImGui::GetIO().DeltaTime * 1000);
      ImGui::End();
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

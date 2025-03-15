#ifndef FRACTAL_SIMULATOR_HPP
#define FRACTAL_SIMULATOR_HPP

#include "WindowManager.hpp"
#include "Renderer.hpp"
#include "Camera.hpp"
#include "ShaderLoader.hpp"
#include <imgui.h>
#include <backends/imgui_impl_glfw.h>
#include <backends/imgui_impl_opengl3.h>
#include <iostream>
#include <glm/glm.hpp>
#include <memory>
#include "Fractal.hpp"
#include "MandelbrotFractal.hpp"
#include "JuliaFractal.hpp"

class FractalSimulator {
public:
  FractalSimulator(int width, int height, const char* title);
  void run();
private:
  static void scrollCallback(GLFWwindow* window, double xoffset, double yoffset);
  void initImGui();
  void renderUI();
  void updateShaderProgram();

  WindowManager windowManager;
  Renderer renderer;
  Camera camera;
  GLuint shaderProgram;
  int maxIterations;
  glm::vec3 paletteColors[4];
  std::unique_ptr<Fractal> currentFractal;
  int selectedFractalType;
  double cReal;
  double cImag;
};

#endif
#ifndef FRACTAL_SIMULATOR_HPP
#define FRACTAL_SIMULATOR_HPP

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <imgui.h>
#include <backends/imgui_impl_glfw.h>
#include <backends/imgui_impl_opengl3.h>
#include <stdexcept>
#include <iostream>
#include <memory>
#include <fstream>
#include <sstream>
#include <string>
#include <stdexcept>
#include <iostream>

class FractalSimulator {
public:
  FractalSimulator(int width, int height, const char* title);
  ~FractalSimulator();
  void run();

private:
  void initGLFW();
  void initOpenGL();
  void initImGui();
  void render();
  void cleanup();
  void updateCamera();
  void handleScroll(double xoffset, double yoffset);
  static void scrollCallback(GLFWwindow* window, double xoffset, double yoffset);

  GLFWwindow* window;
  GLuint shaderProgram;
  GLuint vao, vbo;
  glm::vec2 center;
  float scale;
  bool isDragging;
  glm::vec2 lastMousePos;
};

#endif
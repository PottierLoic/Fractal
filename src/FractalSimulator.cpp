#include "FractalSimulator.hpp"

FractalSimulator::FractalSimulator(int width, int height, const char* title)
  : windowManager(width, height, title),
  shaderProgram(ShaderLoader::createShaderProgram("shaders/basic.vert", "shaders/fractal.frag")),
  maxIterations(100){
  windowManager.setUserPointer(this);
  windowManager.setScrollCallback(scrollCallback);
  initImGui();
}

void FractalSimulator::scrollCallback(GLFWwindow* window, double xoffset, double yoffset) {
  FractalSimulator* simulator = static_cast<FractalSimulator*>(glfwGetWindowUserPointer(window));
  simulator->camera.handleScroll(window, xoffset, yoffset);
}

void FractalSimulator::initImGui() {
  IMGUI_CHECKVERSION();
  ImGui::CreateContext();
  ImGui_ImplGlfw_InitForOpenGL(windowManager.getWindow(), true);
  ImGui_ImplOpenGL3_Init("#version 330");
}

void FractalSimulator::renderUI() {
  ImGui_ImplOpenGL3_NewFrame();
  ImGui_ImplGlfw_NewFrame();
  ImGui::NewFrame();
  ImGui::Begin("Controls");
  ImGui::Text("Fractal Simulator");
  ImGui::Text("Center: (%.6f, %.6f)", camera.getCenter().x, camera.getCenter().y);
  ImGui::Text("Scale: %.6f", camera.getScale());
  ImGui::SliderInt("Max Iterations", &maxIterations, 10, 500);
  ImGui::End();
  ImGui::Render();
  ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

void FractalSimulator::run() {
  while (!windowManager.shouldClose()) {
    windowManager.pollEvents();
    camera.update(windowManager.getWindow());
    if (glfwGetKey(windowManager.getWindow(), GLFW_KEY_R) == GLFW_PRESS) {
      camera = Camera();
    }

    int width, height;
    glfwGetFramebufferSize(windowManager.getWindow(), &width, &height);
    renderer.render(shaderProgram, camera.getCenter(), camera.getScale(), width, height);
    glUseProgram(shaderProgram);
    glUniform1i(glGetUniformLocation(shaderProgram, "maxIterations"), maxIterations);
    renderUI();
    windowManager.swapBuffers();
  }

  ImGui_ImplOpenGL3_Shutdown();
  ImGui_ImplGlfw_Shutdown();
  ImGui::DestroyContext();
}
#include "FractalSimulator.hpp"

FractalSimulator::FractalSimulator(int width, int height, const char* title)
  : windowManager(width, height, title),
  shaderProgram(ShaderLoader::createShaderProgram("shaders/basic.vert", "shaders/mandelbrot.frag")),
  maxIterations(100),
  paletteColors{
    {0.0f, 0.0f, 0.0f},
    {0.0f, 0.5f, 1.0f},
    {1.0f, 0.5f, 0.0f},
    {1.0f, 1.0f, 1.0f}
  },
  currentFractal(std::make_unique<MandelbrotFractal>()),
  selectedFractalType(0),
  cReal(-0.4), cImag(0.6) {
  windowManager.setUserPointer(this);
  windowManager.setScrollCallback(scrollCallback);
  updateShaderProgram();
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
  ImGui_ImplOpenGL3_Init("#version 440");
}

void FractalSimulator::updateShaderProgram() {
  if (shaderProgram != 0) {
    glDeleteProgram(shaderProgram);
  }
  shaderProgram = ShaderLoader::createShaderProgram("shaders/basic.vert", currentFractal->getFragmentShaderPath());
}

void FractalSimulator::renderUI() {
  ImGui_ImplOpenGL3_NewFrame();
  ImGui_ImplGlfw_NewFrame();
  ImGui::NewFrame();
  ImGui::Begin("Controls");
  ImGui::Text("Fractal Simulator");
  const char* fractalTypes[] = {"Mandelbrot", "Julia"};
  if (ImGui::Combo("Fractal Type", &selectedFractalType, fractalTypes, IM_ARRAYSIZE(fractalTypes))) {
    if (selectedFractalType == 0) {
      currentFractal = std::make_unique<MandelbrotFractal>();
    } else if (selectedFractalType == 1) {
      currentFractal = std::make_unique<JuliaFractal>();
      auto* julia = dynamic_cast<JuliaFractal*>(currentFractal.get());
      if (julia) {
        julia->setC(glm::dvec2(cReal, cImag));
      }
    }
    updateShaderProgram();
  }
  if (selectedFractalType == 1) {
    ImGui::Separator();
    ImGui::Text("Julia Parameters");
    float cRealTemp = static_cast<float>(cReal);
    float cImagTemp = static_cast<float>(cImag);
    bool cChanged = false;
    cChanged |= ImGui::SliderFloat("c Real", &cRealTemp, -2.0f, 2.0f, "%.6f");
    cChanged |= ImGui::SliderFloat("c Imag", &cImagTemp, -2.0f, 2.0f, "%.6f");
    if (cChanged) {
      cReal = static_cast<double>(cRealTemp);
      cImag = static_cast<double>(cImagTemp);
      auto* julia = dynamic_cast<JuliaFractal*>(currentFractal.get());
      if (julia) {
        julia->setC(glm::dvec2(cReal, cImag));
      }
    }
  }
  ImGui::Separator();
  ImGui::SliderInt("Max Iterations", &maxIterations, 10, 10000);
  ImGui::Separator();
  ImGui::Text("Palette Colors");
  ImGui::ColorEdit3("Color 1", &paletteColors[0].x);
  ImGui::ColorEdit3("Color 2", &paletteColors[1].x);
  ImGui::ColorEdit3("Color 3", &paletteColors[2].x);
  ImGui::ColorEdit3("Color 4", &paletteColors[3].x);

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
    glUseProgram(shaderProgram);
    glUniform1i(glGetUniformLocation(shaderProgram, "maxIterations"), maxIterations);
    glUniform3fv(glGetUniformLocation(shaderProgram, "paletteColors"), 4, &paletteColors[0].x);
    currentFractal->setUniforms(shaderProgram);
    renderer.render(shaderProgram, camera.getCenter(), camera.getScale(), width, height);
    renderUI();
    windowManager.swapBuffers();
  }

  ImGui_ImplOpenGL3_Shutdown();
  ImGui_ImplGlfw_Shutdown();
  ImGui::DestroyContext();
}
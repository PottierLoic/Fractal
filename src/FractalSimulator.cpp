#include "FractalSimulator.hpp"

FractalSimulator::FractalSimulator(int width, int height, const char* title): window(nullptr), center(0.0f, 0.0f), scale(4.0f) {
  initGLFW();
  glfwSetWindowSize(window, width, height);
  glfwSetWindowTitle(window, title);
  initOpenGL();
  initImGui();
}

FractalSimulator::~FractalSimulator() {
  cleanup();
}

void FractalSimulator::handleScroll(double xoffset, double yoffset) {
  double xpos, ypos;
  glfwGetCursorPos(window, &xpos, &ypos);
  int width, height;
  glfwGetFramebufferSize(window, &width, &height);
  float aspect = (float)width / (float)height;
  glm::vec2 mouseNorm = glm::vec2(xpos / width, 1.0 - ypos / height);
  glm::vec2 mouseWorld = center + (mouseNorm - 0.5f) * scale * glm::vec2(aspect, 1.0f);
  float zoomFactor = (yoffset > 0 ? 0.9f : 1.1f);
  scale *= zoomFactor;
  center = mouseWorld - (mouseNorm - 0.5f) * scale * glm::vec2(aspect, 1.0f);
  std::cout << "MouseNorm: (" << mouseNorm.x << ", " << mouseNorm.y << ")\n";
  std::cout << "MouseWorld: (" << mouseWorld.x << ", " << mouseWorld.y << ")\n";
  std::cout << "Scale: " << scale << " Center: (" << center.x << ", " << center.y << ")\n";
}

void FractalSimulator::scrollCallback(GLFWwindow* window, double xoffset, double yoffset) {
  FractalSimulator* simulator = static_cast<FractalSimulator*>(glfwGetWindowUserPointer(window));
  simulator->handleScroll(xoffset, yoffset);
}

void FractalSimulator::updateCamera() {
  if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS) {
    if (!isDragging) {
      isDragging = true;
      double xpos, ypos;
      glfwGetCursorPos(window, &xpos, &ypos);
      lastMousePos = glm::vec2(xpos, ypos);
    } else {
      double xpos, ypos;
      glfwGetCursorPos(window, &xpos, &ypos);
      glm::vec2 currentPos(xpos, ypos);
      glm::vec2 delta = currentPos - lastMousePos;
      lastMousePos = currentPos;
      int width, height;
      glfwGetFramebufferSize(window, &width, &height);
      float aspect = (float)width / (float)height;
      center += glm::vec2(-delta.x / (float)width, delta.y / (float)height) * scale * glm::vec2(aspect, 1.0f);
    }
  } else {
    isDragging = false;
  }
}

static std::string readFile(const char* filepath) {
  std::ifstream file(filepath);
  if (!file.is_open()) {
    throw std::runtime_error(std::string("Failed to open file: ") + filepath);
  }
  std::stringstream buffer;
  buffer << file.rdbuf();
  return buffer.str();
}

static GLuint compileShader(GLenum type, const char* source) {
  GLuint shader = glCreateShader(type);
  glShaderSource(shader, 1, &source, nullptr);
  glCompileShader(shader);
  GLint success;
  glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
  if (!success) {
    char infoLog[512];
    glGetShaderInfoLog(shader, 512, nullptr, infoLog);
    throw std::runtime_error(std::string("Shader compilation failed: ") + infoLog);
  }
  return shader;
}

static GLuint createShaderProgram(const char* vertexPath, const char* fragmentPath) {
  std::string vertexCode = readFile(vertexPath);
  std::string fragmentCode = readFile(fragmentPath);

  GLuint vertexShader = compileShader(GL_VERTEX_SHADER, vertexCode.c_str());
  GLuint fragmentShader = compileShader(GL_FRAGMENT_SHADER, fragmentCode.c_str());

  GLuint program = glCreateProgram();
  glAttachShader(program, vertexShader);
  glAttachShader(program, fragmentShader);
  glLinkProgram(program);

  GLint success;
  glGetProgramiv(program, GL_LINK_STATUS, &success);
  if (!success) {
    char infoLog[512];
    glGetProgramInfoLog(program, 512, nullptr, infoLog);
    throw std::runtime_error(std::string("Shader linking failed: ") + infoLog);
  }

  glDeleteShader(vertexShader);
  glDeleteShader(fragmentShader);
  return program;
}

void FractalSimulator::initGLFW() {
  if (!glfwInit()) {
    throw std::runtime_error("Failed to initialize GLFW");
  }
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
  window = glfwCreateWindow(800, 600, "Fractal Simulator", nullptr, nullptr);
  if (!window) {
    glfwTerminate();
    throw std::runtime_error("Failed to create GLFW window");
  }
  glfwMakeContextCurrent(window);
  glfwSetWindowUserPointer(window, this);
  glfwSetScrollCallback(window, scrollCallback);
}

void FractalSimulator::initOpenGL() {
  if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
    throw std::runtime_error("Failed to initialize GLAD");
  }
  float vertices[] = {
      -1.0f, -1.0f,  1.0f, -1.0f,  1.0f,  1.0f,
      -1.0f, -1.0f,  1.0f,  1.0f, -1.0f,  1.0f
  };
  glGenVertexArrays(1, &vao);
  glGenBuffers(1, &vbo);
  glBindVertexArray(vao);
  glBindBuffer(GL_ARRAY_BUFFER, vbo);
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void*)0);
  glEnableVertexAttribArray(0);
  shaderProgram = createShaderProgram("shaders/basic.vert", "shaders/fractal.frag");
}

void FractalSimulator::initImGui() {
  IMGUI_CHECKVERSION();
  ImGui::CreateContext();
  ImGui_ImplGlfw_InitForOpenGL(window, true);
  ImGui_ImplOpenGL3_Init("#version 330");
}

void FractalSimulator::render() {
  glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
  glClear(GL_COLOR_BUFFER_BIT);

  int width, height;
  glfwGetFramebufferSize(window, &width, &height);
  glViewport(0, 0, width, height);
  float aspect = (float)width / (float)height;

  glUseProgram(shaderProgram);
  glUniform2fv(glGetUniformLocation(shaderProgram, "center"), 1, glm::value_ptr(center));
  glUniform1f(glGetUniformLocation(shaderProgram, "scale"), scale);
  glUniform2f(glGetUniformLocation(shaderProgram, "resolution"), (float)width, (float)height);
  glBindVertexArray(vao);
  glDrawArrays(GL_TRIANGLES, 0, 6);

  ImGui_ImplOpenGL3_NewFrame();
  ImGui_ImplGlfw_NewFrame();
  ImGui::NewFrame();
  ImGui::Begin("Controls");
  ImGui::Text("Fractal Simulator");
  ImGui::Text("Center: (%.6f, %.6f)", center.x, center.y);
  ImGui::Text("Scale: %.6f", scale);

  double xpos, ypos;
  glfwGetCursorPos(window, &xpos, &ypos);
  glm::vec2 mouseNorm = glm::vec2(xpos / width, 1.0 - ypos / height);
  glm::vec2 mouseWorld = center + (mouseNorm - 0.5f) * scale * glm::vec2(aspect, 1.0f);
  ImGui::Text("Mouse World: (%.6f, %.6f)", mouseWorld.x, mouseWorld.y);

  ImGui::End();
  ImGui::Render();
  ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

  glfwSwapBuffers(window);
}

void FractalSimulator::run() {
  while (!glfwWindowShouldClose(window)) {
    glfwPollEvents();
    updateCamera();
    if (glfwGetKey(window, GLFW_KEY_R) == GLFW_PRESS) {
      center = glm::vec2(0.0f, 0.0f);
      scale = 4.0f;
    }
    render();
  }
}

void FractalSimulator::cleanup() {
  ImGui_ImplOpenGL3_Shutdown();
  ImGui_ImplGlfw_Shutdown();
  ImGui::DestroyContext();
  glfwDestroyWindow(window);
  glfwTerminate();
}


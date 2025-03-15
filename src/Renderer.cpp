#include "Renderer.hpp"

Renderer::Renderer() {
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
}

Renderer::~Renderer() {
  glDeleteVertexArrays(1, &vao);
  glDeleteBuffers(1, &vbo);
}

void Renderer::render(GLuint shaderProgram, const glm::vec2& center, float scale, int width, int height) {
  glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
  glClear(GL_COLOR_BUFFER_BIT);
  glViewport(0, 0, width, height);

  glUseProgram(shaderProgram);
  glUniform2fv(glGetUniformLocation(shaderProgram, "center"), 1, glm::value_ptr(center));
  glUniform1f(glGetUniformLocation(shaderProgram, "scale"), scale);
  glUniform2f(glGetUniformLocation(shaderProgram, "resolution"), (float)width, (float)height);
  glBindVertexArray(vao);
  glDrawArrays(GL_TRIANGLES, 0, 6);
}
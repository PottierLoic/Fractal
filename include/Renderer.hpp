#ifndef RENDERER_HPP
#define RENDERER_HPP

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <stdexcept>

class Renderer {
public:
  Renderer();
  ~Renderer();
  void render(GLuint shaderProgram, const glm::dvec2& center, double scale, int width, int height);
private:
  GLuint vao, vbo;
};

#endif
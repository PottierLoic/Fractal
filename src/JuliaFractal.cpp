#include "JuliaFractal.hpp"

JuliaFractal::JuliaFractal() : c(-0.4, 0.6) {}

void JuliaFractal::setUniforms(GLuint shaderProgram) const {
  glUniform2dv(glGetUniformLocation(shaderProgram, "c"), 1, glm::value_ptr(c));
}
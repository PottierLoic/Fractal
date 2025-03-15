#ifndef JULIA_FRACTAL_HPP
#define JULIA_FRACTAL_HPP

#include "Fractal.hpp"

class JuliaFractal : public Fractal {
public:
  JuliaFractal();
  void setUniforms(GLuint shaderProgram) const override;
  const char* getFragmentShaderPath() const override { return "shaders/julia.frag"; }
  glm::dvec2 getC() const { return c; }
  void setC(const glm::dvec2& newC) { c = newC; }
private:
  glm::dvec2 c;
};

#endif
#ifndef MANDELBROT_FRACTAL_HPP
#define MANDELBROT_FRACTAL_HPP

#include "Fractal.hpp"

class MandelbrotFractal : public Fractal {
public:
  void setUniforms(GLuint shaderProgram) const override;
  const char* getFragmentShaderPath() const override { return "shaders/mandelbrot.frag"; }
};

#endif
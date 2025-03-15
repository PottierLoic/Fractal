#ifndef FRACTAL_HPP
#define FRACTAL_HPP

#include <glad/glad.h>
#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>

class Fractal {
public:
  virtual ~Fractal() = default;
  virtual void setUniforms(GLuint shaderProgram) const = 0;
  virtual const char* getFragmentShaderPath() const = 0;
};

#endif
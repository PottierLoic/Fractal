#ifndef SHADER_LOADER_HPP
#define SHADER_LOADER_HPP

#include <glad/glad.h>
#include <string>

class ShaderLoader {
public:
  static GLuint createShaderProgram(const char* vertexPath, const char* fragmentPath);
private:
  static std::string readFile(const char* filepath);
  static GLuint compileShader(GLenum type, const char* source);
};

#endif
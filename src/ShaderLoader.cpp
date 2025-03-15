#include "ShaderLoader.hpp"
#include <fstream>
#include <sstream>
#include <stdexcept>

std::string ShaderLoader::readFile(const char* filepath) {
  std::ifstream file(filepath);
  if (!file.is_open()) {
    throw std::runtime_error(std::string("Failed to open file: ") + filepath);
  }
  std::stringstream buffer;
  buffer << file.rdbuf();
  return buffer.str();
}

GLuint ShaderLoader::compileShader(GLenum type, const char* source) {
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

GLuint ShaderLoader::createShaderProgram(const char* vertexPath, const char* fragmentPath) {
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
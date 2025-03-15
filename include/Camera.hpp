#ifndef CAMERA_HPP
#define CAMERA_HPP

#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <imgui.h>

class Camera {
public:
  Camera();
  void update(GLFWwindow* window);
  void handleScroll(GLFWwindow* window, double xoffset, double yoffset);
  glm::vec2 getCenter() const { return center; }
  float getScale() const { return scale; }
  glm::vec2 getMouseWorld(GLFWwindow* window) const;
private:
  glm::vec2 center;
  float scale;
  bool isDragging;
  glm::vec2 lastMousePos;
};

#endif
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
  glm::dvec2 getCenter() const { return center; }
  double getScale() const { return scale; }
  glm::dvec2 getMouseWorld(GLFWwindow* window) const;
private:
  glm::dvec2 center;
  double scale;
  bool isDragging;
  glm::dvec2 lastMousePos;
};

#endif
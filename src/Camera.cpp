#include "Camera.hpp"
#include <iostream>

Camera::Camera() : center(0.0f, 0.0f), scale(4.0f), isDragging(false), lastMousePos(0.0f, 0.0f) {}

void Camera::update(GLFWwindow* window) {
  if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS && !ImGui::GetIO().WantCaptureMouse) {
    if (!isDragging) {
      isDragging = true;
      double xpos, ypos;
      glfwGetCursorPos(window, &xpos, &ypos);
      lastMousePos = glm::dvec2(xpos, ypos);
    } else {
      double xpos, ypos;
      glfwGetCursorPos(window, &xpos, &ypos);
      glm::dvec2 currentPos(xpos, ypos);
      glm::dvec2 delta = currentPos - lastMousePos;
      lastMousePos = currentPos;
      int width, height;
      glfwGetFramebufferSize(window, &width, &height);
      double aspect = (double)width / (double)height;
      center += glm::dvec2(-delta.x / (double)width, delta.y / (double)height) * scale * glm::dvec2(aspect, 1.0);
    }
  } else {
    isDragging = false;
  }
}

void Camera::handleScroll(GLFWwindow* window, double xoffset, double yoffset) {
  double xpos, ypos;
  glfwGetCursorPos(window, &xpos, &ypos);
  int width, height;
  glfwGetFramebufferSize(window, &width, &height);
  double aspect = (double)width / (double)height;
  glm::dvec2 mouseNorm = glm::dvec2(xpos / width, 1.0 - ypos / height);
  glm::dvec2 mouseWorld = center + (mouseNorm - 0.5) * scale * glm::dvec2(aspect, 1.0);
  double zoomFactor = (yoffset > 0 ? 0.9 : 1.1);
  scale *= zoomFactor;
  center = mouseWorld - (mouseNorm - 0.5) * scale * glm::dvec2(aspect, 1.0);
}

glm::dvec2 Camera::getMouseWorld(GLFWwindow* window) const {
  double xpos, ypos;
  glfwGetCursorPos(window, &xpos, &ypos);
  int width, height;
  glfwGetFramebufferSize(window, &width, &height);
  double aspect = (double)width / (double)height;
  glm::dvec2 mouseNorm = glm::dvec2(xpos / width, 1.0 - ypos / height);
  return center + (mouseNorm - 0.5) * scale * glm::dvec2(aspect, 1.0);
}
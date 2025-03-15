#include "Camera.hpp"
#include <iostream>

Camera::Camera() : center(0.0f, 0.0f), scale(4.0f), isDragging(false), lastMousePos(0.0f, 0.0f) {}

void Camera::update(GLFWwindow* window) {
  if (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS && !ImGui::GetIO().WantCaptureMouse) {
    if (!isDragging) {
      isDragging = true;
      double xpos, ypos;
      glfwGetCursorPos(window, &xpos, &ypos);
      lastMousePos = glm::vec2(xpos, ypos);
    } else {
      double xpos, ypos;
      glfwGetCursorPos(window, &xpos, &ypos);
      glm::vec2 currentPos(xpos, ypos);
      glm::vec2 delta = currentPos - lastMousePos;
      lastMousePos = currentPos;
      int width, height;
      glfwGetFramebufferSize(window, &width, &height);
      float aspect = (float)width / (float)height;
      center += glm::vec2(-delta.x / (float)width, delta.y / (float)height) * scale * glm::vec2(aspect, 1.0f);
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
  float aspect = (float)width / (float)height;
  glm::vec2 mouseNorm = glm::vec2(xpos / width, 1.0 - ypos / height);
  glm::vec2 mouseWorld = center + (mouseNorm - 0.5f) * scale * glm::vec2(aspect, 1.0f);
  float zoomFactor = (yoffset > 0 ? 0.9f : 1.1f);
  scale *= zoomFactor;
  center = mouseWorld - (mouseNorm - 0.5f) * scale * glm::vec2(aspect, 1.0f);
  std::cout << "MouseNorm: (" << mouseNorm.x << ", " << mouseNorm.y << ")\n";
  std::cout << "MouseWorld: (" << mouseWorld.x << ", " << mouseWorld.y << ")\n";
  std::cout << "Scale: " << scale << " Center: (" << center.x << ", " << center.y << ")\n";
}

glm::vec2 Camera::getMouseWorld(GLFWwindow* window) const {
  double xpos, ypos;
  glfwGetCursorPos(window, &xpos, &ypos);
  int width, height;
  glfwGetFramebufferSize(window, &width, &height);
  float aspect = (float)width / (float)height;
  glm::vec2 mouseNorm = glm::vec2(xpos / width, 1.0 - ypos / height);
  return center + (mouseNorm - 0.5f) * scale * glm::vec2(aspect, 1.0f);
}
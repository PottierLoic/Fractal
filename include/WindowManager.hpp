#ifndef WINDOW_MANAGER_HPP
#define WINDOW_MANAGER_HPP

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <stdexcept>

class WindowManager {
public:
  WindowManager(int width, int height, const char* title);
  ~WindowManager();
  GLFWwindow* getWindow() const { return window; }
  void setUserPointer(void* ptr) { glfwSetWindowUserPointer(window, ptr); }
  void setScrollCallback(GLFWscrollfun callback) { glfwSetScrollCallback(window, callback); }
  bool shouldClose() const { return glfwWindowShouldClose(window); }
  void pollEvents() { glfwPollEvents(); }
  void swapBuffers() { glfwSwapBuffers(window); }
private:
  GLFWwindow* window;
};

#endif
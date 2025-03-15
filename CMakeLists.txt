cmake_minimum_required(VERSION 3.10)
project(FractalSimulator)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(external/glfw)

set(GLAD_DIR external/glad)
set(IMGUI_DIR external/imgui)

set(SOURCES
  src/main.cpp
  src/FractalSimulator.cpp
  src/WindowManager.cpp
  src/Renderer.cpp
  src/Camera.cpp
  src/ShaderLoader.cpp
  src/MandelbrotFractal.cpp
  src/JuliaFractal.cpp
)

set(GLAD_SOURCES ${GLAD_DIR}/src/glad.c)

set(IMGUI_SOURCES
  ${IMGUI_DIR}/imgui.cpp
  ${IMGUI_DIR}/imgui_draw.cpp
  ${IMGUI_DIR}/imgui_widgets.cpp
  ${IMGUI_DIR}/imgui_tables.cpp
  ${IMGUI_DIR}/backends/imgui_impl_glfw.cpp
  ${IMGUI_DIR}/backends/imgui_impl_opengl3.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES} ${GLAD_SOURCES} ${IMGUI_SOURCES})

target_include_directories(${PROJECT_NAME} PRIVATE
  include
  external/glfw/include
  ${GLAD_DIR}/include
  ${IMGUI_DIR}
  ${IMGUI_DIR}/backends
  external/glm
)

find_package(OpenGL REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE
  OpenGL::GL
  glfw
)

file(COPY ${CMAKE_SOURCE_DIR}/shaders DESTINATION ${CMAKE_BINARY_DIR})
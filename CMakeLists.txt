cmake_minimum_required(VERSION 3.10)
project(FractalSimulator)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(external/glfw)

include_directories(external/glm)

set(GLAD_DIR external/glad)
set(GLAD_SOURCES ${GLAD_DIR}/src/glad.c)

set(SOURCES
    src/main.cpp
    src/FractalSimulator.cpp
)

set(IMGUI_DIR external/imgui)
set(IMGUI_SOURCES
    ${IMGUI_DIR}/imgui.cpp
    ${IMGUI_DIR}/imgui_draw.cpp
    ${IMGUI_DIR}/imgui_widgets.cpp
    ${IMGUI_DIR}/imgui_tables.cpp
    ${IMGUI_DIR}/backends/imgui_impl_glfw.cpp
    ${IMGUI_DIR}/backends/imgui_impl_opengl3.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES} ${IMGUI_SOURCES} ${GLAD_SOURCES})

target_include_directories(${PROJECT_NAME} PRIVATE
    src
    external/glfw/include
    ${IMGUI_DIR}
    ${GLAD_DIR}/include
)

target_link_libraries(${PROJECT_NAME} PRIVATE glfw)

file(COPY ${CMAKE_SOURCE_DIR}/src/shaders DESTINATION ${CMAKE_BINARY_DIR})
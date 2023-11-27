cmake_minimum_required(VERSION 3.5...3.27)
set(CMAKE_WARN_DEPRECATED OFF CACHE BOOL "" FORCE)

project(app
  LANGUAGES CXX
  VERSION 1.0
)

file(
  GLOB_RECURSE HEADER_LIST
  CONFIGURE_DEPENDS
  "${PROJECT_SOURCE_DIR}/include/*.hpp"
)

file(
  GLOB_RECURSE SOURCE_LIST
  CONFIGURE_DEPENDS
  "${PROJECT_SOURCE_DIR}/src/*.cpp"
)

add_executable(${PROJECT_NAME} ${SOURCE_LIST} ${HEADER_LIST})

target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include)

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
endif(CCACHE_FOUND)

add_subdirectory(dependencies)

target_link_libraries(${PROJECT_NAME} PRIVATE ImGui-SFML::ImGui-SFML)

if(FLAGS STREQUAL "--debug")
  target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra)
else()
  target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Werror)
endif()
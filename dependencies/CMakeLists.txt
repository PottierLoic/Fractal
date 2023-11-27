include(FetchContent)


# Cloning sfml
FetchContent_Declare(
  sfml
  URL https://github.com/SFML/SFML/archive/refs/tags/2.6.1.zip
)

# Cloning imgui
FetchContent_Declare(
  imgui
  URL https://github.com/ocornut/imgui/archive/refs/tags/v1.89.9.zip
  URL_HASH "MD5=a5524cc1f386ae2661a6de3cc3107869"
)
FetchContent_MakeAvailable(imgui)

# Cloning imgui-sfml
FetchContent_Declare(
  imgui-sfml
  URL https://github.com/SFML/imgui-sfml/archive/refs/tags/v2.6.zip
  URL_HASH "MD5=309c8dadcf0ba96b74d3d42e7fd8aaad"
)

set(no_dev_warnings_backup "$CACHE{CMAKE_SUPPRESS_DEVELOPER_WARNINGS}")
set(CMAKE_SUPPRESS_DEVELOPER_WARNINGS ON CACHE INTERNAL "" FORCE)
add_subdirectory(imgui-sfml)
add_subdirectory(sfml)
set(CMAKE_SUPPRESS_DEVELOPER_WARNINGS ${no_dev_warnings_backup} CACHE INTERNAL "" FORCE)

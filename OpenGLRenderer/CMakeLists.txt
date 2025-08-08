# CMakeList.txt : CMake project for OpenGLRenderer, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (OpenGLRenderer "OpenGLRenderer.cpp" "OpenGLRenderer.h" "camera.h" "Shader.h" "ImGuiPanel.h" "ImGuiPanel.cpp" "AppState.h")

add_custom_target(copy_shaders ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_CURRENT_SOURCE_DIR}/shaders
    ${CMAKE_CURRENT_BINARY_DIR}/shaders
)

add_custom_target(copy_textures ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_CURRENT_SOURCE_DIR}/textures
    ${CMAKE_CURRENT_BINARY_DIR}/textures
)

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET OpenGLRenderer PROPERTY CXX_STANDARD 20)
endif()

find_package(imgui CONFIG REQUIRED)
target_link_libraries(OpenGLRenderer PRIVATE imgui::imgui)

find_package(glfw3 CONFIG REQUIRED)
target_link_libraries(OpenGLRenderer PRIVATE glfw)

find_package(glad CONFIG REQUIRED)
target_link_libraries(OpenGLRenderer PRIVATE glad::glad)

find_package(glm CONFIG REQUIRED)
target_link_libraries(OpenGLRenderer PRIVATE glm::glm-header-only)

find_path(STB_INCLUDE_DIRS "stb_image.h")
target_include_directories(OpenGLRenderer PRIVATE ${STB_INCLUDE_DIRS})
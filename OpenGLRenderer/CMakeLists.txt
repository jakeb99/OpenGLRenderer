# CMakeList.txt : CMake project for OpenGLRenderer, include source and define
# project specific logic here.
#

# Add source to this project's executable.
add_executable (OpenGLRenderer "OpenGLRenderer.cpp" "OpenGLRenderer.h" "camera.h" "Shader.h" "ImGuiPanel.h" "ImGuiPanel.cpp" "AppState.h")

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
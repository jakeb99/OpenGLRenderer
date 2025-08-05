#pragma once

#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_opengl3.h>

#include "AppState.h"

class ImGuiPanel
{
private:
	AppState* state;
public:
	ImGuiPanel(AppState* appState) : state(appState) {}
	void Init(GLFWwindow* window, const char* glsl_version);
	void NewFrame();
	virtual void Update();
	void Render();
	void Shutdown();
};
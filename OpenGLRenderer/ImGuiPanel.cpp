#include "ImGuiPanel.h"

void ImGuiPanel::Init(GLFWwindow* window, const char* glsl_version)
{
	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO& io = ImGui::GetIO();

	ImGui_ImplGlfw_InitForOpenGL(window, true);
	ImGui_ImplOpenGL3_Init(glsl_version);

	ImGui::StyleColorsDark();
}

void ImGuiPanel::NewFrame()
{
	ImGui_ImplOpenGL3_NewFrame();
	ImGui_ImplGlfw_NewFrame();
	ImGui::NewFrame();
}

void ImGuiPanel::Update()
{
	//ImGui::ShowDemoWindow(); 
	if (ImGui::Begin("Test Window"))
	{
		ImGui::Text("Lighting Settings");

		ImGui::ColorEdit3("Light Color", (float*)&state->lightColor, ImGuiColorEditFlags_Float);

		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		//ImGui::ColorEdit3("Ambient Color", (float*)&state->material.ambient, ImGuiColorEditFlags_Float);
		ImGui::InputFloat3("Ambient Light", (float*)&state->lightProps.ambient);

		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		//ImGui::ColorEdit3("Diffuse Color", (float*)&state->material.diffuse, ImGuiColorEditFlags_Float);
		ImGui::InputFloat3("Diffuse Light", (float*)&state->lightProps.diffuse);

		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		ImGui::ColorEdit3("Specular Color", (float*)&state->material.specular, ImGuiColorEditFlags_Float);
		ImGui::InputFloat3("Specular Light", (float*)&state->lightProps.specular);

		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		ImGui::SliderFloat("Shininess", &state->material.shininess, 0.001f, 1.0f);

		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		// directional light settings
		ImGui::Text("Directional Light Settings");
		ImGui::SliderFloat3("Direction", (float*)&state->lightProps.direction, -1.0f, 0.0f, "%.2f");

		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		// positional light settings
		ImGui::Text("positional Light Settings");
		ImGui::SliderFloat("Linear Coefficient", {&state->lightProps.linear}, 0.0f, 1.0f, "%.2f");
		ImGui::SliderFloat("Quadratic Coefficient", {&state->lightProps.quadratic}, 0.0f, 1.0f, "%.2f");
		ImGui::SliderFloat3("Position", (float*)&state->lightProps.position, -10.0f, 10.0f, "%.1f");
		if (ImGui::Button("Reset Position"))
		{
			state->lightProps.position = glm::vec3(1.2f, 1.0f, 2.0f);
		}
		ImGui::Dummy(ImVec2(0.0f, 20.0f));
		ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
	} ImGui::End();
}

void ImGuiPanel::Render()
{
	ImGui::Render();
	ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
}

void ImGuiPanel::Shutdown()
{
	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplGlfw_Shutdown();
	ImGui::DestroyContext();
}

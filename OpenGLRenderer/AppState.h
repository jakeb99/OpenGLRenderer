#pragma once
#include <imgui.h>
#include <glm/glm.hpp>

struct Material {
	glm::vec3 ambient = glm::vec3(1.0f, 0.5f, 0.31f);
	glm::vec3 diffuse = glm::vec3(1.0f, 0.5f, 0.31f);
	glm::vec3 specular = glm::vec3(0.5f, 0.5f, 0.5f);
	float shininess = 0.25f;
};

struct Light {
	glm::vec3 position = glm::vec3(1.2f, 1.0f, 2.0f);
	glm::vec3 direction = glm::vec3(-0.2f, -1.0f, -0.3f);
	glm::vec3 ambient = glm::vec3(0.2f, 0.2f, 0.2f);
	glm::vec3 diffuse = glm::vec3(0.5f, 0.5f, 0.5f);
	glm::vec3 specular = glm::vec3(1.0f, 1.0f, 1.0f);;
	
	float constant = 1.0f;
	float linear = 0.09f;
	float quadratic = 0.032f;
};

struct AppState {
	ImVec4 lightColor = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);
	float gridCellSize = 0.025;

	Material material;
	Light lightProps;
};
#version 330 core

in vec3 Normal;
in vec3 FragPos;
out vec4 FragColor;

uniform vec3 objectColor;
uniform vec3 lightColor;
uniform float ambientFactor;
uniform vec3 lightPos;
uniform vec3 viewPos;
uniform float specFactor;

void main()
{
    vec3 ambient = ambientFactor * lightColor;

    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuseAmount = diff * lightColor;

    // calc the reflection
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 relection = reflect(-lightDir, norm);
    float specDiff = pow(max(dot(viewDir, relection), 0.0), 32);
    vec3 specAmount = specDiff * specFactor * lightColor;

    FragColor = vec4((ambient + diffuseAmount + specAmount) * objectColor, 1.0);
}
#version 330 core

struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};

struct Light {
    vec3 position;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

in vec3 Normal;
in vec3 FragPos;

uniform vec3 viewPos;
uniform Material material;
uniform Light light;

out vec4 FragColor;

void main()
{
    // ambient
    vec3 ambient = light.ambient * material.ambient;

    // diffuse
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(light.position - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * (material.diffuse * diff);

    // specular
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 relection = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, relection), 0.0), material.shininess * 128.0f);
    vec3 specular = light.specular * (spec * material.specular);
    
    FragColor = vec4((ambient + diffuse + specular), 1.0);
}
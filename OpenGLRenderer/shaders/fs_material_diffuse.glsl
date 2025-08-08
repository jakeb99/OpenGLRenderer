#version 330 core

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    sampler2D emission;
    float shininess;
};

in vec2 TexCoords;

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
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));

    // diffuse
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(light.position - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));

    // specular
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 relection = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, relection), 0.0), material.shininess * 128.0f);
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoords));
    
    // emission
    vec3 emission = vec3(texture(material.emission, TexCoords * (1.0 + 0.12 * 2.0) - 0.12));
    
    FragColor = vec4((ambient + diffuse + specular + emission), 1.0);
}
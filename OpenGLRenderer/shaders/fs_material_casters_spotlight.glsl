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
    vec3 direction;

    float cutOff;
    float outerCutOff;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    float constant;
    float linear;
    float quadratic;
    float intensity;
};

in vec3 Normal;
in vec3 FragPos;

uniform vec3 viewPos;
uniform Material material;
uniform Light light;

out vec4 FragColor;

void main()
{
    // spot light stuff
    vec3 lightDir = normalize(light.position - FragPos);

    float theta = dot(lightDir, normalize(-light.direction));   // theta, angle between lightdir and spotlightDir
    float epsilon = light.cutOff - light.outerCutOff;           // epsilon, the inner Outer cuttoff Cosine Diff
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);   // outer cutoff intensity

    // ambient
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));

    // diffuse
    vec3 norm = normalize(Normal);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));

    // specular
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 relection = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, relection), 0.0), material.shininess * 128.0);
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoords));

    diffuse *= intensity;
    specular *= intensity;
    
    // light attenuation
    float distance = length(light.position - FragPos);
    float atten = light.intensity / (light.constant + light.linear * distance + light.quadratic * (distance * distance));
    //ambient *= atten;
    diffuse *= atten;
    specular *= atten;
    
    FragColor = vec4((ambient + diffuse + specular), 1.0);
}
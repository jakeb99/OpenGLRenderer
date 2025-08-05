#version 330

in vec3 WorldPos;

layout (location = 0) out vec4 FragColor;

uniform float gGridCellSize = 0.025;
uniform vec4 gGridColorThin = vec4(0.5, 0.5, 0.5, 1.0);
uniform vec4 gGridColorThick = vec4(0.0, 0.0, 0.0, 1.0);

void main()
{
    vec2 dvx = vec2(dFdx(WorldPos.x), dFdy(WorldPos.x));
    vec2 dvy = vec2(dFdx(WorldPos.z), dFdy(WorldPos.z));

    float lx = length(dvx);
    float ly = length(dvy);

    dudv *= 4.0; 

    //float Lod0a = mod(WorldPos.z, gGridCellSize);
    float Lod0a = max2(mod(WorldPos.xz, gGridCellSize) / dudv);

    vec4 color = gGridColorThick;
    color.a *= Lod0a;

    FragColor = color;
}
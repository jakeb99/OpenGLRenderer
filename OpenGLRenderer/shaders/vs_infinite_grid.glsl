# version 330

out vec3 WorldPos;

uniform mat4 gVP = mat4(1.0);    // grid view proj
uniform vec3 gCameraWorlPos;

// set up vertex info in the shader so we can use this across multiple projects easily
const vec3 Pos[4] = vec3[4](
	vec3(-1.0, 0.0, -1.0),
	vec3(1.0, 0.0, -1.0),
	vec3(1.0, 0.0, 1.0),
	vec3(-1.0, 0.0, 1.0)
);

const int indices[6] = int[6](0,2,1,2,0,3);

void main()
{
    int index = indices[gl_VertexID];
	
	vec3 vPos3 = Pos[index];
	
	vPos3.x += gCameraWorlPos.x;
	vPos3.z += gCameraWorlPos.z;

	vec4 vPos4 = vec4(vPos3, 1.0);

	gl_Position = gVP * vPos4;

	WorldPos = vPos3;
}
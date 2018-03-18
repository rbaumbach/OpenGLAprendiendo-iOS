#include "ShaderConstants.hpp"

// These are for iOS and use version 300 es

const GLchar *VERTEX_SHADER = "#version 300 es\n"
"layout (location = 0) in vec3 position;\n"
"layout (location = 1) in vec3 aColor;\n"
"out vec3 ourColor;\n"
"void main()\n"
"{\n"
"   gl_Position = vec4(position.x, position.y, position.z, 1.0);\n"
"   ourColor = aColor;\n"
"}";

const GLchar *FRAGMENT_SHADER = "#version 300 es\n"
"precision mediump float;\n"
"in vec3 ourColor;\n"
"out vec4 FragColor;\n"
"void main()\n"
"{\n"
"   FragColor = vec4(ourColor, 1.0);\n"
"}";

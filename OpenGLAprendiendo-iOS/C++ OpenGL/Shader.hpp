#ifndef Shader_hpp
#define Shader_hpp

#include <GL/glew.h>

class Shader
{
public:
    // The program that has the linked shaders
    
    GLuint program;
    
    // Constructor generates the shader on the fly
    
    Shader(const GLchar *vertexPath, const GLchar *fragmentPath);
    
    // Uses the current shader
    
    void useProgram();
};

#endif

#ifndef Triangle_hpp
#define Triangle_hpp

// Shader class includes GLEW

#include "Shader.hpp"

class Triangle
{
public:
    Triangle();
    
    void setup();
    void teardown();
    void render();
    
private:
    GLuint VAO;
    GLuint VBO;
    Shader shader;
};

#endif

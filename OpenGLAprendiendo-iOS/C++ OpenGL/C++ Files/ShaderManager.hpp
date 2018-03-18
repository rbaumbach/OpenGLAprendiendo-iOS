#ifndef Shader_hpp
#define Shader_hpp

// Note: See "TargetConditionals.h" for TARGET information

#ifdef __APPLE__
    #include "TargetConditionals.h"

    #if TARGET_OS_OSX
        #include <GL/glew.h>
    #else
        #include <OpenGLES/ES3/glext.h>
    #endif
#endif

class ShaderManager
{
public:
    void loadShadersFromPaths(const GLchar *vertexPath, const GLchar *fragmentPath);
    
    // This is so that I can load hardcoded shaders on iOS so that I don't have to deal
    // with the filesystem right now.
    
    void loadHardcodedShaders();
    
    // Uses the current shaders
    
    void useProgram();
private:
    GLuint shaderProgram;
};

#endif

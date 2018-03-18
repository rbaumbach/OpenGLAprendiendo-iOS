#ifndef ShaderConstants_hpp
#define ShaderConstants_hpp

// Note: See "TargetConditionals.h" for TARGET information

#ifdef __APPLE__
    #include "TargetConditionals.h"

    #if TARGET_OS_OSX
        #include <GL/glew.h>
    #else
        #include <OpenGLES/ES3/glext.h>
    #endif
#endif


extern const GLchar *VERTEX_SHADER;
extern const GLchar *FRAGMENT_SHADER;

#endif

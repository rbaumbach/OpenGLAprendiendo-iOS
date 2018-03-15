import OpenGLES

class BaseEffect {
    // MARK: - Private Properties
    
    private var programHandle: GLuint = 0
    
    // MARK: - Init Method
    
    init(vertexShader: String, fragmentShader: String, attributes: [VertexAttributes: String]) {
        compile(vertexShader: vertexShader,
                fragmentShader: fragmentShader,
                attributes: attributes)
    
        glUseProgram(programHandle)
    }
    
    // MARK: - Private Methods
    
    private func compile(vertexShader: String, fragmentShader: String, attributes: [VertexAttributes: String]) {
        let vertexShaderName = compileShader(name: vertexShader, type: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderName = compileShader(name: fragmentShader, type: GLenum(GL_FRAGMENT_SHADER))
        
        programHandle = glCreateProgram()
        
        glAttachShader(programHandle, vertexShaderName)
        glAttachShader(programHandle, fragmentShaderName)
        
        glLinkProgram(programHandle)
        
        var shaderLinkProgramSuccess: GLint = GL_FALSE
        
        glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &shaderLinkProgramSuccess)
        
        if (shaderLinkProgramSuccess == GL_FALSE) {
            printErrorLog(message: "compile(vertexShader:fragmentShader:).glLinkProgram() failed")
            
            return
        }
        
        attributes.forEach { attribute, attributeName in
            glBindAttribLocation(programHandle, GLuint(attribute.rawValue), attributeName)
        }
    }
    
    private func compileShader(name: String, type: GLenum) -> GLuint {
        let shaderPath = Bundle.main.path(forResource: name, ofType:nil)
        
        var error : NSError?
        let shaderString: NSString?
        
        do {
            shaderString = try NSString(contentsOfFile: shaderPath!, encoding:String.Encoding.utf8.rawValue)
        } catch let error1 as NSError {
            error = error1
            shaderString = nil
        }
        
        if error != nil {
            print("compileShader(): error loading shader: \(error!.localizedDescription)")
            
            // junk value
            
            return 999
        }
        
        var shaderStringUTF8 = shaderString!.utf8String
        
        let shaderHandle = glCreateShader(type)
        
        glShaderSource(shaderHandle, 1, &shaderStringUTF8, nil)
        
        glCompileShader(shaderHandle)
        
        var shaderCompileSuccess: GLint = GL_FALSE
        glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &shaderCompileSuccess)
        
        if (shaderCompileSuccess == GL_FALSE) {
            printErrorLog(message: "compileShader.glCompileShader() failed")
            
            // junk value

            return 999
        }
        
        return shaderHandle
    }
    
    private func printErrorLog(message: String) {
        var logLength: GLint = 0
        
        glGetProgramiv(programHandle, GLenum(GL_INFO_LOG_LENGTH), &logLength)
        
        let log = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
        
        glGetProgramInfoLog(programHandle, logLength, nil, log)
        
        let logString: NSString = NSString(utf8String: log)!
        
        print("\(message): \(logString)")
    }
}

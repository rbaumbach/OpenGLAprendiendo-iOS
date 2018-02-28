import OpenGLES

class BaseEffect {
    // MARK: - Private Properties
    
    private var programHandle: GLuint = GLuint()
    
    // MARK: - Init Method
    
    init(vertexShader: String, fragmentShader: String) {
        compile(vertexShader: vertexShader, fragmentShader: fragmentShader)
    }
    
    // MARK: - Public Method
    
    func prepareToDraw() {
        glUseProgram(programHandle)
    }
    
    // MARK: - Private Methods
    
    private func compile(vertexShader: String, fragmentShader: String) {
        let vertexShaderName = compileShader(name: vertexShader, type: GLenum(GL_VERTEX_SHADER))
        let fragmentShaderName = compileShader(name: fragmentShader, type: GLenum(GL_FRAGMENT_SHADER))
        
        programHandle = glCreateProgram()
        
        glAttachShader(programHandle, vertexShaderName)
        glAttachShader(programHandle, fragmentShaderName)
        
        glBindAttribLocation(programHandle, GLuint(VertexAttributes.vertextAttribPosition.rawValue), "a_Position")
        
        glLinkProgram(programHandle)
        
        var shaderLinkProgramSuccess = GLint()
        
        glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &shaderLinkProgramSuccess)
        if (shaderLinkProgramSuccess == GL_FALSE) {
            let infoLog = UnsafeMutablePointer<GLchar>.allocate(capacity: 256)
            var infoLogLength = GLsizei()
            
            glGetProgramInfoLog(programHandle, GLsizei(MemoryLayout<GLchar>.size * 256), &infoLogLength, infoLog)
            
            print("compile(vertexShader:fragmentShader:).glLinkProgram() failed: \(String(cString:  infoLog))")
            
            return
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
        var shaderStringLength: GLint = GLint(Int32(shaderString!.length))
        
        let shaderHandle = glCreateShader(type)
        
        glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength)
        
        glCompileShader(shaderHandle)
        
        var shaderCompileSuccess = GLint()
        glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &shaderCompileSuccess)
        
        if (shaderCompileSuccess == GL_FALSE) {
            let infoLog = UnsafeMutablePointer<GLchar>.allocate(capacity: 256)
            var infoLogLength = GLsizei()
            
            glGetShaderInfoLog(shaderHandle, GLsizei(MemoryLayout<GLchar>.size * 256), &infoLogLength, infoLog)
            
            print("compileShader.glCompileShader() failed: \(String(cString: infoLog))")
            
            infoLog.deallocate(capacity: 256)
            
            // junk value
            
            return 999
        }
        
        return shaderHandle
    }
}

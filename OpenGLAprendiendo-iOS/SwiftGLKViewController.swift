import GLKit

class SwiftGLKViewController: GLKViewController {
    // MARK: - Private Properties
    
    // ray wenderlich has triple nested arrays { {{ pointA }}, {{ PointB }}, {{ PointC }} }
    // will probably have to change the structure of Vertex to reflect this in Swift since it's
    // no longer a C struct that is used in the video for Objective-C

    private let vertices: [GLfloat] = [
                                        // position         // color
                                        0.5, -0.25, 0.0,    1.0, 0.0, 0.0,  // bottom right
                                        -0.5, -0.25, 0.0,   0.0, 1.0, 0.0,  // bottom left
                                        0.0, 0.25, 0.0,     0.0, 0.0, 1.0   // top
                                      ]
    
    private var vertexBuffer: GLuint = 0
    
    private var baseEffect: BaseEffect?
    
    // MARK: - GLKViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - GLKViewDelegate
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        glEnableVertexAttribArray(GLuint(VertexAttributes.vertexAttribPosition.rawValue))
        glVertexAttribPointer(GLuint(VertexAttributes.vertexAttribPosition.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(6 * MemoryLayout<GLfloat>.size), UnsafePointer<Int>(bitPattern:0))
        
        glEnableVertexAttribArray(GLuint(VertexAttributes.vertexAttribColor.rawValue))
        glVertexAttribPointer(GLuint(VertexAttributes.vertexAttribColor.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(6 * MemoryLayout<GLfloat>.size), UnsafePointer<Int>(bitPattern:(3 * MemoryLayout<GLfloat>.size)))
        
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        
        glDisableVertexAttribArray(GLuint(VertexAttributes.vertexAttribPosition.rawValue))
        glDisableVertexAttribArray(GLuint(VertexAttributes.vertexAttribColor.rawValue))
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        let glkView = view as! GLKView
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES2)!
        
        EAGLContext.setCurrent(glkView.context)
        
        setupShaders()
        setupVertexBuffer()
        
        glClearColor(0.2, 0.3, 0.3, 1.0)
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
    }
    
    private func setupShaders() {
        baseEffect = BaseEffect(vertexShader: "SimpleVertex.glsl",
                                fragmentShader: "SimpleFragment.glsl",
                                attributes: [VertexAttributes.vertexAttribPosition: "a_Position",
                                             VertexAttributes.vertexAttribColor: "a_Color"])
    }
    
    private func setupVertexBuffer() {
        glGenFramebuffers(1, &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<GLfloat>.size , vertices, GLenum(GL_STATIC_DRAW))
    }
}

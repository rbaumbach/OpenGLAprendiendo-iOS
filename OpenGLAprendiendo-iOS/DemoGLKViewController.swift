import UIKit
import GLKit;

class DemoGLKViewController: GLKViewController {
    // MARK: - Private Properties
    
    // ray wenderlich has triple nested arrays { {{ pointA }}, {{ PointB }}, {{ PointC }} }
    // will probably have to change the structure of Vertex to reflect this in Swift since it's
    // no longer a C struct that is used in the video for Objective-C

    private let vertices: [GLfloat] = [ -0.5, -0.25, 0.0, // bottom left
                                0.5, -0.25, 0.0,  // bottom right
                                0.0,  0.25, 0.0 ] // top

    private var vertexBuffer = GLuint()
    
    private var baseEffect: BaseEffect?
    
    // MARK: - GLKViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let glkView = view as! GLKView
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES2)!
        
        EAGLContext.setCurrent(glkView.context)
        
        setupShaders()
        setupVertexBuffer()
    }
    
    // MARK: - GLKViewDelegate
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.2, 0.3, 0.3, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        baseEffect?.prepareToDraw()
        
        glEnableVertexAttribArray(GLuint(VertexAttributes.vertextAttribPosition.rawValue))
        
        glVertexAttribPointer(GLuint(VertexAttributes.vertextAttribPosition.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(3 * MemoryLayout<GLfloat>.size), UnsafePointer<Int>(bitPattern:0))
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        
        glDisableVertexAttribArray(GLuint(VertexAttributes.vertextAttribPosition.rawValue))
    }
    
    // MARK: - Private Methods
    
    private func setupVertexBuffer() {
        glGenFramebuffers(1, &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        
        glBufferData(GLenum(GL_ARRAY_BUFFER), vertices.count * MemoryLayout<GLfloat>.size , vertices, GLenum(GL_STATIC_DRAW))
    }
    
    private func setupShaders() {
        baseEffect = BaseEffect(vertexShader: "SimpleVertex.glsl", fragmentShader: "SimpleFragment.glsl")
    }
}

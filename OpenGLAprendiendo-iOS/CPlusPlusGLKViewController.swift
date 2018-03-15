import GLKit

class CPlusPlusGLKViewController: GLKViewController {
     // MARK: - GLKViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - GLKViewDelegate
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    
    // MARK: - Private Methods
    
    func setup() {
        let glkView = view as! GLKView
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES3)!
        
        EAGLContext.setCurrent(glkView.context)
        
        glClearColor(0.2, 0.3, 0.3, 1.0)
    }
}

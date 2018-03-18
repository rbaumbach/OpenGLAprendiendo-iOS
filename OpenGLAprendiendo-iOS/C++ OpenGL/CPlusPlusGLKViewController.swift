import GLKit

class CPlusPlusGLKViewController: GLKViewController {
    var triangleWrapper = TriangleWrapper()
        
     // MARK: - GLKViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - GLKViewDelegate
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        triangleWrapper.render()
    }
    
    // MARK: - Private Methods
    
    func setup() {
        let glkView = view as! GLKView
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES3)!
        
        EAGLContext.setCurrent(glkView.context)
        
        triangleWrapper.setupTriangle()
    }
}

import UIKit
import GLKit;

class DemoGLKViewController: GLKViewController {
    // MARK: - GLKViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let glkView = view as! GLKView
        
        glkView.context = EAGLContext(api: EAGLRenderingAPI.openGLES2)!
    }
    
    // MARK: - GLKViewDelegate
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.2, 0.3, 0.3, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
}

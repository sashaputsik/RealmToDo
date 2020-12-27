import Foundation
import UIKit

protocol BuilderProtocol {
    static func setMainModule()->UIViewController
    static func setAddedModule()->UIViewController
}

class Builder: BuilderProtocol{
    static func setAddedModule() -> UIViewController {
        let view = AddedViewController()
        
        return view
    }
    
    static func setMainModule() -> UIViewController {
        let view = MainViewController()
        
        return view
    }
    
    
}

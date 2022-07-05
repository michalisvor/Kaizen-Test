//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var id: String {
        return String(describing: self)
    }
    
    static func instatiate() -> Self {
        let id = String(describing: self)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id) as? Self
        
        guard let controller = vc else { fatalError("Controller didnt initiated as Self") }
        return controller
    }
    
    static func instance() -> UIViewController {
        let viewController = instatiate()
        if let mvpInstance = viewController as? SetUpType {
            mvpInstance.setUpMVP()
        }
        
        return viewController
    }
    
    static func instanceInNavController() -> (controller: UIViewController, navigationController: UINavigationController) {
        let viewController = self.instance()
        
        let navigationController = viewController.wrapInNavigationController()
        
        return (viewController, navigationController)
    }
    
    func wrapInNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}

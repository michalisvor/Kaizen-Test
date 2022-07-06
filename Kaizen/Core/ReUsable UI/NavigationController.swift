//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    var currentViewController: UIViewController? {
        return viewControllers.first
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationBar.tintColor = .white
        viewControllers.last?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        super.pushViewController(viewController, animated: true)
    }
}

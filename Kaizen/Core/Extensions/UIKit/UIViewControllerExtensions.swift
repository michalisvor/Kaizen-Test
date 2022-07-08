//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var id: String {
        return String(describing: self)
    }
    
    // MARK: Instatiate a controller or an navigation controller
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
    
    static func instanceInNavController() -> (controller: UIViewController, navigationController: NavigationController) {
        let viewController = self.instance()
        
        let navigationController = viewController.wrapInNavigationController()
        
        return (viewController, navigationController)
    }
    
    func wrapInNavigationController() -> NavigationController {
        return NavigationController(rootViewController: self)
    }
    
    // MARK: Show and Hide a simple loader
    func showLoader() {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .white
        indicator.center = view.center
        view.addSubview(indicator)
    }
    
    func hideLoader() {
        for view in view.subviews where view is UIActivityIndicatorView {
            view.removeFromSuperview()
        }
    }
    
    // MARK: Set up a custom title in navigation bar
    func prepareNavigationTitle(_ title: String? = nil, color: UIColor = .white) {
        guard let title = title else { navigationItem.titleView = nil ; return }
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        titleLabel.attributedText = title.style(fontName: .bold, x2FontSize: 19, color: color, alignment: .center)
        navigationItem.titleView = titleLabel
    }
}

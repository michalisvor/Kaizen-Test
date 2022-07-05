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
    func showLoadingView() {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .white
        indicator.center = view.center
        view.addSubview(indicator)
    }
    
    func hideLoadingView() {
        for view in view.subviews where view is UIActivityIndicatorView {
            view.removeFromSuperview()
        }
    }
    
    // MARK: Set up a custom title in navigation bar
    func prepareNavigationTitle(_ title: String? = nil, color: UIColor = .white) {
        guard let title = title else { navigationItem.titleView = nil ; return }
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        titleLabel.text = title
        titleLabel.textColor = color
        navigationItem.titleView = titleLabel
    }
}

extension UINavigationController {
    
    func setUpWithBlueBackgroundColor() {
        setNavigationBarAppearance(color: UIColor(hex: "1866CC"))
    }
    
    func setUpWhiteBackgroundColor() {
        setNavigationBarAppearance(color: .white)
    }
    
    func setNavigationBarAppearance(color: UIColor) {
        if #available(iOS 13.0, *) {
            let standardAppearance = setUpStandardAppearance(color: color)
            
            self.navigationBar.standardAppearance = standardAppearance
            self.navigationBar.scrollEdgeAppearance = standardAppearance
            self.navigationBar.compactAppearance = standardAppearance

            if #available(iOS 15.0, *) {
                self.navigationBar.compactScrollEdgeAppearance = standardAppearance
            }
        } else {
            self.navigationBar.backgroundColor = color
            self.navigationBar.barTintColor = color
            self.navigationBar.isTranslucent = false
        }
    }
    
    @available(iOS 13.0, *)
    private func setUpStandardAppearance(color: UIColor) -> UINavigationBarAppearance {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.backgroundColor = color
        standardAppearance.shadowColor = nil
        
        return standardAppearance
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r)/0xff, green: CGFloat(g)/0xff, blue: CGFloat(b)/0xff, alpha: 1)
    }
}

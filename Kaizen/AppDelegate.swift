//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setUpRootViewController()
        return true
    }
    
}

extension AppDelegate {
    
    private func setUpRootViewController() {
        let controller = SplashViewController.instanceInNavController()
        controller.navigationController.isNavigationBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = controller.navigationController
        window?.makeKeyAndVisible()
    }
}

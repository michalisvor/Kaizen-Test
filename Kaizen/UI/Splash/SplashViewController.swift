//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Just for testing - remove it later
        Thread.sleep(forTimeInterval: 2)
        let controller = DashboardViewController.instanceInNavController()
        self.navigationController?.pushViewController(controller.controller, animated: true)
    }

}
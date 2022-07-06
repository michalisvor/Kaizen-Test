//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Just for testing - remove it later
        Thread.sleep(forTimeInterval: 1)
        let controller = DashboardViewController.instanceInNavController()
        self.navigationController?.pushViewController(controller.controller, animated: true)
    }

    private func setUp() {
        
        // To zero padding between sections after ios 15
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
}

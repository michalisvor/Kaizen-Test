//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class DashboardViewControllerTests: XCTestCase {
    
    var dashboardController: DashboardViewController?
    
    override func setUp() {
        dashboardController = DashboardViewController.instance() as? DashboardViewController
    }
    
    override func tearDown() {
        dashboardController = nil
    }
}

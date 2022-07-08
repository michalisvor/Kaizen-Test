//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//
// swiftlint:disable all

import Foundation
import XCTest
@testable import Kaizen

class DashboardViewControllerTests: XCTestCase {
    
    var dashboardController: DashboardViewController?
    var timerDelegatesCount: Int = 0
    
    override func setUp() {
        timerDelegatesCount = KaizenTimer.shared.getDelegatesCount()
        dashboardController = DashboardViewController.instance() as? DashboardViewController
        dashboardController?.loadView()
        dashboardController?.viewDidLoad()
    }
    
    override func tearDown() {
        dashboardController = nil
    }
    
    func testSetUp() {
        let refreshControl = dashboardController?.refreshControl
        XCTAssertNotNil(refreshControl)
        
        let tableViewSubViews = dashboardController?.tableView.subviews ?? []
        XCTAssertTrue(tableViewSubViews.contains(refreshControl!))
        
        XCTAssertEqual(timerDelegatesCount, KaizenTimer.shared.getDelegatesCount() - 1)
    }
}

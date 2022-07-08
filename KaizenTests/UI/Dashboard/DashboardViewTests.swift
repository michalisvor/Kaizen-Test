//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import PromiseKit
import XCTest
@testable import Kaizen

class DashboardViewTests: UIViewController, DashboardViewType {
    var tableView: UITableView! = UITableView()
    var dataModel: IndexPathDataModel = IndexPathDataModel(sectionItems: [])
    var refreshControl: UIRefreshControl! = UIRefreshControl()
}

class DashboardViewTestsMock: XCTestCase {
    
    func createPresenter() -> DashboardPresenterTests {
        let presenter = DashboardPresenterTests()
        presenter.service = DashboardServiceTests()
        presenter.view = DashboardViewTests()
        
        presenter.view?.tableView = UITableView()
        return presenter
    }
    
    func testGetEventsSuccfully() {
        let presenter = createPresenter()
        presenter.getEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            XCTAssertEqual(presenter.sports.count, 8)
            XCTAssertEqual(presenter.view?.dataModel.sectionItems.count, 8)
        }
    }
    
    // TODO: Add Empty view
    func testGetEventsFailure() {
        let presenter = createPresenter()
        presenter.service.generatorError = true
        presenter.getEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            XCTAssertEqual(presenter.sports.count, 0)
            XCTAssertEqual(presenter.view?.dataModel.items().count, 0)
        }
    }
    
    func testGetEventsSuccfullyButEmpty() {
        let presenter = createPresenter()
        presenter.service.emptyResponse = true
        presenter.getEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            XCTAssertEqual(presenter.sports.count, 0)
            XCTAssertEqual(presenter.view?.dataModel.items().count, 0)
        }
    }
}

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
    
    var presenter: DashboardPresenterTests!
    
    override func setUp() {
        presenter = createPresenter()
    }
    
    func createPresenter() -> DashboardPresenterTests {
        let presenter = DashboardPresenterTests()
        presenter.service = DashboardServiceTests()
        presenter.view = DashboardViewTests()
        
        presenter.view?.tableView = UITableView()
        return presenter
    }
    
    func testGetEventsSuccfully() {
        let expectation = XCTestExpectation()
        presenter.getEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let sectionItems = self.presenter.view?.dataModel.sectionItems
            
            let child = sectionItems?[0].data as? APIResponseSport
            let child2 = sectionItems?[1].data as? APIResponseSport

            XCTAssertEqual(self.presenter.sports.count, 9)
            XCTAssertEqual(self.presenter.view?.dataModel.numberOfSections, 8)
            XCTAssertEqual(child?.events?.count, 5)
            XCTAssertEqual(child2?.events?.count, 26)
                           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
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

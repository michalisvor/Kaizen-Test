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
    func shouldEnableExpandAll(_ value: Bool) {}
}

class DashboardViewTestsMock: XCTestCase {
    
    var presenter: DashboardPresenterTests!
    
    override func setUp() {
        presenter = createPresenter()
    }
    
    override func tearDown() {
        presenter = nil
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let sectionItems = self.presenter.view?.dataModel.sectionItems
            
            let child = sectionItems?[0].data as? APIResponseSport
            let child2 = sectionItems?[1].data as? APIResponseSport

            XCTAssertEqual(self.presenter.sports.count, 9)
            XCTAssertEqual(self.presenter.view?.dataModel.numberOfSections, 8)
            XCTAssertEqual(child?.events?.count, 5)
            XCTAssertEqual(child2?.events?.count, 26)
                           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.4)
    }
    
    func testGetEventsFailure() {
        let expectation = XCTestExpectation()
        presenter.service.generatorError = true
        presenter.getEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            XCTAssertEqual(self.presenter.sports.count, 0)
            XCTAssertEqual(self.presenter.view?.dataModel.items().count, 1)
                           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.4)
    }
    
    func testGetEventsSuccfullyButEmpty() {
        let expectation = XCTestExpectation()
        presenter.service.emptyResponse = true
        presenter.getEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            XCTAssertEqual(self.presenter.sports.count, 0)
            XCTAssertEqual(self.presenter.view?.dataModel.items().count, 1)
                           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.4)
    }
}

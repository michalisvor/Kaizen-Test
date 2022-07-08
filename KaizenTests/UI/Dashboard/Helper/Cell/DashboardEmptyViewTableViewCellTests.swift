//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class DashboardEmptyViewTableViewCellTests: XCTestCase {
    
    var cellsController: CellsHelperController!
    var cell: DashboardEmptyViewTableViewCell!
    
    override func setUp() {
        cellsController = CellsHelperController()
        cellsController.cellIdentifier = DashboardEmptyViewTableViewCell.id
        cell = cellsController.getTableViewCell() as? DashboardEmptyViewTableViewCell
    }
    
    override func tearDown() {
        cellsController = nil
        cell = nil
    }
    
    func testSetUpWithHiddenButton() {
        let model = DashboardEmptyViewModel(title: "Test", isRefreshHidden: true)
        cell.setUp(with: model)
        
        XCTAssertEqual(cell.titleLabel.text, "Test")
        XCTAssertEqual(cell.refreshButton.isHidden, true)
    }
    
    func testSetUpWithNotHiddenButton() {
        let model = DashboardEmptyViewModel(title: "Test1", isRefreshHidden: false)
        cell.setUp(with: model)
        
        XCTAssertEqual(cell.titleLabel.text, "Test1")
        XCTAssertEqual(cell.refreshButton.isHidden, false)
    }
}

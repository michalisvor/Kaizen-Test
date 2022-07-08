//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class SportEventCollectionViewCellTests: XCTestCase {
    
    var cellsController: CellsHelperController!
    var cell: SportEventCollectionViewCell!
    var response: APIResponseSportEvent!
    
    override func setUp() {
        cellsController = CellsHelperController()
        cellsController.cellIdentifier = SportEventCollectionViewCell.id
        cell = cellsController.getCollectionViewCell() as? SportEventCollectionViewCell
        response = MockDecoder.decodeMock(APIResponseSportEvent.self, from: "sport_event") ?? APIResponseSportEvent()
    }
    
    override func tearDown() {
        cellsController = nil
        cell = nil
        response = nil
    }
    
    func testSetUp() {
        cell.setUp(with: response)
    }
    
    func testSetUpTimeLabelWithNoData() {
        cell.setUpTimeLabel()
    }
}

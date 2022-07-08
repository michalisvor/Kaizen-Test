//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class CollectionViewTableViewCellTests: XCTestCase {
    
    var cellsController: CellsHelperController!
    var cell: CollectionViewTableViewCell!
    
    override func setUp() {
        cellsController = CellsHelperController()
        cellsController.cellIdentifier = CollectionViewTableViewCell.id
        
        let event = APIResponseSportEvent()
        event.eventId = "24455722"
        
        CoreDataManager.shared.createFavoriteEvent(sportEvent: event)
        cell = cellsController.getTableViewCell() as? CollectionViewTableViewCell
    }
    
    override func tearDown() {
        cellsController = nil
        cell = nil
    }
    
    func testSetUp() {
        let mock = MockDecoder.decodeMock([APIResponseSport].self, from: "sports_success") ?? []
        cell.setUp(with: (mock.last?.events ?? []).compactMap({ $0 }))
        
        let items = cell.dataModel.items().count
        
        XCTAssertEqual(items, 3)
    }
}

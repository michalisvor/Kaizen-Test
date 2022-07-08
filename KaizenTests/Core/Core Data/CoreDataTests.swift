//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class CoreDataManagerTests: XCTestCase {
    
    var eventsCountBeforeAddingNew = 0
    
    func createFavorite() {
        let event = APIResponseSportEvent()
        event.eventId = "2"
        event.sportId = "3"
        
        CoreDataManager.shared.createFavoriteEvent(sportEvent: event)
    }
    
    func testCoreDataCreateFavorite() {
        
        let eventsCountBeforeAddingNew = CoreDataManager.shared.getFavoriteEvents().count
        createFavorite()
        
        let eventsCount = CoreDataManager.shared.getFavoriteEvents().count
        
        XCTAssertEqual(eventsCount, eventsCountBeforeAddingNew + 1)
    }
    
    func testCoreDataDeleteFavorite() {
        let expectation = XCTestExpectation()
        createFavorite()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.eventsCountBeforeAddingNew = CoreDataManager.shared.getFavoriteEvents().count
            CoreDataManager.shared.deleteFavoriteEvent(eventId: "2")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let eventsCount = CoreDataManager.shared.getFavoriteEvents().count
            XCTAssertEqual(eventsCount, self.eventsCountBeforeAddingNew - 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}

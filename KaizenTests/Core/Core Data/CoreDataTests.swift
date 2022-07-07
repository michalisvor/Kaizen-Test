//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class CoreDataManagerTests: XCTestCase {
    
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
        createFavorite()

        let eventsCountBeforeAddingNew = CoreDataManager.shared.getFavoriteEvents().count
        
        CoreDataManager.shared.deleteFavoriteEvent(eventId: "2")
        
        let eventsCount = CoreDataManager.shared.getFavoriteEvents().count
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(eventsCount, eventsCountBeforeAddingNew - 1)
        }
    }
}

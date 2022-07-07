//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class APIResponseSportsTests: XCTestCase {
    
    var sport: APIResponseSport!
    
    override func setUp() {
        sport = APIResponseSport()
    }
    
    override func tearDown() {
        sport = nil
    }
    
    func testFootballType() {
        sport.sportId = "FOOT"
        
        XCTAssertEqual(sport.sportType, .football)
    }
    
    func testFootballTypeIcon() {
        sport.sportId = "FOOT"
        
        let icon = sport.sportType?.iconName
        
        XCTAssertEqual(icon, "icon_foot")
    }
    
    func testEmptySportType() {
        sport.sportId = ""
                
        XCTAssertEqual(sport.sportType, nil)
    }
    
    func testNilSportType() {
        sport.sportId = nil
                
        XCTAssertEqual(sport.sportType, nil)
    }
    
    func testEmptySportTypeIcon() {
        sport.sportId = ""
              
        let icon = sport.sportType?.iconName

        XCTAssertEqual(icon, nil)
    }
}

class APIResponseSportEventTests: XCTestCase {
    
    var event: APIResponseSportEvent!
    
    override func setUp() {
        event = APIResponseSportEvent()
    }
    
    override func tearDown() {
        event = nil
    }
    
    func testNilEvent() {
        event.eventName = nil

        XCTAssertEqual(event.teams.teamHome, nil)
        XCTAssertEqual(event.teams.teamAway, nil)
    }
    
    func testNormalEvent() {
        event.eventName = "First - Second"

        XCTAssertEqual(event.teams.teamHome, "First")
        XCTAssertEqual(event.teams.teamAway, "Second")
    }
    
    func testWithoutDashEvent() {
        event.eventName = "First Second"

        XCTAssertEqual(event.teams.teamHome, "First Second")
        XCTAssertEqual(event.teams.teamAway, nil)
    }
    
    func testEmptyHomeEvent() {
        event.eventName = ""

        XCTAssertEqual(event.teams.teamHome, "")
        XCTAssertEqual(event.teams.teamAway, nil)
    }
    
    func testMoreThanTwoTeamsEvent() {
        event.eventName = "First - Second - Third"

        XCTAssertEqual(event.teams.teamHome, "First")
        XCTAssertEqual(event.teams.teamAway, "Second")
    }
}

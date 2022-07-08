//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class EventCategoryHeaderViewTests: XCTestCase {
    
    var headerView: EventCategoryHeaderView!
    
    override func setUp() {
        headerView = EventCategoryHeaderView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    }
    
    override func tearDown() {
        headerView = nil
    }
    
    func testHeaderView() {
        XCTAssertEqual(headerView.frame.height, 200)
        XCTAssertEqual(headerView.frame.width, 200)
    }
    
    func testHeaderViewSetUpOpened() {
        headerView.setUp(data: APIResponseSport(), isOpened: true)
        
        XCTAssertEqual(headerView.getArrowImage(), UIImage(named: "icon_arrow_up_white"))
    }
    
    func testHeaderViewSetUpNotOpened() {
        headerView.setUp(data: APIResponseSport(), isOpened: false)
        
        XCTAssertEqual(headerView.getArrowImage(), UIImage(named: "icon_arrow_down_white"))
    }
}

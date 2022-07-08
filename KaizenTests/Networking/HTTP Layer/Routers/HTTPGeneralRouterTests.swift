//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest

@testable import Kaizen

class HTTPGeneralRouterTests: XCTestCase {
    
    var helper: GeneralExtensionsForTesting!

    override func setUp() {
        helper = GeneralExtensionsForTesting()
    }
    
    override func tearDown() {
        helper = nil
    }
    
    func testHTTPRouterSports() {
        let router = HTTPGeneralRouter.getSports
        let urlString = "/api/sports"
        
        helper.testHTTPRouterString(router: router, testUrl: urlString)
    }
}

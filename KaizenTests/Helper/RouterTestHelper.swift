//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

public class GeneralExtensionsForTesting: XCTestCase {

    public func testHTTPRouterString(router: HTTPRouterType, testUrl: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(router.urlString, HTTPClient.shared.serverUrl + testUrl, file: file, line: line)
    }

}

//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import XCTest
@testable import Kaizen

class APIResponseMockTest: Codable {
    var testString: String?
    var testDouble: Double?
    var testInt: Int?
    var testBool: Bool?
}

class FoundationExtensionsTests: XCTestCase {
    
    // MARK: Encodable Extensions
    
    var codable: APIResponseMockTest!
    
    override func setUp() {
        codable = APIResponseMockTest()
    }
    
    override func tearDown() {
        codable = nil
    }
    
    func testStringJSONFormatted() {
        codable.testString = "something"

        let output = codable.toJsonFormmated()
        let testString = """
                        {
                          "testString" : "something"
                        }
                        """
        
        XCTAssertEqual(output, testString)
    }
    
    func testIntJSONFormatted() {
        codable.testInt = 1

        let output = codable.toJsonFormmated()
        let testString = """
                        {
                          "testInt" : 1
                        }
                        """

        XCTAssertEqual(output, testString)
    }

    func testDoubleJSONFormatted() {
        codable.testDouble = 1.2

        let output = codable.toJsonFormmated()
        let testString = """
                        {
                          "testDouble" : 1.2
                        }
                        """

        XCTAssertEqual(output, testString)
    }
    
    func testBooleanJSONFormatted() {
        codable.testBool = true

        let output = codable.toJsonFormmated()
        let testString = """
                        {
                          "testBool" : true
                        }
                        """

        XCTAssertEqual(output, testString)
    }
    
    func testEmptyJSONFormatted() {
        let output = codable.toJsonFormmated()
        let testString = """
                        {
                        
                        }
                        """
        XCTAssertEqual(output, testString)
    }
    
    func testNullJSONFormatted() {
        codable = nil
        let output = codable.toJsonFormmated()

        XCTAssertEqual(output, "null")
    }
}

//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//
// swiftlint:disable all
import Foundation
import PromiseKit
@testable import Kaizen

class DashboardServiceTests: DashboardService {
    var generatorError: Bool = false
    var emptyResponse: Bool = false
    
    override func getEvents() -> Promise<[APIResponseSport]> {
        switch generatorError {
        case true:
            let error = NSError(domain:"", code: 400, userInfo: [NSLocalizedDescriptionKey: "Server Mock Error"])
            return Promise(error: error)
        case false:
            let response = MockDecoder.decodeMock([APIResponseSport].self, from: emptyResponse ? "sports_empty" : "sports_success")!
            return Promise.value(response)
        }
    }
}

//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import PromiseKit
@testable import Kaizen

class DashboardPresenterTests: DashboardPresenterType {
    typealias ViewClass = DashboardViewTests
    typealias ServiceClass = DashboardServiceTests
    
    var sports: [APIResponseSport] = []
    
    var view: DashboardViewTests?
    var service: DashboardServiceTests!
    
    required init() {}
}

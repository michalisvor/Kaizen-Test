//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import Foundation
import PromiseKit

protocol DashboardServiceType: ServiceType {
    func getEvents() -> Promise<[APIResponseSport]>
}

class DashboardService: DashboardServiceType {
    
    required init() {}
    
    func getEvents() -> Promise<[APIResponseSport]> {
        return HTTPClient.shared.getSports()
    }
}

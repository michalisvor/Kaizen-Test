//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import UIKit

protocol DashboardPresenterType: PresenterType {

}

extension DashboardPresenterType where ViewClass: DashboardViewType, ServiceClass: DashboardServiceType {
    
}

class DashboardPresenter: DashboardPresenterType {
    
    typealias ViewClass = DashboardViewController
    typealias ServiceClass = DashboardService
    
    weak var view: DashboardViewController?
    var service: DashboardService!
    
    required init() {}
}

//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import UIKit

protocol DashboardPresenterType: PresenterType {

}

extension DashboardPresenterType where ViewClass: DashboardViewType, ServiceClass: DashboardServiceType {
    
    func getEvents() {
        self.view?.showLoadingView()
        
        service.getEvents().done { response in
            self.view?.createDataModel(with: response)
        }.ensure {
            self.view?.hideLoadingView()
        }.catch { error in
            print(error)
        }
    }
}

class DashboardPresenter: DashboardPresenterType {
    
    typealias ViewClass = DashboardViewController
    typealias ServiceClass = DashboardService
    
    weak var view: DashboardViewController?
    var service: DashboardService!
    
    required init() {}
}

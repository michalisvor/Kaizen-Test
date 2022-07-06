//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

// MARK: Controller Set Up.
public protocol ControllerType: SetUpType {
    associatedtype PresenterClass: PresenterType
    var presenter: PresenterClass! { get set }
}

// MARK: View Set Up.
public protocol ViewType where Self: UIViewController { }

// MARK: Service Set Up.
public protocol ServiceType: AnyObject {
    init()
}

// MARK: Presenter Set Up.
public protocol PresenterType: AnyObject {
    associatedtype ViewClass: ViewType
    associatedtype ServiceClass: ServiceType
    
    var view: ViewClass? { get set }
    var service: ServiceClass! { get set }
    
    init()
}

extension PresenterType {
    init() {
        self.init()
    }
}

public protocol SetUpType: AnyObject {
    func setUpMVP()
}

// MARK: Controller extension
extension ControllerType where Self: UIViewController {
    
    func setUpMVP() {
        let service = PresenterClass.ServiceClass()
        self.presenter = PresenterClass()
        self.presenter.service = service
        
        if let view = self as? PresenterClass.ViewClass {
            self.presenter.view = view
        }
    }
}

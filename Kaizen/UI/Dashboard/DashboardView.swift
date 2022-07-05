//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import UIKit

protocol DashboardViewType: ViewType {
    var tableView: UITableView! { get set }
    var dataModel: IndexPathDataModel { get set }
}

extension DashboardViewType {

}

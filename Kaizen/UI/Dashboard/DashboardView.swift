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

    func createDataModel(with sports: [APIResponseSport]) {
        var items: [IndexPathSectionItem] = []
        
        for sport in sports {
            let headerItem = IndexPathSectionItem(identifier: "\(items.count)", rowHeight: 40, data: sport, children: [])
            items.append(headerItem)
        }
        
        dataModel = IndexPathDataModel(sectionItems: items)
        tableView.registerAll(from: dataModel)
        tableView.reloadData()
    }
}

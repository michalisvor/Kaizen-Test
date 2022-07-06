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
            let events = sport.events?.compactMap({ $0 }) ?? []
            
            guard events.count > 0 else { continue } // Check if there are event so we dont show an empty collection
            let child = IndexPathItem(cellIdentifier: "\(items.count)", nibName: CollectionViewTableViewCell.id, data: events)
            let headerItem = IndexPathSectionItem(identifier: "\(items.count)", rowHeight: 45, data: sport, children: [child])
            items.append(headerItem)
        }
        
        dataModel = IndexPathDataModel(sectionItems: items)
        tableView.registerAll(from: dataModel)
        tableView.reloadData()
    }
}

//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

struct IndexPathCellProperties {
    var id: String
    var nibName: String
}

extension UITableView {
    
    func registerAll(from dataModel: IndexPathDataModel) {
        var uniqueIds: [IndexPathCellProperties] = registeredNibs
        for section in dataModel.sectionItems {
            for item in section.children where uniqueIds.filter({ $0.id == item.cellIdentifier }).count == 0 {
                uniqueIds.append(IndexPathCellProperties(id: item.cellIdentifier, nibName: item.nibName))
            }
        }
        register(with: uniqueIds)
    }
    
    func register(with model: [IndexPathCellProperties]) {
        for item in model {
            register(UINib(nibName: item.nibName, bundle: nil), forCellReuseIdentifier: item.id)
        }
    }
    
    private var registeredNibs: [IndexPathCellProperties] {
        /// `_nibMap` finds every registered cell in tableView
        guard let nibDictionary = value(forKey: "_nibMap") as? [String: UINib] else { return [] }
        var nibModelArray: [IndexPathCellProperties] = []
        
        /// By patern I chose to use TableViewCell as a suffix for every cell if cellIdentifier doesn't contains TableViewCell then
        /// there are 2 possible scenarios
        /// 1. We put unique identifiers (better for textfields)
        /// 2. Maybe someone used wrong suffix
        /// Either way there isn't a problem to register 2 or more times a cell
        for key in nibDictionary.keys where key.contains("TableViewCell") {
            nibModelArray.append(IndexPathCellProperties(id: key, nibName: key))
        }
        return nibModelArray
    }
}

extension UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }
}

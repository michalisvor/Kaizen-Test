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
        guard let nibDictionary = value(forKey: "_nibMap") as? [String: UINib] else { return [] }
        var nibModelArray: [IndexPathCellProperties] = []
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

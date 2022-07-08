//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerAll(from dataModel: IndexPathDataModel) {
        var uniqueIds: [IndexPathCellProperties] = []
        for section in dataModel.sectionItems {
            for item in section.children where (uniqueIds.filter { $0.id == item.cellIdentifier }).count == 0 {
                uniqueIds.append(IndexPathCellProperties(id: item.cellIdentifier, nibName: item.nibName))
            }
        }
        register(with: uniqueIds)
    }
    
    func register(with model: [IndexPathCellProperties]) {
        for item in model {
            register(UINib(nibName: item.nibName, bundle: nil), forCellWithReuseIdentifier: item.id)
        }
    }
}

extension UICollectionViewCell {
    
    static var id: String {
        return String(describing: self)
    }
}

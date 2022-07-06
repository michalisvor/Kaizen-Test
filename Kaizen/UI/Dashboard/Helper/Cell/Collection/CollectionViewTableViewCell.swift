//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var dataModel: IndexPathDataModel = IndexPathDataModel(items: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setUp(with sportEvents: [APIResponseSportEvent]) {
        var items: [IndexPathItem] = []
        
        for sportEvent in sportEvents {
            items.append(IndexPathItem(cellIdentifier: SportEventCollectionViewCell.id, data: sportEvent))
        }
        
        dataModel = IndexPathDataModel(items: items)
        collectionView.registerAll(from: dataModel)
        collectionView.reloadData()
    }
}

extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.numberOfRows(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = dataModel.item(at: indexPath) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier, for: indexPath)
        
        switch (cell, item.data) {
        case (let cell as SportEventCollectionViewCell, let data as APIResponseSportEvent):
            cell.setUp(with: data)
        default:
            break
        }
        
        return cell
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Height is calculated by the top and bottom of the cardView in SportEventCollectionViewCell and its height (its set in this class xib)
        return CGSize(width: 175, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

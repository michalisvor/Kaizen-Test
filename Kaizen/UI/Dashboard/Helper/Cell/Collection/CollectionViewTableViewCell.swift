//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var dataModel: IndexPathDataModel = IndexPathDataModel(items: [])
    
    private var events: [APIResponseSportEvent] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    private func setUp() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func setUp(with sportEvents: [APIResponseSportEvent]) {
        events = sportEvents
        var items: [IndexPathItem] = []
        
        for sportEvent in sportEvents {
            items.append(IndexPathItem(cellIdentifier: SportEventCollectionViewCell.id, data: sportEvent))
        }
        
        items.sort { ($0.data as? APIResponseSportEvent)?.isFavorite == true && ($1.data as? APIResponseSportEvent)?.isFavorite == false }
        
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
            cell.delegate = self
        default:
            break
        }
        
        return cell
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Height is calculated by the top and bottom of the cardView in SportEventCollectionViewCell and its height (its set in this class xib)
        return CGSize(width: 150, height: collectionView.bounds.height)
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

extension CollectionViewTableViewCell: SportEventCollectionViewCellDelegate {
    
    func didChangeEvent(id: String) {
        setUp(with: events)
    }
}

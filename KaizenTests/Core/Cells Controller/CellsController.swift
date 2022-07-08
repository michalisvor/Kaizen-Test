//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class CellsHelperController: UIViewController {
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    
    var cellIdentifier: String!
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000), style: .plain)
        
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: cellIdentifier)
        
        tableView.dataSource = self
    }
    
    func setUpCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000), collectionViewLayout: UICollectionViewLayout())
        
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.dataSource = self
    }
    
    func getTableViewCell<T: UITableViewCell>(indexPath: IndexPath = IndexPath(row: 0, section: 0)) -> T? {
        setUpTableView()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? T
        
        return cell
    }
    
    func getCollectionViewCell<T: UICollectionViewCell>(indexPath: IndexPath = IndexPath(row: 0, section: 0)) -> T? {
        setUpCollectionView()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? T
        
        return cell
    }
}

extension CellsHelperController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
}

extension CellsHelperController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
}

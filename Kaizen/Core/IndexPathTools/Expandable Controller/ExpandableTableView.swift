//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class ExpandableTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataModel: IndexPathDataModel = IndexPathDataModel(sectionItems: [])
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didSelect(section: Int) {
        dataModel.section(atSectionIndex: section).isOpened.toggle()
        
        let sections = IndexSet(integer: section)
        tableView.reloadSections(sections, with: .none)
    }
}

extension ExpandableTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.numberOfSections
    }

    /// If section is `opened` then we want to reload section with all its children.
    /// If section is `NOT opened` then don't want any cells so we returning 0 children and we get the expandable functionality.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataModel.section(atSectionIndex: section).isOpened {
            return dataModel.numberOfRows(inSection: section)
        } else {
            return 0
        }
    }
}

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
        if dataModel.section(atSectionIndex: section).isOpened {
            dataModel.section(atSectionIndex: section).isOpened = false
            let sections = IndexSet(integer: section)
            tableView.reloadSections(sections, with: .none)
        } else {
            dataModel.section(atSectionIndex: section).isOpened = true
            let sections = IndexSet(integer: section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}

extension ExpandableTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataModel.section(atSectionIndex: section).isOpened {
            return dataModel.numberOfRows(inSection: section)
        } else {
            return 0
        }
    }
}

//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, ControllerType {
    
    typealias PresenterClass = DashboardPresenter
    var presenter: DashboardPresenter!
    
    @IBOutlet public weak var tableView: UITableView!
    
    public var dataModel: IndexPathDataModel = IndexPathDataModel(items: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.getEvents()
    }
   
    private func setUp() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.setUpWithBlueBackgroundColor()
        prepareNavigationTitle("Stoiximan")
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let indexPathItem = dataModel.item(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: indexPathItem.cellIdentifier) else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = dataModel.section(atSectionIndex: section).data as? APIResponseSport else { return nil }
        let headerView = EventCategoryHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.sectionHeaderHeight))
        headerView.setUp(title: data.sportName)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Add a safety guard to prevent wrong height if something may change in the future and data isnt APIResponseSport type
        // In viewForHeaderInSection we check for APIResponseSport type or returning nil so the height must be 0.
        guard dataModel.section(atSectionIndex: section).data as? APIResponseSport != nil else { return 0 }
        return dataModel.section(atSectionIndex: section).rowHeight
    }
}

extension DashboardViewController: DashboardViewType {
    
}

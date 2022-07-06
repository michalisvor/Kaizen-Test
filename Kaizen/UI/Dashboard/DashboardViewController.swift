//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import UIKit

class DashboardViewController: ExpandableTableViewController, ControllerType {
    
    typealias PresenterClass = DashboardPresenter
    var presenter: DashboardPresenter!
        
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
    
    @objc private func sectionTapped(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        didSelect(section: section)
    }
}

extension DashboardViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = dataModel.item(at: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier) else { return UITableViewCell() }
        
        switch (cell, item.data) {
        case (let cell as CollectionViewTableViewCell, let data as [APIResponseSportEvent]):
            cell.setUp(with: data)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = dataModel.section(atSectionIndex: section).data as? APIResponseSport else { return nil }
        
        let headerView = EventCategoryHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        headerView.setUp(title: data.sportName, isOpened: dataModel.section(atSectionIndex: section).isOpened)
        
        // If we want more buttons on the section or to just tap on the arrow to expand/collapse the section
        // we can uncomment the below line of code to have the delegate functionality
        // headerView.delegate = self
        
        // I will hold section index to tag property of the headerView so I can use it later on tap.
        headerView.tag = section
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionTapped))
        headerView.addGestureRecognizer(tapGesture)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Add a safety guard to prevent wrong height if something may change in the future and data isnt APIResponseSport type
        // In viewForHeaderInSection we check for APIResponseSport type or returning nil so the height must be 0.
        guard dataModel.section(atSectionIndex: section).data as? APIResponseSport != nil else { return 0 }
        return dataModel.section(atSectionIndex: section).rowHeight
    }
}

extension DashboardViewController: EventCategoryHeaderViewDelegate {

    func didTapOnArrow(in section: Int) {
        didSelect(section: section)
    }
}

extension DashboardViewController: DashboardViewType {
    
}

//
//  Copyright © 2019 vorisis
//  All rights reserved.
//

import UIKit

class DashboardViewController: ExpandableTableViewController, ControllerType {
    
    typealias PresenterClass = DashboardPresenter
    var presenter: DashboardPresenter!
        
    var refreshControl: UIRefreshControl! = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.getEvents()
    }
   
    func setUp() {
        KaizenTimer.shared.addDelegate(self)
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        navigationController?.setUpWithBlueBackgroundColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem.imageItem(imageName: "icon_expand", target: self, action: #selector(expandAllTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        prepareNavigationTitle("Stoiximan")
        setupPullToRefresh()
    }
    
    private func setupPullToRefresh() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshControllePulled), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshControllePulled(_ sender: UIRefreshControl) {
        presenter.getEvents()
    }
    
    /// Check if every section is expanded then call createDataModel with `shouldOpenAllSections` false to collapse them.
    /// If even one section is collapsed I firstly expand them all and only if every section is expanded I collapse them.
    @objc private func expandAllTapped() {
        guard dataModel.sectionItems.count > 0 else { return }
        let areAllSectionsExpanded = dataModel.sectionItems.filter({ $0.isOpened }).count == dataModel.numberOfSections
        createDataModel(with: presenter.sports, shouldOpenAllSections: !areAllSectionsExpanded)
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
        case (let cell as DashboardEmptyViewTableViewCell, let data as DashboardEmptyViewModel):
            cell.setUp(with: data)
            cell.delegate = self
        default:
            break
        }
        
        return cell
    }
    
    // If the user scroll too fast visibleCells can't keep up with scrolling and ends up with misleading time
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewTableViewCell else { return }
        cell.updateTimers()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = dataModel.section(atSectionIndex: section).data as? APIResponseSport else { return nil }
        
        let headerView = EventCategoryHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        headerView.setUp(data: data, isOpened: dataModel.section(atSectionIndex: section).isOpened)
        
        // If we want more buttons on the section or to just tap on the arrow to expand/collapse the section
        // we can uncomment the below line of code to have the delegate functionality (see comments in the EventCategoryHeaderView setUp)
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

extension DashboardViewController: DashboardEmptyViewTableViewCellDelegate {
    
    func didTapOnRefresh() {
        reload([])
        presenter.getEvents()
    }
}

extension DashboardViewController: EventCategoryHeaderViewDelegate {

    func didTapOnArrow(in section: Int) {
        didSelect(section: section)
    }
}

extension DashboardViewController: KaizenTimerDelegate {
    
    /// Finds all visible cells to update the timer and avoid delegates to every cell that has a timing label
    func didUpdateTimer() {
        let visibleCells = tableView.visibleCells
        
        for visibleCell in visibleCells {
            guard let cell = visibleCell as? CollectionViewTableViewCell else { continue }
            cell.updateTimers()
        }
    }
}

extension DashboardViewController: DashboardViewType {
    
    func shouldEnableExpandAll(_ value: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = value
    }
}

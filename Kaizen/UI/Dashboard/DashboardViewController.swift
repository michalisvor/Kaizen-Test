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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension DashboardViewController: DashboardViewType {
    
}

//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

struct DashboardEmptyViewModel {
    var title: String
    var isRefreshHidden: Bool
}

protocol DashboardEmptyViewTableViewCellDelegate: AnyObject {
    func didTapOnRefresh()
}

class DashboardEmptyViewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    weak var delegate: DashboardEmptyViewTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        refreshButton.layer.cornerRadius = 8
    }
    
    func setUp(with data: DashboardEmptyViewModel) {
        titleLabel.attributedText = data.title.style(fontName: .regular, x2FontSize: 17, color: .white, alignment: .center)
        refreshButton.setAttributedTitle("Ανανέωση".style(fontName: .bold, x2FontSize: 17, color: .black, alignment: .center), for: .normal)
        refreshButton.isHidden = data.isRefreshHidden
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        delegate?.didTapOnRefresh()
    }
}

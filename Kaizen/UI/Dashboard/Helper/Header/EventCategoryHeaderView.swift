//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

protocol EventCategoryHeaderViewDelegate: AnyObject {
    func didTapOnArrow(in section: Int)
}

class EventCategoryHeaderView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var sportImageContainerView: UIView!
    @IBOutlet private weak var sportImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    
    weak var delegate: EventCategoryHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }
    
    private func loadNib() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func setUp(data: APIResponseSport, isOpened: Bool) {
        sportImageView.image = UIImage(named: data.sportType?.iconName ?? "")
        sportImageContainerView.isHidden = data.sportType?.iconName == nil
        
        titleLabel.attributedText = data.sportName?.style(fontName: .regular, x2FontSize: 17, color: .white)
        arrowImageView.image = isOpened ? UIImage(named: "icon_arrow_up_white") : UIImage(named: "icon_arrow_down_white")
        // To enable arrow tap for expandable uncomment bellow line
        // arrowImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(arrowImageTapped)))
    }
    
    @objc private func arrowImageTapped() {
        delegate?.didTapOnArrow(in: self.tag)
    }
}

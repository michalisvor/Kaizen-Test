//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

private enum ArrowState {
    case up
    case down
}

protocol EventCategoryHeaderViewDelegate: AnyObject {
    func didTapOnArrow(in section: Int)
}

class EventCategoryHeaderView: UIView {

    @IBOutlet private var contentView: UIView!
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

    func setUp(title: String?, isOpened: Bool) {
        titleLabel.text = title
        arrowImageView.image = isOpened ? UIImage(named: "icon_arrow_up_white") : UIImage(named: "icon_arrow_down_white")
        arrowImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(arrowImageTapped)))
    }
    
    private func animateArrow(to state: ArrowState) {
        UIView.animate(withDuration: 0.4) {
            self.arrowImageView.transform = state == .down ? CGAffineTransform(rotationAngle: .pi) : .identity
        }
    }
    
    @objc private func arrowImageTapped() {
        delegate?.didTapOnArrow(in: self.tag)
    }
}

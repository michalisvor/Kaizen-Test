//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    static func imageItem(imageName: String, target: Any?, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .white

        let item = UIBarButtonItem(customView: button)
        item.customView?.translatesAutoresizingMaskIntoConstraints = false
        item.customView?.heightAnchor.constraint(equalToConstant: 16).isActive = true
        item.customView?.widthAnchor.constraint(equalToConstant: 16).isActive = true

        return item
    }
}

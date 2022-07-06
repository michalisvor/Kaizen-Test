//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import UIKit

enum Font: String {
    
    case regular = "Helvetica-Regular"
    case bold = "Helvetica-Bold"
    
    func toFont(with x2FontSize: CGFloat = 17) -> UIFont {
        var size: CGFloat = 0
        
        switch Device.model {
        case .iPhoneSE:
            size = x2FontSize * 0.8
        default:
            size = x2FontSize
        }
        return UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

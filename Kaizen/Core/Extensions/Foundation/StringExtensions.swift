//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func style(fontName: Font = .regular,
               x2FontSize: CGFloat = 17,
               color: UIColor = .white,
               colorAlpha: CGFloat = 1,
               alignment: NSTextAlignment = .left,
               lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> NSAttributedString {
        
        let font = fontName.toFont(with: x2FontSize)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue): paragraphStyle,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color.withAlphaComponent(colorAlpha),
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font]
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: self.count))
        
        return attributedString
    }
}

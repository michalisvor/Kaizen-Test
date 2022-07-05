//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func setUpWithBlueBackgroundColor() {
        setNavigationBarAppearance(color: UIColor(hex: "1866CC"))
    }
    
    func setUpWhiteBackgroundColor() {
        setNavigationBarAppearance(color: .white)
    }
    
    func setNavigationBarAppearance(color: UIColor) {
        if #available(iOS 13.0, *) {
            let standardAppearance = setUpStandardAppearance(color: color)
            
            self.navigationBar.standardAppearance = standardAppearance
            self.navigationBar.scrollEdgeAppearance = standardAppearance
            self.navigationBar.compactAppearance = standardAppearance

            if #available(iOS 15.0, *) {
                self.navigationBar.compactScrollEdgeAppearance = standardAppearance
            }
        } else {
            self.navigationBar.backgroundColor = color
            self.navigationBar.barTintColor = color
            self.navigationBar.isTranslucent = false
        }
    }
    
    @available(iOS 13.0, *)
    private func setUpStandardAppearance(color: UIColor) -> UINavigationBarAppearance {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.backgroundColor = color
        standardAppearance.shadowColor = nil
        
        return standardAppearance
    }
}

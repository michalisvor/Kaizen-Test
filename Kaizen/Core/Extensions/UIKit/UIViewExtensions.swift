//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Takes a UIView and make an effect of tapping 
    /// - Parameter completion: Use the completion to do the job you want after the animation finishes
    func pop(completion: @escaping () -> Void = {}) {
        let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut, animations: {
            self.transform = transform
        })
        
        animator.addCompletion { _ in
            let animator = UIViewPropertyAnimator(duration: 0.15, curve: .easeInOut, animations: {
                self.transform = CGAffineTransform.identity
            })
            
            animator.addCompletion { _ in
                completion()
            }
            
            animator.startAnimation()
        }
        
        animator.startAnimation()
    }
}

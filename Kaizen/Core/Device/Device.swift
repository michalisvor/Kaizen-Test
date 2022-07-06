//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import UIKit

class Device: NSObject {
    
    public enum DeviceModel {
        case iPhoneSE
        case iPhoneGeneric
        case iPad
    }
    
    public static var model: DeviceModel {
        let bounds = UIApplication.shared.keyWindow?.bounds ?? CGRect.zero
        
        if UIDevice.current.userInterfaceIdiom == .pad { return .iPad }
        if bounds.height == 568 { return .iPhoneSE }
        
        return .iPhoneGeneric
    }
}

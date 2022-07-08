//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import UIKit

enum SportType: String {
    case football = "FOOT"
    case basket = "BASK"
    case tennis = "TENN"
    case tableTennis = "TABL"
    case volley = "VOLL"
    case esports = "ESPS"
    case iceHockey = "ICEH"
    case beachVolley = "BCHV"
    case badminton = "BADM"
    
    /// I named all icons with prefix `icon_` and the rawValue lowercased so I dont have to switch all cases.
    var iconName: String? {
        return "icon_\(rawValue.lowercased())"
    }
}

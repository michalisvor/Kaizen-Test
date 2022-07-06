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
    
    var icon: UIImage? {
        return UIImage(named: "icon_\(rawValue.lowercased())")
    }
}

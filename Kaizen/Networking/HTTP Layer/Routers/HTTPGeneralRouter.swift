//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation

enum HTTPGeneralRouter: HTTPRouterType {
    
    case getSports
    
    var urlString: String {
        
        switch self {
        case .getSports:
            return HTTPClient.shared.serverUrl + "/api/sports"
        }
    }
}

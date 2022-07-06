//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import PromiseKit

extension HTTPClient {
    
    func getSports() -> Promise<[APIResponseSport]> {
        return apiRequestArray(method: .get, urlString: HTTPGeneralRouter.getSports)
    }
}

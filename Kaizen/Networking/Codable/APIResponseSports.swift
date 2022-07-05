//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation

class APIResponseSport: Codable {
    var sportId: String?
    var sportName: String?
    var events: [APIResponseSportEvent?]?
    
    enum CodingKeys: String, CodingKey {
        case sportId = "i"
        case sportName = "d"
        case events = "e"
    }
}

class APIResponseSportEvent: Codable {
    var eventId: String?
    var sportId: String?
    var eventName: String?
    var eventStartTime: TimeInterval?
    
    enum CodingKeys: String, CodingKey {
        case eventId = "i"
        case sportId = "si"
        case eventName = "d"
        case eventStartTime = "tt"
    }
}

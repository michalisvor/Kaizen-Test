//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation

class APIResponseSport: Codable {
    var sportId: String?
    var sportName: String?
    var events: [APIResponseSportEvent?]?
    
    var sportType: SportType? {
        return SportType(rawValue: sportId ?? "")
    }
    
    /// Use CodingKeys to parse response with custom variable names
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
    
    // Computed Properties
    var isFavorite: Bool = false
    
    /// Returns a tuple of the 2 first teams that finds in `eventName` that they are seperated by dash
    var teams: (teamHome: String?, teamAway: String?) {
        guard let eventName = eventName else { return (nil, nil) }
        let components = eventName.components(separatedBy: " - ")
        let teamHome = components.first
        var teamAway: String?
        
        if components.count > 1 {
            teamAway = components[1]
        }
        
        return (teamHome, teamAway)
    }
    
    /// Use CodingKeys to parse response with custom variable names
    enum CodingKeys: String, CodingKey {
        case eventId = "i"
        case sportId = "si"
        case eventName = "d"
        case eventStartTime = "tt"
    }
}

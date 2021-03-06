//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation

extension Encodable {
    
    /// Takes a Codable and convert it to beautify string with a format of json
    func toJsonFormmated() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self), let output = String(data: data, encoding: .utf8) else {
            return "Error converting \(self) to JSON string"
        }
        return output
    }
}

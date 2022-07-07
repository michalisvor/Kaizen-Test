//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation

struct MockDecoder {
    static func decodeMock<T: Decodable>(_ type: T.Type, from resource: String, ofType resourceType: String = "json") -> T? {
        guard let path = Bundle.main.path(forResource: resource, ofType: resourceType) else { fatalError() }
        
        var model: T?
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            
            let decoder = JSONDecoder()
            model = try decoder.decode(T.self, from: data)
            
        } catch let error {
            print("\nTesting Error: \(error.localizedDescription)\n")
        }
        
        return model
    }
    
}

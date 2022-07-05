//
//  Created by Michalis Vorisis.
//  Copyright © 2022 Michalis Vorisis. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

protocol HTTPRouterType {
    var urlString: String { get }
}

class HTTPClient {
    static let shared = HTTPClient()
    
    let serverUrl = "https://618d3aa7fe09aa001744060a.mockapi.io"
    
}

extension HTTPClient {
    
    func apiRequest<T: Codable>(method: HTTPMethod = .get, urlString: HTTPRouterType, parameters: [String: Any] = [:]) -> Promise<T> {
        
        return Promise(resolver: { resolver in
            AF.request(urlString.urlString, method: method, parameters: parameters).responseData { response in

                print(("Status " + String(response.response?.statusCode ?? 0) + " URL: " + (response.request?.url?.absoluteString ?? "")))
                
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let response: T = try decoder.decode(T.self, from: data)
                        print(response.toJsonFormmated())
                        resolver.fulfill(response)
                    } catch {
                        resolver.reject(error)
                    }
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        })
        
    }
    
    func apiRequestArray<T: Codable>(method: HTTPMethod = .get, urlString: HTTPRouterType, parameters: [String: Any] = [:]) -> Promise<[T]> {
        
        return Promise(resolver: { (aResolver) in
            AF.request(urlString.urlString, method: method, parameters: parameters).responseData { response in
                
                print(("Status " + String(response.response?.statusCode ?? 0) + " URL: " + (response.request?.url?.absoluteString ?? "")))

                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let response: [T] = try decoder.decode([T].self, from: data)
                        print(response.toJsonFormmated())
                        aResolver.fulfill(response)
                    } catch {
                        aResolver.reject(error)
                    }
                case .failure(let error):
                    aResolver.reject(error)
                }
            }
        })
    }
    
}

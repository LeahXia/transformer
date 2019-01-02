//
//  NetworkRequestInfo.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

/// Create url or urlRequest for Alamofire
struct NetworkRequestInfo {
    
    // MARK: Variables
    let baseUrl = "https://transformers-api.firebaseapp.com/"
    var url: URL?
    var urlRequest: URLRequest?
    
    // MARK: Initialization
    /// Convenient init for EndPoint .token or .transformers (GET), Return url to feed Alamofire
    init(endPoint: EndPoint) {
        self.init(endPoint: endPoint, httpMethod: .get, transformerId: nil)
    }
    
    init(endPoint: EndPoint, httpMethod: HTTPMethod, transformerId: String?) {
        switch endPoint {
        case .token:
            self.url = setUrl(endPoint: endPoint)
            break
        case .transformers:
            self.urlRequest = setUrlRequest(endPoint: endPoint, httpMethod: httpMethod, transformerId: nil)
            break
        case .deleteTransformer:
            self.urlRequest = setUrlRequest(endPoint: endPoint, httpMethod: httpMethod, transformerId: transformerId)
            break
        }
        
    }
    
    // MARK: - Helper
    func setUrl(endPoint: EndPoint) -> URL? {
        let url = baseUrl + endPoint.rawValue
        return URL(string: url)
    }
    
    func setUrlRequest(endPoint: EndPoint, httpMethod: HTTPMethod, transformerId: String?) -> URLRequest? {
        
        let urlStr = baseUrl + endPoint.rawValue + (transformerId ?? "")
        
        // Set header
        guard endPoint != .token,
            let accessToken = KeychainWrapper.standard.string(forKey: "accessToken"),
            let url = URL(string: urlStr) else {
                return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Set httpMethod
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
}

//
//  NetworkRequestInfo.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation
import Alamofire

/// Create url or urlRequest for Alamofire
struct NetworkRequestInfo {
    
    // MARK: Variables
    let baseUrl = "https://transformers-api.firebaseapp.com/"
    var url: String?
    var headers: HTTPHeaders?
    var parameters: Parameters?
    
    // MARK: Initialization
    /// Convenient init for EndPoint .token or .transformers (GET), Return url to feed Alamofire
    init(endPoint: EndPoint, token: String = "") {
        self.init(endPoint: endPoint, token: token, httpMethod: .get, transformerId: nil, transformer: nil)
    }
    
    init(endPoint: EndPoint, token: String, httpMethod: HTTPMethod, transformerId: String?, transformer: Transformer?) {
        switch endPoint {
        case .token:
            setUrl(endPoint: endPoint, transformerId: nil)
            break
        case .transformers:
            setUrlRequest(endPoint: endPoint, token: token, httpMethod: httpMethod, transformerId: nil, transformer: transformer)
            break
        case .deleteTransformer:
            setUrlRequest(endPoint: endPoint, token: token, httpMethod: httpMethod, transformerId: transformerId, transformer: nil)
            break
        }
        
    }
    
    mutating func setUrlRequest(endPoint: EndPoint, token: String, httpMethod: HTTPMethod, transformerId: String?, transformer: Transformer?) {
        
        setUrl(endPoint: endPoint, transformerId: transformerId)
        
        // Set header
        guard endPoint != .token else { return}
        
        self.headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]
        
        self.parameters = transformer?.getHttpParameters()
        
    }
    
    // MARK: - Helper
    mutating func setUrl(endPoint: EndPoint, transformerId: String?) {
        self.url = baseUrl + endPoint.rawValue + (transformerId ?? "")
    }
}

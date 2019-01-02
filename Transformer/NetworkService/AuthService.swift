//
//  AuthService.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation
import Alamofire

/// Handle Authorization for server
class AuthService: NSObject {

    // MARK: - Token
    func getAccessToken(completion: @escaping TokenCompletionHandler) {
        
        guard let url = NetworkRequestInfo(endPoint: .token).url else {
                completion("Auth url is not valid. Please contact our support team.", nil)
                return
        }
      
        Alamofire.request(url)
            .validate()
            .responseString { (response) in
                
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        let errorMessage = "Auth Error due to: \(response.result.error?.localizedDescription ?? ""). Please contact our support team."
                        completion(errorMessage, nil)
                        return
                }
                
                completion(nil, value)
        }
    }
}



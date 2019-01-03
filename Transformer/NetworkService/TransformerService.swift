//
//  AuthService.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import Foundation
import Alamofire

/// Handle GET POST PUT DELETE API calls
final class TransformerService: NSObject {
    
    // MARK: - GET
    func fetchAllTransformers(token: String, completion: @escaping TransformersCompletionHandler) {
        
        guard let urlRequest = NetworkRequestInfo(endPoint: .transformers, token: token, httpMethod: .get, transformerId: nil).urlRequest else {
            completion("Url or AccessToken is not provided", nil)
            return
        }

        Alamofire.request(urlRequest)
            .validate()
            .responseJSON { (response) in
                
                guard response.result.isSuccess,
                    let value = response.result.value as? JSONDictionary,
                    let transformersJson = value["transformers"] as? NSArray else {
                        let errorMessage = "Fetch Transformers Error due to: \(response.result.error?.localizedDescription ?? "")"
                        completion(errorMessage, nil)
                        return
                }
                
                self.parseTransformersJSONIntoTransformers(transformersJson: transformersJson) { (errorMessage, transformers) in
                    completion(errorMessage, transformers)
                }
                
        }
    }
    
    // Helper
    func parseTransformersJSONIntoTransformers(transformersJson: NSArray, completion: @escaping TransformersCompletionHandler) {
        
        var transformers = [Transformer]()
        let group = DispatchGroup()
        
        for transformerJson in transformersJson {
            group.enter()
            guard let transformerJson = transformerJson as? JSONDictionary,
                let transformer = Transformer(json: transformerJson) else {
                    group.leave()
                    continue
            }
            
            print(transformer)
            transformers.append(transformer)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main, execute: {
            completion(nil, transformers)
        })
    }
}



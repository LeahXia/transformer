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
        
        let requestInfo = NetworkRequestInfo(endPoint: .transformers, token: token)

        guard let url = requestInfo.url, let headers = requestInfo.headers else {
            completion("Url or access token is not valid. Please contact our support team", nil)
            return
        }

        Alamofire.request(url, headers: headers)
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
    
    // POST
    func createOrEdit(transformer: Transformer, token: String, httpMethod: HTTPMethod, completion: @escaping ErrorMessageCompletionHandler) {
        
        let requestInfo = NetworkRequestInfo(endPoint: .transformers, token: token, httpMethod: httpMethod, transformerId: nil, transformer: transformer)
        
        guard let url = requestInfo.url,
            let headers = requestInfo.headers,
            let parameters = requestInfo.parameters else {
                completion("Url or access token is not valid. Please contact our support team")
                return
        }

        Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in

                guard response.result.isSuccess else {
                    let errorMessage = "Create or Edit Transformers Error due to: \(response.result.error?.localizedDescription ?? "")"
                    completion(errorMessage)
                    return
                }
                
                completion(nil)
        }
    }
    
    // PUT
//    func editTransformerRequest(transformer: Transformer, token: String, completion: @escaping TransformerCompletionHandler) {
//        
//        let requestInfo = NetworkRequestInfo(endPoint: .transformers, token: token, httpMethod: .put, transformerId: nil, transformer: transformer)
//        
//        guard let url = requestInfo.url,
//            let headers = requestInfo.headers,
//            let parameters = requestInfo.parameters else {
//                completion("Url or access token is not valid. Please contact our support team", nil)
//                return
//        }
//        
//        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .validate()
//            .responseJSON { (response) in
//                
//                guard response.result.isSuccess else {
//                    let errorMessage = "Create or Edit Transformers Error due to: \(response.result.error?.localizedDescription ?? "")"
//                    completion(errorMessage, nil)
//                    return
//                }
//                
//                
//                guard let value = response.value as? JSONDictionary else {
//                    completion("Data is not in valid JSON format", nil)
//                    return
//                }
//                
//                self.parseTransformersJSONIntoTransformers(transformersJson: [value], completion: { (errorMessage, transformers) in
//                    completion(nil, transformers?[0])
//                })
//        }
//    }
    
    // MARK: - DELETE
    func deleteTransformerBy(id: String, token: String, completion: @escaping ErrorMessageCompletionHandler) {

        let requestInfo = NetworkRequestInfo(endPoint: .deleteTransformer, token: token, httpMethod: .delete, transformerId: id, transformer: nil)
        
        guard let url = requestInfo.url,
            let headers = requestInfo.headers else {
                completion("Url or access token is not valid. Please contact our support team")
                return
        }
        
        Alamofire.request(url, method: .delete, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
            .validate()
            .responseJSON { (response) in
                
                guard response.result.isSuccess else {
                    let errorMessage = "Delete Transformers Error due to: \(response.result.error?.localizedDescription ?? "")"
                    completion(errorMessage)
                    return
                }
                
                completion(nil)
                
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
            transformers.append(transformer)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            completion(nil, transformers)
        }
    }
}



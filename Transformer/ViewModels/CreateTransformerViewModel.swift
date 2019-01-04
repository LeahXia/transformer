//
//  CreateTransformerViewModel.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-03.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

enum validationError: Error {
    case save(message: String)
}

final class CreateTransformerViewModel: NSObject {
    // MARK: - Service
    let transformerService = TransformerService()
    
    // MARK: - Create with Validation
    func createOrEditTransformer(id: String?, name: String?, teamInitial: TeamInitial?, specLabels: [UILabel]?) throws -> Transformer {
        
        guard let teamInitial = teamInitial else {
            throw validationError.save(message: "Please select a team!")
        }
        
        guard let name = name, name.isAlphanumericOrWhiteSpace() else {
            throw validationError.save(message: "Transformer names can be upper or lower case letters, numbers or white space.")
        }
        
        guard let specLabels = specLabels, let specValues = validateSpecs(from: specLabels) else {
            throw validationError.save(message: "Invalid Spec value")
        }
        
        let transformer = Transformer(id: id, name: name, teamInitial: teamInitial.rawValue, specValues: specValues)
                
        return transformer
    }
    
    func validateSpecs(from labels: [UILabel]) -> [Int]? {
        var specValues = [Int]()
        for label in labels {
            guard let text = label.text, let specNumber = Int(text), (1...10 ~= specNumber) else {
                return nil
            }
            
            specValues.append(specNumber)
        }
        return specValues
    }

    // MARK: - Data
    func createTransformerAndSendRequest(name: String?, teamInitial: TeamInitial?, specLabels: [UILabel]?, completion: @escaping ErrorMessageCompletionHandler) {
        
        guard let token = KeychainWrapper.standard.string(forKey: "accessToken") else {
            completion("You don't have an access token. Please contact our supporting team.")
            return
        }
        
        do {
            
            let transformer = try createOrEditTransformer(id: nil, name: name, teamInitial: teamInitial, specLabels: specLabels)
            
            transformerService.createOrEdit(transformer: transformer, token: token, httpMethod: .post) { (errorMessage) in
                completion(errorMessage)
            }
            
        } catch validationError.save (let (message)) {
            completion(message)
        } catch {
            completion(error.localizedDescription)
        }
        
        
    }
    
    func sendEditTransformerRequest(transformer: Transformer, name: String?, teamInitial: TeamInitial?, specLabels: [UILabel]?, completion: @escaping ErrorMessageCompletionHandler) {
        
        guard let token = KeychainWrapper.standard.string(forKey: "accessToken") else {
            completion("You don't have an access token. Please contact our supporting team.")
            return
        }
        
        do {
            
            let transformer = try createOrEditTransformer(id: transformer.id, name: name, teamInitial: teamInitial, specLabels: specLabels)
            
            transformerService.createOrEdit(transformer: transformer, token: token, httpMethod: .put) { (errorMessage) in
                completion(errorMessage)
            }
            
        } catch validationError.save (let (message)) {
            completion(message)
        } catch {
            completion(error.localizedDescription)
        }
    }
}

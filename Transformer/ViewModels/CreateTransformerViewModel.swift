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
    case save(title: String, message: String)
}

final class CreateTransformerViewModel: NSObject {
    // MARK: - Service
    let transformerService = TransformerService()
    
    // MARK: - Create with Validation
    func createTransformer(name: String?, teamInitial: TeamInitial?, specLabels: [UILabel]?) throws -> Transformer {
        
        guard let teamInitial = teamInitial else {
            throw validationError.save(title: "Please select a team!", message: "")
        }
        
        guard let name = name, name.isAlphanumericOrWhiteSpace() else {
            throw validationError.save(title: "Invalid Name" , message: "Transformer names can be upper or lower case letters, numbers or white space.")
        }
        
        guard let specLabels = specLabels, let specValues = validateSpecs(from: specLabels) else {
            throw validationError.save(title: "Invalid Spec value", message: "")
        }
        
        let transformer = Transformer(name: name, teamInitial: teamInitial.rawValue, specValues: specValues)
        
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
    func sendCreateTransformerRequest(transformer: Transformer, completion: @escaping ErrorMessageCompletionHandler) {
        
        guard let token = KeychainWrapper.standard.string(forKey: "accessToken") else {
            completion("You don't have an access token. Please contact our supporting team.")
            return
        }
        
        transformerService.createOrEdit(transformer: transformer, token: token, httpMethod: .post) { (errorMessage) in
            completion(errorMessage)
        }
    }
}

//
//  TransformerListViewModel.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit

/// Transform Team & Transformer model information into values that can be displayed on TransformerList view
final class TransformerListViewModel: NSObject {
    
    // MARK: - Variables
    
    // MARK: - Data
    func setAccessToken(token: String?, completion: @escaping TokenCompletionHandler) {
        guard token == nil else {
            completion(nil, token)
            return
        }
        AuthService().getAccessToken() { (errorMessage, token) in
            completion(errorMessage, token)
        }
    }
    
}



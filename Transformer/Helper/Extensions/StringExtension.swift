//
//  StringExtension.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-03.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation

extension String {
    
    func isAlphanumericOrWhiteSpace() -> Bool {
        return self.range(of: "[^a-zA-Z0-9 ]", options: .regularExpression) == nil && self != ""
    }
    
}

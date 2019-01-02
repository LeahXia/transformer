//
//  typealias.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]
typealias ErrorMessageCompletionHandler = (_ errorMessage: String?) -> ()
typealias TokenCompletionHandler = (_ errorMessage: String?, _ token: String?) -> ()


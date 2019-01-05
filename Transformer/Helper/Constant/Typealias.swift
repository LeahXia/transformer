//
//  Typealias.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]
typealias ErrorMessageCompletionHandler = (_ errorMessage: String?) -> ()
typealias TokenCompletionHandler = (_ errorMessage: String?, _ token: String?) -> ()
typealias TransformersCompletionHandler = (_ errorMessage: String?, _ transformers: [Transformer]?) -> ()
typealias TransformerCompletionHandler = (_ errorMessage: String?, _ transformer: Transformer?) -> ()
typealias ImageCompletionHandler = (_ errorMessage: String?, _ image: UIImage?) -> ()



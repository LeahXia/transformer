//
//  Enum.swift
//  Transformer
//
//  Created by Leah Xia on 2018-12-29.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import UIKit
import Alamofire

enum CornerRadius: CGFloat {
    case button = 15.2
    case cell = 14
}

enum EndPoint: String {
    case token = "allspark"
    case transformers = "transformers"
    case deleteTransformer = "transformers/"
}

enum TeamInitial: String {
    case Autobots = "A"
    case Decepticons = "D"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//enum Spec: String {
//    case Strength
//    case 
//}
//
//let progressViews = [strengthProgressView, intelligenceProgressView, speedProgressView, speedProgressView, enduranceProgressView, rankProgressView, courageProgressView, firepowerProgressView, skillProgressView]


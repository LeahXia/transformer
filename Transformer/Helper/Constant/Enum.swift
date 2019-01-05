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

enum TransformerSpecRange: Int {
    case min = 1
    case max = 10
}

enum BattleResult {
    case higherOverall(loser: TeamInitial, autoRating: Int, deceRating: Int)
    case moreSkillful(loser: TeamInitial)
    case morePowerful(loser: TeamInitial)
    case runAway(loser: TeamInitial)
    case tie
    case noBattle
}


//
//  Transformer.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import Foundation

enum TransformerSpecRange: Int {
    case min = 1
    case max = 10
}

/// A model holds Transformer info
struct Transformer {
    
    var id: String
    var name: String
    var teamInitial: String
    var teamIconUrl: String
    
    var strength: Int
    var intelligence: Int
    var speed: Int
    var endurance: Int
    var rank: Int
    var courage: Int
    var firepower: Int
    var skill: Int
    
    init(id: String, name: String, teamInitial: String, teamIconUrl: String) {
        let defaultSpecValue = TransformerSpecRange.min.rawValue

        self.init(id: id, name: name, teamInitial: teamInitial, teamIconUrl: teamIconUrl, strength: defaultSpecValue, intelligence: defaultSpecValue, speed: defaultSpecValue, endurance: defaultSpecValue, rank: defaultSpecValue, courage: defaultSpecValue, firepower: defaultSpecValue, skill: defaultSpecValue)
    }
    
    init(id: String, name: String, teamInitial: String, teamIconUrl: String, strength: Int, intelligence: Int, speed: Int, endurance: Int, rank: Int, courage: Int, firepower: Int, skill: Int) {
        self.id = id
        self.name = name
        self.teamInitial = teamInitial
        self.teamIconUrl = teamIconUrl
        
        self.strength = strength
        self.intelligence = intelligence
        self.speed = speed
        self.endurance = endurance
        self.rank = rank
        self.courage = courage
        self.firepower = firepower
        self.skill = skill
        
    }
    
    init?(json: JSONDictionary) {
        guard let id = json["id"] as? String,
            let name = json["name"] as? String,
            let teamInitial = json["team"] as? String,
            let teamIconUrl = json["team_icon"] as? String,
            let strength = json["strength"] as? String,
            let intelligence = json["intelligence"] as? String,
            let speed = json["speed"] as? String,
            let endurance = json["endurance"] as? String,
            let rank = json["rank"] as? String,
            let courage = json["courage"] as? String,
            let firepower = json["firepower"] as? String,
            let skill = json["skill"] as? String
            else {
            return nil
        }
        self.id = id
        self.name = name
        self.teamInitial = teamInitial
        self.teamIconUrl = teamIconUrl

        let defaultSpecValue = TransformerSpecRange.min.rawValue
        
        self.strength = Int(strength) ?? defaultSpecValue
        self.intelligence = Int(intelligence) ?? defaultSpecValue
        self.speed = Int(speed) ?? defaultSpecValue
        self.endurance = Int(endurance) ?? defaultSpecValue
        self.rank = Int(rank) ?? defaultSpecValue
        self.courage = Int(courage) ?? defaultSpecValue
        self.firepower = Int(firepower) ?? defaultSpecValue
        self.skill = Int(skill) ?? defaultSpecValue

    }
}

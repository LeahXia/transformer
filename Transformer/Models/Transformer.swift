//
//  Transformer.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import Foundation

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
    
    var overallRating: Int = 0
    
    private static let powerfullNames = ["Optimus Prime".lowercased(), "Predaking".lowercased()]
    
    // MARK: - Initialization
    init(id: String, name: String, teamInitial: String, teamIconUrl: String) {
        let defaultSpecValue = TransformerSpecRange.min.rawValue

        self.init(id: id, name: name, teamInitial: teamInitial, teamIconUrl: teamIconUrl, strength: defaultSpecValue, intelligence: defaultSpecValue, speed: defaultSpecValue, endurance: defaultSpecValue, rank: defaultSpecValue, courage: defaultSpecValue, firepower: defaultSpecValue, skill: defaultSpecValue)
    }
    
    init(id: String?, name: String, teamInitial: String, specValues: [Int]) {
        self.id = id ?? ""
        self.name = name
        self.teamInitial = teamInitial
        self.teamIconUrl = ""
        
        self.strength = specValues[0]
        self.intelligence = specValues[1]
        self.speed = specValues[2]
        self.endurance = specValues[3]
        self.rank = specValues[4]
        self.courage = specValues[5]
        self.firepower = specValues[6]
        self.skill = specValues[7]
        self.overallRating = calculateOverallRating()
    }
    
    init(id: String = "", name: String, teamInitial: String, teamIconUrl: String = "", strength: Int, intelligence: Int, speed: Int, endurance: Int, rank: Int, courage: Int, firepower: Int, skill: Int) {
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
        self.overallRating = calculateOverallRating()
        
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
        self.overallRating = calculateOverallRating()

    }
    
    // MARK: - Updating
    mutating func updateWithNew(transformer: Transformer) {

        self.name = transformer.name
        self.teamInitial = transformer.teamInitial
        self.teamIconUrl = transformer.teamIconUrl
        
        self.strength = transformer.strength
        self.intelligence = transformer.intelligence
        self.speed = transformer.speed
        self.endurance = transformer.endurance
        self.rank = transformer.rank
        self.courage = transformer.courage
        self.firepower = transformer.firepower
        self.skill = transformer.skill
        self.overallRating = calculateOverallRating()
    }
    
    // Calculate overallRating
    func calculateOverallRating() -> Int {
        return strength + intelligence + speed + endurance + firepower
    }
    
    // Set Different format
    func getHttpParameters() -> JSONDictionary {
        var parameters = [String: Any]()

        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard var key = child.label, key != "teamIconUrl" else { continue }
            if key == "teamInitial" { key = "team" }
            parameters[key] = "\(child.value)"
        }
        return parameters
    }
    
    func getSpecNumberArray() -> [Int] {
        var specNumArray = [Int]()
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let key = child.label, key != "teamIconUrl",
                key != "id", key != "teamInitial", key != "name",
                let value = child.value as? Int
            else { continue }
            specNumArray.append(value)
        }
        return specNumArray
    }
    
    // MARK: - Fight specs
    func isMorePowerful() -> Bool {
        
        if teamInitial == "A", self.name.lowercased() == Transformer.powerfullNames[0] {
            return true
        } else if teamInitial == "D", self.name.lowercased() == Transformer.powerfullNames[1] {
            return true
        }
        
        return false
        
    }
    
    func isMoreSkillful(than opponent: Transformer) -> Bool {
        return self.skill >= (opponent.skill + 3)
    }
    
    func didOpponentRanAway(opponent: Transformer) -> Bool {
        return self.courage >= (opponent.courage + 4) && self.strength >= (opponent.strength + 3)
    }
    
    func hasHigherOverallRating(than opponent: Transformer) -> Bool {
        return self.overallRating > opponent.overallRating
    }
        
}

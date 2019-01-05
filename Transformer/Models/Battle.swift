//
//  Battle.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-04.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import UIKit

/// A model holds info from a battle between 2 Transformers
final class Battle {
    
    private var fighters = [Transformer?](repeating: nil, count: 2)
    private var autoFighter: Transformer?
    private var deceFighter: Transformer?

    private(set) var battleResult: BattleResult?
    var loserIds = [String]()
    
    init(teams: [Team], currentIndex: Int) {
        let autobotsFighter = teams[0].getMember(for: currentIndex)
        let decepticonsFighter = teams[1].getMember(for: currentIndex)

        self.fighters = [autobotsFighter, decepticonsFighter]
    }
    
    func getFighters() -> [Transformer?] {
        return fighters
    }
    
    func getBattleResult() {
        
        autoFighter = fighters[0]
        deceFighter = fighters[1]
        
        guard let autoFighter = autoFighter else {
            self.battleResult = .noBattle
            return
        }
        
        guard let deceFighter = deceFighter else {
            self.battleResult = .noBattle
            return
        }
        guard !endsBattleDueToMorePowerful(autoFighter, deceFighter) else { return }
       
        guard !endsBattleDueToRanAway(autoFighter, deceFighter) else { return }

        guard !endsBattleDueToMoreSkillful(autoFighter, deceFighter) else { return }

        guard !endsBattleDueToHigherOverallRating(autoFighter, deceFighter) else { return }
        
    }

    func endsBattleDueToMorePowerful(_ autoFighter: Transformer, _ deceFighter: Transformer) -> Bool {

        if autoFighter.isMorePowerful() && deceFighter.isMorePowerful() {
            self.battleResult = .tie
            loserIds.append(autoFighter.id)
            loserIds.append(deceFighter.id)
            return true
        } else if autoFighter.isMorePowerful() {
            self.battleResult = .morePowerful(loser: .Decepticons)
            loserIds.append(deceFighter.id)
            return true
        } else if deceFighter.isMorePowerful() {
            self.battleResult = .morePowerful(loser: .Autobots)
            loserIds.append(autoFighter.id)
            return true
        }
        return false
    }
    
    func endsBattleDueToMoreSkillful(_ autoFighter: Transformer, _ deceFighter: Transformer) -> Bool {
        
        if autoFighter.isMoreSkillful(than: deceFighter) {
            self.battleResult = .moreSkillful(loser: .Decepticons)
            loserIds.append(deceFighter.id)
            return true
        } else if deceFighter.isMoreSkillful(than: deceFighter) {
            self.battleResult = .moreSkillful(loser: .Autobots)
            loserIds.append(autoFighter.id)
            return true
        }
        
        return false
    }
    
    func endsBattleDueToRanAway(_ autoFighter: Transformer, _ deceFighter: Transformer) -> Bool {
        
        if autoFighter.didOpponentRanAway(opponent: deceFighter) {
            self.battleResult = .runAway(loser: .Decepticons)
            loserIds.append(deceFighter.id)
            return true
        } else if deceFighter.didOpponentRanAway(opponent: autoFighter) {
            self.battleResult = .runAway(loser: .Autobots)
            loserIds.append(autoFighter.id)
            return true
        }
        
        return false
    }
    
    func endsBattleDueToHigherOverallRating(_ autoFighter: Transformer, _ deceFighter: Transformer) -> Bool {
        
        if autoFighter.hasHigherOverallRating(than: deceFighter) {
            self.battleResult = .higherOverall(loser: .Decepticons, autoRating: autoFighter.overallRating, deceRating: deceFighter.overallRating)
            loserIds.append(deceFighter.id)
            return true
        } else if deceFighter.hasHigherOverallRating(than: deceFighter) {
            self.battleResult = .higherOverall(loser: .Autobots, autoRating: autoFighter.overallRating, deceRating: deceFighter.overallRating)
            loserIds.append(autoFighter.id)
            return true
        } else {
            self.battleResult = .tie
            loserIds.append(autoFighter.id)
            loserIds.append(deceFighter.id)
        }
        
        return false
    }
    
}

//
//  FightViewModel.swift
//  Transformer
//
//  Created by Leah Xia on 2019-01-04.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import Foundation

final class FightViewModel: NSObject {
    // MARK: - Service
    let transformerService = TransformerService()
    var battles = [Battle]()

    var winningTeamText: String?
    
    var autobotsWinningText: String = ""
    var decepticonsWinningText: String = ""

    func setWinningTeam() {
        let (autobotsWinningNumber, decepticonsWinningNumber) = numbersOfWinningBattles()
        autobotsWinningText = "0" + "\(autobotsWinningNumber)"
        decepticonsWinningText = "0" + "\(decepticonsWinningNumber)"

        if autobotsWinningNumber > decepticonsWinningNumber {
            winningTeamText = "\(TeamInitial.Autobots)"
        } else if autobotsWinningNumber < decepticonsWinningNumber {
            winningTeamText = "\(TeamInitial.Decepticons)"
        } else {
            winningTeamText = "Tie"
        }
    }
    
    func numbersOfWinningBattles() -> (Int, Int) {
        var autoWins = 0
        var deceWins = 0
        
        for battle in battles {
            guard let result = battle.battleResult else { continue }
            switch result {
            case .tie:
                break
            case .higherOverall(let loser, _, _), .moreSkillful(let loser), .morePowerful(let loser), .runAway(let loser):
                increaseBattleWinningNumber(loser: loser, autoWins: &autoWins, deceWins: &deceWins)
                break
            case .noBattle:
                break
            }
        }
        return (autoWins, deceWins)
    }
    
    func increaseBattleWinningNumber(loser: TeamInitial, autoWins: inout Int, deceWins: inout Int) {
        switch loser {
        case .Autobots:
            deceWins += 1
            break
        case .Decepticons:
            autoWins += 1
            break
        }
    }
    
    
    // MARK: - For CollectionView

    func battleForItem(at indexPath: IndexPath) -> Battle? {
        guard battles.count > indexPath.item  else {
            return nil
        }
        return battles[indexPath.item]
    }
    
}

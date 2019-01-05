//
//  BattleModelTests.swift
//  TransformerTests
//
//  Created by Leah Xia on 2019-01-04.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class BattleModelTests: XCTestCase {

    var autoTeam: Team!
    var deceTeam: Team!

    override func setUp() {
        autoTeam = Team(nameInitial: "A")
        deceTeam = Team(nameInitial: "D")
        

    }

    override func tearDown() {
        autoTeam = nil
        deceTeam = nil
    }
    
    // MARK: - Get Battle Result
    func testGetBattleResult() {
        // Given
        let autoTransformer = Transformer(id: "-jkdjfkadsjf", name: "BumbleBee", teamInitial: "A", specValues: [2,3,5,2,5,6,7,4])
        let deceTransformer = Transformer(id: "-24dkadsjf", name: "Hubcap", teamInitial: "D", specValues: [2,3,5,2,5,6,7,4])
        
        autoTeam.addMember(transformer: autoTransformer)
        deceTeam.addMember(transformer: deceTransformer)
        let battle = Battle(teams: [autoTeam, deceTeam], currentIndex: 0)
        XCTAssertNotNil(battle)
        // When
        battle.getBattleResult()
        // Then
        XCTAssertNotNil(battle.battleResult)
        XCTAssertNotEqual(battle.loserIds.count, 0)

    }
}

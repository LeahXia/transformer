//
//  TeamModelTests.swift
//  TransformerTests
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class TeamModelTests: XCTestCase {

    var teamIconUrl: String!
    override func setUp() {
        teamIconUrl = "https://tfwiki.net/mediawiki/images2/archive/8/8d/20110410191659%21Symbol_decept_reg.png"
    }

    override func tearDown() {
        teamIconUrl = nil
    }

    // MARK: Initialization
    func testInit_TeamWithNameInitial() {
        // Given
        let name = "Autobots"
        let nameInitial = "A"
        // When
        let team = Team(nameInitial: nameInitial)
        // Then
        XCTAssertNotNil(team)
        XCTAssertEqual(team.name, name)
        XCTAssertEqual(team.initial, nameInitial)
        
    }
    
    func testInit_TeamWithOtherLettersAsNameInitial_TeamNameIsEmptyString() {
        // When
        let team = Team(nameInitial: "W")
        // Then
        XCTAssertNotNil(team)
        XCTAssertEqual(team.initial, "W")
        XCTAssertEqual(team.name, "")
        
    }
    
    // MARK: - Manager functions
    // GetMember
    func testGetMembers_ReturnMembersOfTeam() {
        let team = Team(nameInitial: "A")
        let members = team.getMembers()
        XCTAssertEqual(members.count, 0)
    }
    
    // AddMember
    func testAddMember_IncreasesMembersCount() {
        // Given
        let team = Team(nameInitial: "A")
        var members = team.getMembers()
        XCTAssertEqual(members.count, 0)
        let name = "Bumblebee"
        let transformer = Transformer(id: "kdfalkd", name: name, teamInitial: "A", teamIconUrl: teamIconUrl)
        // When
        team.addMember(transformer: transformer)
        members = team.getMembers()
        // Then
        XCTAssertEqual(members.count, 1)
        XCTAssertEqual(members[0].name, name)
    }
    
    func testAddMember_ToTeamAlreadyHas3Members_WillNotAdd() {
        // Given
        let team = Team(nameInitial: "A")
        let transformer1 = Transformer(id: "kdfalkd", name: "Bumblebee1", teamInitial: "A", teamIconUrl: teamIconUrl)
        let transformer2 = Transformer(id: "rrervd", name: "Bumblebee2", teamInitial: "A", teamIconUrl: teamIconUrl)
        let transformer3 = Transformer(id: "kpokeenc", name: "Bumblebee3", teamInitial: "A", teamIconUrl: teamIconUrl)
        let transformer4 = Transformer(id: "cuensnad", name: "Bumblebee4", teamInitial: "A", teamIconUrl: teamIconUrl)
        team.addMember(transformer: transformer1)
        team.addMember(transformer: transformer2)
        team.addMember(transformer: transformer3)
        var members = team.getMembers()
        XCTAssertEqual(members.count, 3)

        // When
        team.addMember(transformer: transformer4)
        members = team.getMembers()
        // Then
        XCTAssertEqual(members.count, 3)
    }
    
    func testAddMember_WithExsitingMember_WillNotAdd() {
        // Given
        let team = Team(nameInitial: "A")
        let transformer1 = Transformer(id: "SameID", name: "Bumblebee1", teamInitial: "A", teamIconUrl: teamIconUrl)
        let transformer2 = Transformer(id: "SameID", name: "Bumblebee2", teamInitial: "A", teamIconUrl: teamIconUrl)
        team.addMember(transformer: transformer1)
        var members = team.getMembers()
        XCTAssertEqual(members.count, 1)
        // When
        team.addMember(transformer: transformer2)
        members = team.getMembers()
        // Then
        XCTAssertEqual(members.count, 1)
    }

}

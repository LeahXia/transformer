//
//  TransformerModelTests.swift
//  TransformerTests
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class TransformerModelTests: XCTestCase {

    var teamIconUrl: String!
    override func setUp() {
        teamIconUrl = "https://tfwiki.net/mediawiki/images2/archive/8/8d/20110410191659%21Symbol_decept_reg.png"
    }
    
    override func tearDown() {
        teamIconUrl = nil
    }

    // MARK: Initialization
    
    func testInit_TransformerWithoutSpecs() {
        
        let transformer = Transformer(id: "-LV0V1Jbgl2hxZTH0AXx", name: "BumbleBee", teamInitial: "D", teamIconUrl: teamIconUrl)
        
        XCTAssertNotNil(transformer)
        XCTAssertEqual(transformer.id, "-LV0V1Jbgl2hxZTH0AXx")
        XCTAssertEqual(transformer.name, "BumbleBee")
        XCTAssertEqual(transformer.teamInitial, "D")
        XCTAssertEqual(transformer.strength, TransformerSpecRange.min.rawValue)
        
    }
    
    func testInit_TransformerWithSpecs() {
        
        
        let transformer = Transformer(id: "-LV0V1Jbgl2hxZTH0AXx", name: "BumbleBee", teamInitial: "D", teamIconUrl: teamIconUrl, strength: 1, intelligence: 2, speed: 3, endurance: 4, rank: 5, courage: 6, firepower: 7, skill: 8)
        XCTAssertNotNil(transformer)
        XCTAssertEqual(transformer.id, "-LV0V1Jbgl2hxZTH0AXx")
        XCTAssertEqual(transformer.name, "BumbleBee")
        XCTAssertEqual(transformer.teamInitial, "D")
        XCTAssertEqual(transformer.skill, 8)
        
    }
    
    func testInit_TransformerWithJSON() {
        let json = [
            "courage": "9",
            "endurance": "8",
            "firepower": "10",
            "id": "-LV0V1Jbgl2hxZTH0AXx",
            "intelligence": "10",
            "name": "BumbleBee",
            "rank": "10",
            "skill": "9",
            "speed": "4",
            "strength": "10",
            "team": "D",
            "team_icon": "https://tfwiki.net/mediawiki/images2/archive/8/8d/20110410191659%21Symbol_decept_reg.png"
        ]
        let transformer = Transformer(json: json)
        
        XCTAssertNotNil(transformer)
        XCTAssertEqual(transformer?.name, "BumbleBee")
        XCTAssertEqual(transformer?.id, "-LV0V1Jbgl2hxZTH0AXx")
        XCTAssertEqual(transformer?.teamInitial, "D")
        XCTAssertEqual(transformer?.strength, 10)

    }
    
    func testInit_TransformerWithInvalidSpecJSON() {
        let json = [
            "courage": "This value cannot be converted into Int",
            "endurance": "This value cannot be converted into Int",
            "firepower": "This value cannot be converted into Int",
            "id": "-LV0V1Jbgl2hxZTH0AXx",
            "intelligence": "This value cannot be converted into Int",
            "name": "BumbleBee",
            "rank": "This value cannot be converted into Int",
            "skill": "This value cannot be converted into Int",
            "speed": "This value cannot be converted into Int",
            "strength": "This value cannot be converted into Int",
            "team": "D",
            "team_icon": "https://tfwiki.net/mediawiki/images2/archive/8/8d/20110410191659%21Symbol_decept_reg.png"
        ]
        let transformer = Transformer(json: json)
        
        XCTAssertNotNil(transformer)
        XCTAssertEqual(transformer?.courage, TransformerSpecRange.min.rawValue)
        
    }
    
    func testInit_TransformerWithInvalidTeamJSON() {
        let json = [
            "courage": "9",
            "endurance": "8",
            "firepower": "10",
            "id": "-LV0V1Jbgl2hxZTH0AXx",
            "intelligence": "10",
            "name": "BumbleBee",
            "rank": "10",
            "skill": "9",
            "speed": "4",
            "strength": "10",
            "team": 20,
            "team_icon": "https://tfwiki.net/mediawiki/images2/archive/8/8d/20110410191659%21Symbol_decept_reg.png"
        ] as [String: Any]
        let transformer = Transformer(json: json)
        
        XCTAssertNil(transformer)
//        XCTAssertEqual(transformer?.name, "BumbleBee")
//        XCTAssertEqual(transformer?.id, "-LV0V1Jbgl2hxZTH0AXx")
//        XCTAssertEqual(transformer?.teamInitial, "D")
//        XCTAssertEqual(transformer?.strength, 10)
        
    }
//
//    func testInit_SetMovieTitleAndReleaseDate() {
//        let testMovie = Movie(title: "Romantic Comedy", releaseDate: "1987")
//        
//        XCTAssertNotNil(testMovie)
//        XCTAssertEqual(testMovie.releaseDate, "1987")
//    }
//    
//    // MARK: Equatable
//    func testEquatable_ReturnsTrue() {
//        let actionMovie1 = Movie(title: "Action")
//        let actionMovie2 = Movie(title: "Action")
//        
//        XCTAssertEqual(actionMovie1, actionMovie2)
//    }
//    
//    func testEquatable_ReturnsNotEqualForDifferentTitles() {
//        let actionMovie1 = Movie(title: "Action")
//        let actionMovie2 = Movie(title: "Adventure")
//        
//        XCTAssertNotEqual(actionMovie1, actionMovie2)
//    }
//    
//    func testEquatable_ReturnsNotEqualForDifferentReleaseDates() {
//        let actionMovie1 = Movie(title: "Action", releaseDate: "1999")
//        let actionMovie2 = Movie(title: "Action", releaseDate: "2018")
//        
//        XCTAssertNotEqual(actionMovie1, actionMovie2)
//    }

}

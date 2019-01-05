//
//  TransformerListViewModelTests.swift
//  TransformerTests
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class TransformerListViewModelTests: XCTestCase {
    
    var sut: TransformerListViewModel!
    var token: String!
    override func setUp() {
        sut = TransformerListViewModel()
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MVjBVVEdpUFNWX0ZGOVVDMmtsIiwiaWF0IjoxNTQ2MjEzMjU2fQ.U9bGeqazDXHMe8E4blPP1lF6KKj-d31n-wPampZHRmM"

    }

    override func tearDown() {
        sut = nil
        token = nil
    }

    // MARK: - Setup Teams
    func testSetupTeams_Has2TeamsAfterInit() {
        XCTAssertEqual(sut.teams.count, 2)
        XCTAssertEqual(sut.teams[0].name, "\(TeamInitial.Autobots)")
        XCTAssertEqual(sut.teams[1].name, "\(TeamInitial.Decepticons)")
    }
    
    // MARK: - Fetch All Transformers
    func testFetchAllTransformers_WithNoTokenPassedIn_ReturnsNewToken() {
        // Given
        let promise = expectation(description: "Token is not nil")
        // When
        sut.fetchAllTransformers(with: nil) { (errorMessage, token) in
            // Then
            XCTAssertNil(errorMessage)
            XCTAssertNotNil(token)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchAllTransformers_WithInvalidTokenPassedIn_ReturnsOldToken() {
        // Given
        let oldToken = "dfjdfjadifje"
        let promise = expectation(description: "Token stays the same")
        // When
        sut.fetchAllTransformers(with: oldToken) { (errorMessage, newToken) in
            // Then
            XCTAssertNotNil(errorMessage)
            XCTAssertEqual(newToken, oldToken)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchAllTransformers_WithValidTokenPassedIn_ReturnsOldToken() {
        // Given
        let promise = expectation(description: "Token stays the same")
        // When
        sut.fetchAllTransformers(with: token) { (errorMessage, newToken) in
            // Then
            XCTAssertNil(errorMessage)
            XCTAssertEqual(self.token, newToken)
            XCTAssertNotNil(newToken)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Fetch Transformers
    func testFetchTransformers_WithValidToken_SetsTransformersToTeams() {
        let promise = expectation(description: "Tramsformers are set to teams")
        sut.fetchTransformers(token: token) { (errorMessage) in
            XCTAssertNil(errorMessage)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchTransformers_WithInvalidToken_ReturnsErrorMessage() {
        let promise = expectation(description: "Tramsformers are set to teams")
        sut.fetchTransformers(token: nil) { (errorMessage) in
            XCTAssertNotNil(errorMessage)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}

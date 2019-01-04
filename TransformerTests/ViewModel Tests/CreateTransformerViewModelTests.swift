//
//  CreateTransformerViewModelTests.swift
//  TransformerTests
//
//  Created by Leah Xia on 2019-01-03.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class CreateTransformerViewModelTests: XCTestCase {

    var sut: CreateTransformerViewModel!
    var token: String!
    
    override func setUp() {
        sut = CreateTransformerViewModel()
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MVjBVVEdpUFNWX0ZGOVVDMmtsIiwiaWF0IjoxNTQ2MjEzMjU2fQ.U9bGeqazDXHMe8E4blPP1lF6KKj-d31n-wPampZHRmM"
        
    }
    
    override func tearDown() {
        sut = nil
        token = nil
    }
    
    // MARK: - Create Transformer
    func testCreateTransformer_WithoutName_ReturnsError() {
        // Given
        let specLabels = [UILabel]()
        // When
        do {
            _ = try sut.createTransformer(name: nil, teamInitial: .Decepticons, specLabels: specLabels)
        } catch {
            // Then
            XCTAssertTrue(error is validationError)
        }
        
    }
    
    func testCreateTransformer_WithoutTeamInitial_ReturnsError() {
        // Given
        let specLabels = [UILabel]()
        // When
        do {
            _ = try sut.createTransformer(name: "Test", teamInitial: nil, specLabels: specLabels)
        } catch {
            // Then
            XCTAssertTrue(error is validationError)
        }
        
    }
    
    func testCreateTransformer_WithInvalidSpecInput_ReturnsError() {
        // Given
        var specLabels = setSpecLabels(text: "Not a number")

        // When
        do {
            _ = try sut.createTransformer(name: "Test", teamInitial: .Decepticons, specLabels: specLabels)
        } catch {
            // Then
            XCTAssertTrue(error is validationError)
        }
        
        // Given
        specLabels = setSpecLabels(text: "20") //Out of range
        
        // When
        do {
            _ = try sut.createTransformer(name: "Test", teamInitial: .Decepticons, specLabels: specLabels)
        } catch {
            // Then
            XCTAssertTrue(error is validationError)
        }
        
    }
    
    // MARK: - Helper
    func setSpecLabels(text: String) -> [UILabel] {
        var specLabels = [UILabel]()
        (0...7).forEach({ _ in
            let label = UILabel()
            label.text = text
            specLabels.append(label)
        })
        
        return specLabels
    }
//    func testFetchAllTransformers_WithInvalidTokenPassedIn_ReturnsOldToken() {
//        // Given
//        let oldToken = "dfjdfjadifje"
//        let promise = expectation(description: "Token stays the same")
//        // When
//        sut.fetchAllTransformers(with: oldToken) { (errorMessage, newToken) in
//            // Then
//            XCTAssertNotNil(errorMessage)
//            XCTAssertEqual(newToken, oldToken)
//            promise.fulfill()
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//
//    func testFetchAllTransformers_WithValidTokenPassedIn_ReturnsOldToken() {
//        // Given
//        let promise = expectation(description: "Token stays the same")
//        // When
//        sut.fetchAllTransformers(with: token) { (errorMessage, newToken) in
//            // Then
//            XCTAssertNil(errorMessage)
//            XCTAssertEqual(self.token, newToken)
//            XCTAssertNotNil(newToken)
//            promise.fulfill()
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//
//    // MARK: - Fetch Transformers
//    func testFetchTransformers_WithValidToken_SetsTransformersToTeams() {
//        let promise = expectation(description: "Tramsformers are set to teams")
//        sut.fetchTransformers(token: token) { (errorMessage) in
//            XCTAssertNil(errorMessage)
//            promise.fulfill()
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//
//    func testFetchTransformers_WithInvalidToken_ReturnsErrorMessage() {
//        let promise = expectation(description: "Tramsformers are set to teams")
//        sut.fetchTransformers(token: nil) { (errorMessage) in
//            XCTAssertNotNil(errorMessage)
//            promise.fulfill()
//        }
//        waitForExpectations(timeout: 5, handler: nil)
//    }
}

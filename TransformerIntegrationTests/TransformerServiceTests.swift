//
//  TransformerServiceTests.swift
//  TransformerIntegrationTests
//
//  Created by Leah Xia on 2019-01-02.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class TransformerServiceTests: XCTestCase {

    var sut: TransformerService!
    var token: String!
    override func setUp() {
        sut = TransformerService()
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MVk1vU0Z4UlE2TnRNVW1tVHpiIiwiaWF0IjoxNTQ2NTg3ODUzfQ.B05G5ZL72bRGxRVaCDF9s3BUfRSIQKScqi1cE7J-93g"

    }
    
    override func tearDown() {
        sut = nil
        token = nil
    }
    
    // MARK: - GET
    func testGetfetchAllTransformers_ReturnsTransformers() {
        // Given
        let promise = expectation(description: "Transformers is not nil")
        // When
        sut.fetchAllTransformers(token: token) { (errorMessage, transformers) in
            // Then
            if let errorMessage = errorMessage {
                XCTFail("Error: \(errorMessage)")
            } else {
                XCTAssertNotNil(transformers)
                promise.fulfill()
            }
        }

        wait(for: [promise], timeout: 5)
    }
    
    func testGetfetchAllTransformers_WithInvalidToken_ReturnsErrorMessage() {
        // Given
        let token = "InvalidToken"
        let promise = expectation(description: "fetchAllTransformers return errorMessage")
        // When
        sut.fetchAllTransformers(token: token) { (errorMessage, transformers) in
            // Then
            XCTAssertNotNil(errorMessage)
            promise.fulfill()
            XCTAssertNil(transformers)
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    // MARK: - POST
    func testCreateTransformer_WithValidInput_ReturnsNoError() {
        // Given
        let promise = expectation(description: "Transformers is not nil")
        let transformer = Transformer(id: "", name: "BumbleBee", teamInitial: "D", teamIconUrl: "")

        // When
        self.sut.createOrEdit(transformer: transformer, token: self.token, httpMethod: .post) { (errorMessage) in
            // Then
            XCTAssertNil(errorMessage)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
}

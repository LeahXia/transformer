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
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MVjBVVEdpUFNWX0ZGOVVDMmtsIiwiaWF0IjoxNTQ2MjEzMjU2fQ.U9bGeqazDXHMe8E4blPP1lF6KKj-d31n-wPampZHRmM"

    }
    
    override func tearDown() {
        sut = nil
        token = nil
    }
    
//    func testgetAccessToken_ReturnsToken() {
//        // Given
//        let promise = expectation(description: "Token is not nil")
//        // When
//        sut.getAccessToken() { (errorMessage, token) in
//            // Then
//            if let errorMessage = errorMessage {
//                XCTFail("Error: \(errorMessage)")
//            } else {
//                XCTAssertNotNil(token)
//                promise.fulfill()
//            }
//        }
//
//        waitForExpectations(timeout: 5, handler: nil)
//    }
    
    func testGetfetchAllTransformers_ReturnsTransformers() {
        // Given
        let promise = expectation(description: "Transformers is not nil")
        // When
        sut.fetchAllTransformers(token: token) { (errorMessage, transformers) in
            // Then
            if let errorMessage = errorMessage {
                XCTFail("Error: \(errorMessage)")
            } else {
                XCTAssertEqual(transformers?.count, 2)
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

}

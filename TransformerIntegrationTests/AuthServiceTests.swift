//
//  AuthServiceTests.swift
//  TransformerIntegrationTests
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class AuthServiceTests: XCTestCase {

    var sut: AuthService!
    
    override func setUp() {
        sut = AuthService()
    }

    override func tearDown() {
        sut = nil
    }

    func testgetAccessToken_ReturnsToken() {
        // Given
        let promise = expectation(description: "Token is not nil")
        // When
        sut.getAccessToken() { (errorMessage, token) in
            // Then
            if let errorMessage = errorMessage {
                XCTFail("Error: \(errorMessage)")
            } else {
                XCTAssertNotNil(token)
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
}


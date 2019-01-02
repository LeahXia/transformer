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
    
    override func setUp() {
        sut = TransformerListViewModel()
    }

    override func tearDown() {
        sut = nil
    }

    func testSetAccessToken_WithNoTokenPassedIn_ReturnsNewToken() {
        // Given
        let promise = expectation(description: "Token is not nil")
        // When
        sut.setAccessToken(token: nil) { (errorMessage, token) in
            // Then
            XCTAssertNil(errorMessage)
            XCTAssertNotNil(token)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSetAccessToken_WithTokenPassedIn_ReturnsOldToken() {
        // Given
        let oldToken = "dfjdfjadifje"
        let promise = expectation(description: "Token stays the same")
        // When
        sut.setAccessToken(token: oldToken) { (errorMessage, token) in
            // Then
            XCTAssertNil(errorMessage)
            XCTAssertEqual(token, oldToken)
            XCTAssertNotNil(token)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}

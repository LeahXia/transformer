//
//  NetworkRequestInfoTests.swift
//  TransformerIntegrationTests
//
//  Created by Leah Xia on 2019-01-01.
//  Copyright © 2019 Leah Xia. All rights reserved.
//

import XCTest
@testable import Transformer

class NetworkRequestInfoTests: XCTestCase {
    
    var baseUrl: String!
   
    override func setUp() {
        baseUrl = "https://transformers-api.firebaseapp.com/"
    }

    override func tearDown() {
        baseUrl = nil
    }

    // MARK: Initialization
    func testInitNetworkRequestInfo_WithTokenEndPoint_SetsUrl() {
        // Given
        let url = URL(string: baseUrl + "allspark")
        // When
        let networkRequestInfo = NetworkRequestInfo(endPoint: .token)
        // Then
        XCTAssertNotNil(networkRequestInfo)
        XCTAssertEqual(networkRequestInfo.url, url)
    }
    
    func testInitNetworkRequestInfo_WithTransformerEndPoint_SetsGetUrlRequest() {
        // Given
        let url = URL(string: baseUrl + "transformers")
        // When
        let networkRequestInfo = NetworkRequestInfo(endPoint: .transformers)
        // Then
        XCTAssertNotNil(networkRequestInfo)
        XCTAssertEqual(networkRequestInfo.urlRequest?.url, url)
        XCTAssertEqual(networkRequestInfo.urlRequest?.allHTTPHeaderFields?.count, 2)
    }
    
    func testInitNetworkRequestInfo_ForPOSTTransformer_SetsPOSTUrlRequest() {
        // Given
        let url = URL(string: baseUrl + "transformers")
        // When
        let networkRequestInfo = NetworkRequestInfo(endPoint: .transformers, httpMethod: .post, transformerId: nil)
        // Then
        XCTAssertNotNil(networkRequestInfo)
        XCTAssertEqual(networkRequestInfo.urlRequest?.url, url)
        XCTAssertEqual(networkRequestInfo.urlRequest?.allHTTPHeaderFields?.count, 2)
        XCTAssertEqual(networkRequestInfo.urlRequest?.httpMethod, "POST")
    }
    
    func testInitNetworkRequestInfo_ForDELETETransformer_SetsDELETEUrlRequest() {
        // Given
        let transformerId = "dkfjafdkjfadk"
        let url = URL(string: baseUrl + "transformers/" + transformerId)
        // When
        let networkRequestInfo = NetworkRequestInfo(endPoint: .deleteTransformer, httpMethod: .delete, transformerId: transformerId)
        // Then
        XCTAssertNotNil(networkRequestInfo)
        XCTAssertEqual(networkRequestInfo.urlRequest?.url, url)
        XCTAssertEqual(networkRequestInfo.urlRequest?.allHTTPHeaderFields?.count, 2)
        XCTAssertEqual(networkRequestInfo.urlRequest?.httpMethod, "DELETE")
    }
}

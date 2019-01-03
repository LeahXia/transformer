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
    var token: String!
   
    override func setUp() {
        baseUrl = "https://transformers-api.firebaseapp.com/"
        token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0cmFuc2Zvcm1lcnNJZCI6Ii1MVkZqUkZWeTVQbkozVVRSOWZ4IiwiaWF0IjoxNTQ2NDY5MDk4fQ.fpcyOTPLkpOu0ybZetCZPnpX0qgTMicRQd5ILAkRyn8"

    }

    override func tearDown() {
        baseUrl = nil
        token = nil
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
        let networkRequestInfo = NetworkRequestInfo(endPoint: .transformers, token: token, httpMethod: .get, transformerId: nil)

        // Then
        XCTAssertNotNil(networkRequestInfo)
        XCTAssertEqual(networkRequestInfo.urlRequest?.url, url)
        XCTAssertEqual(networkRequestInfo.urlRequest?.allHTTPHeaderFields?.count, 2)
    }
    
    func testInitNetworkRequestInfo_ForPOSTTransformer_SetsPOSTUrlRequest() {
        // Given
        let url = URL(string: baseUrl + "transformers")
        // When
        let networkRequestInfo = NetworkRequestInfo(endPoint: .transformers, token: token, httpMethod: .post, transformerId: nil)
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
        let networkRequestInfo = NetworkRequestInfo(endPoint: .deleteTransformer, token: token, httpMethod: .delete, transformerId: transformerId)
        // Then
        XCTAssertNotNil(networkRequestInfo)
        XCTAssertEqual(networkRequestInfo.urlRequest?.url, url)
        XCTAssertEqual(networkRequestInfo.urlRequest?.allHTTPHeaderFields?.count, 2)
        XCTAssertEqual(networkRequestInfo.urlRequest?.httpMethod, "DELETE")
    }
}

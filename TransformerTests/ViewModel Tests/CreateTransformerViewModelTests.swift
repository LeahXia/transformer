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
            _ = try sut.createOrEditTransformer(id: nil, name: nil, teamInitial: .Decepticons, specLabels: specLabels)
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
            _ = try sut.createOrEditTransformer(id: nil, name: "Test", teamInitial: nil, specLabels: specLabels)
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
            _ = try sut.createOrEditTransformer(id: nil, name: "Test", teamInitial: .Decepticons, specLabels: specLabels)
        } catch {
            // Then
            XCTAssertTrue(error is validationError)
        }
        
        // Given
        specLabels = setSpecLabels(text: "20") //Out of range
        
        // When
        do {
            _ = try sut.createOrEditTransformer(id: nil, name: "Test", teamInitial: .Decepticons, specLabels: specLabels)
        } catch {
            // Then
            XCTAssertTrue(error is validationError)
        }
        
    }
    
    // MARK: - Update Transformer
    func testUpdateTransformer_WithoutValidInput_ReturnsError() {
        // Given
        let specLabels = setSpecLabels(text: "10")
        // When
        do {
            _ = try sut.createOrEditTransformer(id: nil, name: "BumbleBee", teamInitial: .Decepticons, specLabels: specLabels)
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

}

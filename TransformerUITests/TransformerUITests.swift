//
//  TransformerUITests.swift
//  TransformerUITests
//
//  Created by Leah Xia on 2018-12-25.
//  Copyright © 2018 Leah Xia. All rights reserved.
//

import XCTest

class TransformerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSpecStepper() {
        // Given
        let app = XCUIApplication()
        app.navigationBars["Transformer"].buttons["Add"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Name").children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 0)
        let plusbuttonButton = element.buttons["plusButton"]
        plusbuttonButton.tap()
        plusbuttonButton.tap()
        
        // Then
        let elementsQuery = scrollViewsQuery.otherElements
        let specNumberLabel = elementsQuery.staticTexts["3"]
        XCTAssertNotNil(specNumberLabel)
        element.buttons["minusButton"].tap()
        let specNumberLabelDecreased = elementsQuery.staticTexts["2"]
        XCTAssertNotNil(specNumberLabelDecreased)
    }

}

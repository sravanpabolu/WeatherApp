//
//  SettingsVCTests.swift
//  WeatherAppUITests
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import XCTest

class SettingsVCTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSettings() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        app.navigationBars["Weather"].children(matching: .button).element(boundBy: 1).tap()
        app/*@START_MENU_TOKEN@*/.buttons["Imperial"]/*[[".segmentedControls.buttons[\"Imperial\"]",".buttons[\"Imperial\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Metric"]/*[[".segmentedControls.buttons[\"Metric\"]",".buttons[\"Metric\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["WeatherApp.SettingsVC"].buttons["Weather"].tap()
        
    }

}

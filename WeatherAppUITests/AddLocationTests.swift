//
//  AddLocationTests.swift
//  WeatherAppUITests
//
//  Created by Sravan Kumar Pabolu on 04/05/21.
//

import XCTest

class AddLocationTests: XCTestCase {

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

    func testAddLocation() throws {
        
        let app = XCUIApplication()
        app.navigationBars["Weather"].buttons["Add"].tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.otherElements["Nagpur"]/*[[".maps.otherElements[\"Nagpur\"]",".otherElements[\"Nagpur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.otherElements["Guntur"]/*[[".maps.otherElements[\"Guntur\"]",".otherElements[\"Guntur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["WeatherApp.AddLocationVC"].buttons["Done"].tap()
                
        
    }

}

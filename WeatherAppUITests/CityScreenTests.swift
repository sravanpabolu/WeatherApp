//
//  CityScreenTests.swift
//  WeatherAppUITests
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import XCTest

class CityScreenTests: XCTestCase {

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

    func testCityScreen() throws {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Guntur"]/*[[".cells.staticTexts[\"Guntur\"]",".staticTexts[\"Guntur\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["WeatherApp.CityScreenVC"].buttons["Weather"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["8 Rue des Cèdres Bleus"]/*[[".cells.staticTexts[\"8 Rue des Cèdres Bleus\"]",".staticTexts[\"8 Rue des Cèdres Bleus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Invalid Location"].scrollViews.otherElements.buttons["OK"].tap()
    }
}

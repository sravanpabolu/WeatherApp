//
//  HomeScreenVCTests.swift
//  WeatherAppUITests
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import XCTest

class HomeScreenVCTests: XCTestCase {

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

    func testHomeScreen() throws {
        let app = XCUIApplication()
        
        app.tables
            .element(boundBy: 0)
            .cells
            .element(boundBy: 0)
            .swipeUp()
        
        let weatherNavigationBar = app.navigationBars["Weather"]

        weatherNavigationBar.children(matching: .button).element(boundBy: 1).tap()
        app.navigationBars["WeatherApp.SettingsVC"].buttons["Weather"].tap()
        weatherNavigationBar.children(matching: .button).element(boundBy: 2).tap()
        app.webViews.webViews.webViews/*@START_MENU_TOKEN@*/.staticTexts["How many keys can I create?"]/*[[".otherElements[\"Frequently Asked Questions - OpenWeatherMap\"]",".otherElements[\"main\"].staticTexts[\"How many keys can I create?\"]",".staticTexts[\"How many keys can I create?\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.navigationBars["WeatherApp.HelpScreenVC"].buttons["Weather"].tap()
        
    }
    
    func testDeleteCity()  {
        let app = XCUIApplication()
        
        app.tables
            .element(boundBy: 0)
            .cells
            .element(boundBy: 0)
            .swipeLeft()
        
        app.tables.buttons["Delete"].tap()
    }

}

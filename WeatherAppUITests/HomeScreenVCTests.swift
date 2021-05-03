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

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 6).staticTexts["Nellore"].swipeUp()
        
        let weatherNavigationBar = app.navigationBars["Weather"]
        weatherNavigationBar.buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.otherElements["Chennai"]/*[[".maps.otherElements[\"Chennai\"]",".otherElements[\"Chennai\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["WeatherApp.AddLocationVC"].buttons["Done"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["21/12, ABM Road"]/*[[".cells.staticTexts[\"21\/12, ABM Road\"]",".staticTexts[\"21\/12, ABM Road\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let okButton = app.alerts["Invalid Location"].scrollViews.otherElements.buttons["OK"]
        okButton.tap()

//        tablesQuery.children(matching: .cell).element(boundBy: 5).staticTexts["Nellore"].swipeLeft()
//        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Wangdue Phodrang"]/*[[".cells.staticTexts[\"Wangdue Phodrang\"]",".staticTexts[\"Wangdue Phodrang\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
//        okButton.tap()
        
        weatherNavigationBar.children(matching: .button).element(boundBy: 1).tap()
        app.navigationBars["WeatherApp.SettingsVC"].buttons["Weather"].tap()
        weatherNavigationBar.children(matching: .button).element(boundBy: 2).tap()
        app.webViews.webViews.webViews/*@START_MENU_TOKEN@*/.staticTexts["How many keys can I create?"]/*[[".otherElements[\"Frequently Asked Questions - OpenWeatherMap\"]",".otherElements[\"main\"].staticTexts[\"How many keys can I create?\"]",".staticTexts[\"How many keys can I create?\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app.navigationBars["WeatherApp.HelpScreenVC"].buttons["Weather"].tap()
        
    }
    
    func testDeleteCity()  {
        
    }

}

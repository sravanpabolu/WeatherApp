//
//  SettingsTests.swift
//  WeatherAppTests
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import XCTest
@testable import WeatherApp

class SettingsTests: XCTestCase {

    let settingsVM = SettingsVM()
    
    func testUpdateSetting() {
        XCTAssertNoThrow(try settingsVM.updateSetting(isMetric: false))
        
        XCTAssertNoThrow(try settingsVM.updateSetting(isMetric: true))
    }
    
    func testGetCurrentSettings() {
        XCTAssertNoThrow(try settingsVM.getCurrentSettings())
    }
}

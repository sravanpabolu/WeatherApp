//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    let settingsVM = SettingsVM()
    
    func testChangeSettings() {
        do {
            try settingsVM.updateSetting(isMetric: true)
        } catch {
            Logger.printMessage(message: error.localizedDescription, request: "Change Settings Error")
        }
    }
}

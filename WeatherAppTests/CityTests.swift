//
//  CityTests.swift
//  WeatherAppTests
//
//  Created by Sravan Kumar Pabolu on 02/05/21.
//

import XCTest
@testable import WeatherApp

class CityTests: XCTestCase {

    let cityScreenVM = CityScreenVM()
    
    func testVars() {
//        let temp = cityScreenVM.temperature
        XCTAssertEqual(cityScreenVM.temperature, 0)
        XCTAssertEqual(cityScreenVM.temperatureMin, 0)
        XCTAssertEqual(cityScreenVM.temperatureMax, 0)
        XCTAssertEqual(cityScreenVM.feelsLike, 0)
        XCTAssertEqual(cityScreenVM.wind, 0)
        XCTAssertEqual(cityScreenVM.description, "")
    }
    
    func testGetCitySuccessData() {
        let someExpectation = expectation(description: "Fetch City Weather Data")
        
        var status = false
        
        cityScreenVM.getCityWeatherData(for: "Chennai") { (responseStatus, _) in
            
            status = responseStatus
            
            someExpectation.fulfill()
            
        } failureHandler: { (status, error) in
            XCTAssertFalse(status)
            XCTAssertNotNil(error)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(status)
    }
    
    func testGetCityInvalidData() {
        let someExpectation = expectation(description: "Fetch City Weather Data")
        
        var status = false
        
        cityScreenVM.getCityWeatherData(for: "Chennai1") { (responseStatus, _) in
            
            status = responseStatus
            
            someExpectation.fulfill()
            
        } failureHandler: { (status, error) in
            someExpectation.fulfill()
            XCTAssertFalse(status)
            XCTAssertNotNil(error)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(status)
    }
}

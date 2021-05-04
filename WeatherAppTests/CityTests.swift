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
    
    let kavali = BookmarkedLocation(name: "Kaveri Nagar", locality: "Nellore", subLocality: "Kaveri Nagar", adminArea: "AP", lat: 14.417335306869404, long: 14.417335306869404)
    let bangalore = BookmarkedLocation(name: "Ganapathihalli", locality: "Bengaluru", subLocality: "Ganapathihalli", adminArea: "KA", lat: 12.919230692244014, long: 77.39211801181591)
    let invalidLocation = BookmarkedLocation(name: "Ganapathihalli", locality: "Bengaluru", subLocality: "Ganapathihalli", adminArea: "KA", lat: 1222.919230692244014, long: 177.39211801181591)
    
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
        
        cityScreenVM.getCityWeatherData(for: bangalore) { (responseStatus, _) in
            
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
        
        cityScreenVM.getCityWeatherData(for: invalidLocation) { (responseStatus, _) in
            
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

//
//  HomeScreenTests.swift
//  WeatherAppTests
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import XCTest
@testable import WeatherApp

class HomeScreenTests: XCTestCase {

    let homeScreenVM = HomeScreenVM()

    func testInsertCity() throws {
        XCTAssertNoThrow(try homeScreenVM.insertCity(name: "Nellore"), "Insert City")
    }
    
    func testDeleteCity() throws {
        XCTAssertNoThrow(try homeScreenVM.deleteCity(at: 0), "Delete City - No Cities")
        
        homeScreenVM.cities = ["Chennai", "Hyderabad", "Mumbai"]
        XCTAssertNoThrow(try homeScreenVM.deleteCity(at: 0), "Delete City")
    }
    
    
    func testFetchCitiesFromDB() {
        do {
            try homeScreenVM.fetchCities()
            XCTAssertTrue(homeScreenVM.cities.count > 0)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

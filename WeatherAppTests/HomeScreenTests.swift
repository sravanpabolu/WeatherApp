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

    
    let kavali = BookmarkedLocation(name: "Kaveri Nagar", locality: "Nellore", subLocality: "Kaveri Nagar", adminArea: "AP", lat: 14.417335306869404, long: 14.417335306869404)
    let bangalore = BookmarkedLocation(name: "Ganapathihalli", locality: "Bengaluru", subLocality: "Ganapathihalli", adminArea: "KA", lat: 12.919230692244014, long: 77.39211801181591)
    
    func testInsertCity() throws {
        XCTAssertNoThrow(try homeScreenVM.insertCity(location: kavali), "Insert City")
    }
    
    func testDeleteCity() throws {
        XCTAssertNoThrow(try homeScreenVM.deleteCity(at: 0), "Delete City - No Cities")
        
        homeScreenVM.cities = [kavali, bangalore]
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

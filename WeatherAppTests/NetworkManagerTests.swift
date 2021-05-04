//
//  NetworkManagerTests.swift
//  WeatherAppTests
//
//  Created by Sravan Kumar Pabolu on 03/05/21.
//

import XCTest
@testable import WeatherApp

class NetworkManagerTests: XCTestCase {

    func testInvalidURL() throws {
        let invalidURL = "this is an url"
        let someExpectation = expectation(description: "Fetch City Weather Data")
        
        NetworkManager().performNetworkRequest(url: invalidURL) { (result) in
            someExpectation.fulfill()
            
            switch result {
                case .success(let data):
                    XCTAssertNotNil(data)
                case .failure(let error):
                    XCTAssertNotNil(error)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

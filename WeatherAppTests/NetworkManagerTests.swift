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
        NetworkManager().performNetworkRequest(url: invalidURL) { (status, data) in
            XCTAssertFalse(status)
        } failureHandler: { (status, error) in
            XCTAssertFalse(status)
        }

    }
}

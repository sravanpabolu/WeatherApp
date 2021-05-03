//
//  Logger.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation

struct Logger {
    static func printMessage(message: Any, request: String = "Random Request") {
        print(">>>>>>>>>>>>>>>>>>>>>")
        print(request)
        print("MESSAGE:")
        print(String(describing: message))
        print("<<<<<<<<<<<<<<<<<<<<<")
    }
}

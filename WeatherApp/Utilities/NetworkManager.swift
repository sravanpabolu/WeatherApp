//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation

class NetworkManager {
    func performNetworkRequest(url: String, successHandler: @escaping SuccessHandler, failureHandler: @escaping FailureHandler) {
        
        guard let url = URL(string: url) else {
            failureHandler(false, .invalidURL)
            return
        }
        
        let urlConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: urlConfig)
        
        Logger.printMessage(message: "\(url)", request: "URL Request")
        
        session.dataTask(with: url) { (data, _, error) in
            if error != nil {
                Logger.printMessage(message: "No Data", request: "API Error")
                failureHandler(false, .apiError)
            }
            
            guard let data = data else {
                Logger.printMessage(message: "No Data", request: "Network Response")
                failureHandler(false, .noData)
                return
            }
            
            successHandler(true, data)
        }.resume()
    }
}

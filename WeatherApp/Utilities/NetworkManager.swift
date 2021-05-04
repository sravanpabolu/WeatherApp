//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation

class NetworkManager {
    func performNetworkRequest(url: String, completion: @escaping (Result<Data, CustomError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: urlConfig)
        
        Logger.printMessage(message: "\(url)", request: "URL Request")
        
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                Logger.printMessage(message: "No Data", request: "API Error")
                completion(.failure(.apiError))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                Logger.printMessage(message: "No Data", request: "Network Response")
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}

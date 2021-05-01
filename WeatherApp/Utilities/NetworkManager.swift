//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation

enum NetworkError: Error {
    case noData
    case apiError
    case invalidURL
    case serializationError
    case invalidResponse
}

class NetworkManager {
    
    typealias completionHandler = (WeatherData?, NetworkError?) -> Void
    
    func performNetworkRequest(url: String, completion: @escaping completionHandler) {
        guard let url = URL(string: url) else {
            completion(nil, .invalidURL)
            return
        }
        
        let urlConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: urlConfig)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, .apiError)
            }
            
            guard let data = data else {
                completion(nil, .noData)
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(weatherData, nil)
            } catch {
                completion(nil, .serializationError)
            }
        }.resume()
    }
}

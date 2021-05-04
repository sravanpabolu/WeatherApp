//
//  CityScreenVM.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation

class CityScreenVM {
    
    var cityWeatherData: WeatherData?
    
    var temperature: Double {
        return cityWeatherData?.main?.temp ?? 0.0
    }
    
    var temperatureMin: Double {
        return cityWeatherData?.main?.tempMin ?? 0.0
    }
    
    var temperatureMax: Double {
        return cityWeatherData?.main?.tempMax ?? 0.0
    }
    
    var feelsLike: Double {
        return cityWeatherData?.main?.feelsLike ?? 0.0
    }
    
    var wind: Double {
        return cityWeatherData?.wind?.speed ?? 0.0
    }
    
    var description: String {
        return cityWeatherData?.weather?.first?.weatherDescription ?? ""
    }
    
    func getCityWeatherData(for location: BookmarkedLocation, completion: @escaping ((Result<WeatherData, CustomError>) -> Void)) {
        
        let units = (AppSettings.shared.isMetric == .metric) ? "metric" : "imperial"
        let lat = location.lat ?? 0.0
        let long = location.long ?? 0.0
        
        let url = Constants.urlLatLong + "&units=\(units)&lat=\(lat)&lon=\(long)"
        
        Logger.printMessage(message: url, request: "URL")
        
        NetworkManager().performNetworkRequest(url: url) { (response) in
            switch response {
                case .success(let data):
                    do {
                        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                        Logger.printMessage(message: "\(weatherData)", request: "Network Response")
                        
                        self.cityWeatherData = weatherData
                        completion(.success(weatherData))
                    } catch {
                        Logger.printMessage(message: "SerializationError", request: "Network Response")
                        completion(.failure(.serializationError))
                    }
                case .failure(let error):
                    Logger.printMessage(message: error, request: "Error")
                    completion(.failure(.genericError(message: error.localizedDescription)))
            }
        }
    }
}

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
    
    func getCityWeatherData(for location: String, successHandler: @escaping SuccessHandler, failureHandler: @escaping FailureHandler) {
        let url = Constants.UrlCurrentLocation + location
        
        NetworkManager().performNetworkRequest(url: url) { (status, data) in
            guard let data = data else {
                failureHandler(false, .noData)
                return
            }
            
            Logger.printMessage(message: "\(data)", request: "Network Response Data")
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                Logger.printMessage(message: "\(weatherData)", request: "Network Response")
                
                self.cityWeatherData = weatherData
                
                successHandler(true, nil)
                
            } catch {
                Logger.printMessage(message: "SerializationError", request: "Network Response")
                failureHandler(false, .serializationError)
            }
        } failureHandler: { (status, error) in
            failureHandler(status, error)
        }
        
    }
}

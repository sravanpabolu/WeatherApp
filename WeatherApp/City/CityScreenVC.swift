//
//  CityScreenVC.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import UIKit

class CityScreenVC: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblTemperatureMin: UILabel!
    @IBOutlet weak var lblTemperatureMax: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    
    //MARK:- Vars
    var cityName: String?
    let cityScreenVM = CityScreenVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = cityName ?? ""
        
        cityScreenVM.getCityWeatherData(for: name) {  [weak self] (status, weatherData) in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.lblCityName.text = name
                self.lblTemperature.text = String(self.cityScreenVM.temperature) + "°"
                self.lblTemperatureMin.text = "⬇️" +  String(self.cityScreenVM.temperatureMin) + "°"
                self.lblTemperatureMax.text = "⬆️" +  String(self.cityScreenVM.temperatureMax) + "°"
                self.lblDescription.text = self.cityScreenVM.description
                self.lblFeelsLike.text = "Feels Like " + String(self.cityScreenVM.feelsLike)
                self.lblWind.text = "Wind " + String(self.cityScreenVM.wind)
            }
            
        } failureHandler: { (status, error) in
            Logger.printMessage(message: error.localizedDescription)
            
            switch error {
                case .apiError:
                    self.showAlert(title: "Invalid Location", message: "Unable to fetch data")
                case .genericError:
                    self.showAlert(title: "Invalid Location", message: "Some unknown error")
                case .invalidResponse:
                    self.showAlert(title: "Invalid Location", message: "Invalid response")
                case .noData:
                    self.showAlert(title: "Invalid Location", message: "No valid data")
                default:
                    self.showAlert(title: "Invalid Location", message: "Unable to fetch data")
                    
            }
            
            
        }

        
        
//
//
////        let smallSymbolImage = UIImage(systemName: "square.and.pencil")
//
//        cityScreenVM.updateClosure = { [weak self] in
//            guard let self = self else { return }
//
//            DispatchQueue.main.async {
//                self.lblCityName.text = name
//                self.lblTemperature.text = String(self.cityScreenVM.temperature)
//                self.lblTemperatureMin.text = String(self.cityScreenVM.temperatureMin)
//                self.lblTemperatureMax.text = String(self.cityScreenVM.temperatureMax)
//            }
//        }
//
//        cityScreenVM.errorClosure = { [weak self] (error) in
//            guard let self = self else { return }
//
////            DispatchQueue.main.async {
//            print(error)
//
//
////            }
//        }
//
        
    }


}


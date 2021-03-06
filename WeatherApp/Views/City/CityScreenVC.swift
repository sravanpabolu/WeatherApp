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
    var location: BookmarkedLocation?
    let cityScreenVM = CityScreenVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cityname = location?.name else {
            return
        }
        getCityWeatherData(cityname)
    }
    
    private func getCityWeatherData(_ name: String) {
        LoadingIndicator.shared.showLoader(on: self.view)
        
        guard let location = location else {
            return
        }
        
        cityScreenVM.getCityWeatherData(for: location) { [weak self] (result) in
            guard let self = self else { return }
            
            Queue.main {
                LoadingIndicator.shared.dismissLoader()
            }
            
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.lblCityName.text = name
                        self.lblTemperature.text = String(self.cityScreenVM.temperature) + "°"
                        self.lblTemperatureMin.text = "⬇️" +  String(self.cityScreenVM.temperatureMin) + "°"
                        self.lblTemperatureMax.text = "⬆️" +  String(self.cityScreenVM.temperatureMax) + "°"
                        self.lblDescription.text = self.cityScreenVM.description
                        self.lblFeelsLike.text = "Feels Like " + String(self.cityScreenVM.feelsLike)
                        self.lblWind.text = "Wind " + String(self.cityScreenVM.wind)
                    }
                case .failure(let error):
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
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
            }
        }
    }
}

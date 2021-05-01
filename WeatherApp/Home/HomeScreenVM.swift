//
//  HomeScreenVM.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation
import CoreData

class HomeScreenVM {
    var cities: [String] = [String]()
    
    func fetchCities() throws {
        do {
            let citiesObjects: [NSManagedObject] = try DBManager.shared.getCities()
            for aCityObject in citiesObjects {
                if let cityName = aCityObject.value(forKey: Constants.attrCityName){
                    cities.append(cityName as! String)
                }
            }
        } catch {
            throw error
        }
    }
    
    func insertCity(name: String) throws {
        do {
            try DBManager.shared.insertCity(name: name)
        } catch {
            throw error
        }
    }
    
    func deleteCity(name: String) throws {
        try DBManager.shared.deleteCity(name: name)
    }
}

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
        let citiesObjects: [NSManagedObject] = try DBManager.shared.getCities()
        for aCityObject in citiesObjects {
            if let cityName = aCityObject.value(forKey: Constants.attrCityName){
                cities.append(cityName as! String)
            }
        }
    }
    
    func insertCity(name: String) throws {
        cities.append(name)
        try DBManager.shared.insertCity(name: name, isUserChoice: true)
    }
    
    func deleteCity(at index: Int) throws {
        guard cities.count > index else { return }
        cities.remove(at: index)
        try DBManager.shared.deleteCity(name: cities[index])
    }
}

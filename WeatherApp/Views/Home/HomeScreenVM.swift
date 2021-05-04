//
//  HomeScreenVM.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation
import CoreData

class HomeScreenVM {
    var cities: [BookmarkedLocation] = [BookmarkedLocation]()
    
    func fetchCities() throws {
        let citiesObjects: [NSManagedObject] = try DBManager.shared.getCities()
        for aCityObject in citiesObjects {
            let aLocation = BookmarkedLocation(name: aCityObject.value(forKey: Constants.attrCityName) as? String ?? "",
                                               locality: aCityObject.value(forKey: Constants.attrlocality) as? String ?? "",
                                               subLocality: aCityObject.value(forKey: Constants.attrSubLocality) as? String ?? "",
                                               adminArea: aCityObject.value(forKey: Constants.attrAdminArea) as? String ?? "" ,
                                               lat: aCityObject.value(forKey: Constants.attrLat) as? Double ?? 0.0,
                                               long: aCityObject.value(forKey: Constants.attrLong) as? Double ?? 0.0
            )
            cities.append(aLocation)
        }
    }
    
    func insertCity(location: BookmarkedLocation) throws {
        cities.append(location)
        try DBManager.shared.insertCity(location: location, isUserChoice: true)
    }
    
    func deleteCity(at index: Int) throws {
        guard cities.count > index else { return }
        try DBManager.shared.deleteCity(location: cities[index])
        cities.remove(at: index)
    }
}

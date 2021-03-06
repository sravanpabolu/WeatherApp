//
//  DBManager.swift
//  WeatherApp
//
//  Created by Sravan Kumar Pabolu on 01/05/21.
//

import Foundation
import CoreData

// MARK: - Core Data stack
class DBManager {
    
    //MARK: - properties
    static let shared = DBManager()
    
    var cities: [NSManagedObject] = []
    var settings: [NSManagedObject] = []
    
    // MARK: - Core Data Properties/methods
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Logger.printMessage(message: "Unresolved error \(error), \(error.userInfo)", request: "Coredata configuration error")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw CustomError.genericError(message: error.localizedDescription)
            }
        }
    }
}

extension DBManager {
    func insertCity(location: BookmarkedLocation, isUserChoice: Bool) throws {
        let managedContext = self.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.citiesEntityName, in: managedContext) else {
            throw CustomError.genericError(message: "Unable to fetch Entity")
        }
        
        let city = NSManagedObject(entity: entity, insertInto: managedContext)
        
        city.setValue(location.name, forKey: Constants.attrCityName)
        city.setValue(location.adminArea, forKey: Constants.attrAdminArea)
        city.setValue(location.locality, forKey: Constants.attrlocality)
        city.setValue(location.subLocality, forKey: Constants.attrSubLocality)
        city.setValue("\(String(describing: location.lat))", forKey: Constants.attrLat)
        city.setValue("\(String(describing: location.lat))", forKey: Constants.attrLong)
        city.setValue(isUserChoice, forKeyPath: Constants.attrIsDefault)
        
        do {
            try managedContext.save()
            cities.append(city)
        } catch let error as NSError {
            let errorMessage = "Could not save. \(error), \(error.userInfo)"
            Logger.printMessage(message: errorMessage, request: "DB Save Error")
            throw CustomError.dbSaveError
        }
    }
    
    func deleteCity(location: BookmarkedLocation) throws {
        guard let name = location.name else {
            throw CustomError.genericError(message: "Unable to delete location?")
        }
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.citiesEntityName)
        fetchRequest.predicate = NSPredicate.init(format: "\(Constants.attrCityName) == %@", name)

        do {
            cities = try managedContext.fetch(fetchRequest)
            for city in cities {
                managedContext.delete(city)
            }
            try saveContext()
        } catch let error as NSError {
            Logger.printMessage(message: "Could not fetch. \(error), \(error.userInfo)", request: "Delete City")
            throw CustomError.genericError(message: error.localizedDescription)
        }
    }
    
    func getCities() throws -> [NSManagedObject] {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.citiesEntityName)
        
        do {
            cities = try managedContext.fetch(fetchRequest)
            Logger.printMessage(message: cities, request: "Fetched Cities")
            return cities
        } catch let error as NSError {
            Logger.printMessage(message: "Could not fetch. \(error), \(error.userInfo)", request: "getCities")
            throw CustomError.genericError(message: error.localizedDescription)
        }
    }
}

extension DBManager {
    func updateUnitSettings(isMetric: Units) throws {
        let managedContext = self.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.entitySettings, in: managedContext) else {
            throw CustomError.genericError(message: "Unable to fetch Entity")
        }
        
        let setting = (isMetric == .metric) ? true : false
        let settings = NSManagedObject(entity: entity, insertInto: managedContext)
        settings.setValue(setting, forKey: Constants.attrIsMetric)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            let errorMessage = "Could not save. \(error), \(error.userInfo)"
            Logger.printMessage(message: errorMessage, request: "DB Save Error")
            throw CustomError.dbSaveError
        }
    }
    
    func getSettings() throws -> [NSManagedObject] {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Constants.entitySettings)
        
        do {
            settings = try managedContext.fetch(fetchRequest)
            return settings
        } catch let error as NSError {
            Logger.printMessage(message: "Could not fetch. \(error), \(error.userInfo)", request: "Get Settings")
            throw CustomError.genericError(message: error.localizedDescription)
        }
    }
}

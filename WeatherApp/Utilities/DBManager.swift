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
    func insertCity(name: String) throws {
        let managedContext = self.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.citiesEntityName, in: managedContext) else {
            throw CustomError.genericError(message: "Unable to fetch Entity")
        }
        
        let city = NSManagedObject(entity: entity, insertInto: managedContext)
        
        city.setValue(name, forKey: Constants.attrCityName)
        city.setValue(false, forKeyPath: Constants.attrIsDefault)
        
        do {
            try managedContext.save()
            cities.append(city)
        } catch let error as NSError {
            let errorMessage = "Could not save. \(error), \(error.userInfo)"
            Logger.printMessage(message: errorMessage, request: "DB Save Error")
            throw CustomError.dbSaveError
        }
    }
    
    func deleteCity(name: String) throws {
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
            return cities
        } catch let error as NSError {
            Logger.printMessage(message: "Could not fetch. \(error), \(error.userInfo)", request: "getCities")
            throw CustomError.genericError(message: error.localizedDescription)
        }
    }
}

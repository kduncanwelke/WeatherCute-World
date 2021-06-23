//
//  CoreDataManager.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/23/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    lazy var managedObjectContext: NSManagedObjectContext = { [unowned self] in
        var container = self.persistentContainer
        return container.viewContext
        }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        var container = NSPersistentContainer(name: "SavedData")
        
        container.loadPersistentStores() { storeDescription, error in
            if var error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
            
            storeDescription.shouldInferMappingModelAutomatically = true
            storeDescription.shouldMigrateStoreAutomatically = true
        }
        
        return container
    }()
}

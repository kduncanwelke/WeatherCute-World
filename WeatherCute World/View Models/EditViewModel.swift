//
//  EditViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/22/21.
//

import Foundation
import CoreData

public class EditViewModel {
    
    func getTotalLocations() -> Int {
        return WeatherLocations.list.count
    }
    
    func getPlaceName(index: Int) -> String {
        return WeatherLocations.list[index]
    }
    
    func removeLocation(index: Int) {
        WeatherLocations.list.remove(at: index)
        
        deleteLocation(index: index)
        
        // locations changed, re-fetch data to match up with new order
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "retrieveData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getPrevPage"), object: nil)
    }
    
    func swap(source: Int, destination: Int) {
        var swapping = WeatherLocations.list.remove(at: source)
        WeatherLocations.list.insert(swapping, at: destination)
        
        resaveLocations()
        
        // order was changed, re-fetch data to match up with new order
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "retrieveData"), object: nil)
    }
    
    func deleteLocation(index: Int) {
        var managedContext = CoreDataManager.shared.managedObjectContext
        
        managedContext.delete(WeatherLocations.loaded[index])
        
        do {
            try managedContext.save()
            print("delete successful")
        } catch {
            print("Failed to save")
        }
    }
    
    func resaveLocations() {
        var managedContext = CoreDataManager.shared.managedObjectContext
        
        let locationsList = WeatherLocations.loaded
        
        var i = 0
        
        for location in locationsList {
            // reassign names to correct order after swap
            location.name = WeatherLocations.list[i]
            
            i += 1
        }
        
        do {
            try managedContext.save()
            print("resaved")
        } catch {
            // this should never be displayed but is here to cover the possibility
            //showAlert(title: "Save failed", message: "Notice: Data has not successfully been saved.")
        }
    }
}

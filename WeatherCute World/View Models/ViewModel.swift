//
//  ViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/12/21.
//

import Foundation
import CoreData

public class ViewModel {
    
    func setUpNetworkMonitor() {
        NetworkMonitor.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("connection successful")
                NetworkMonitor.connection = true
                
                // if network available, check if status had been lost
                if NetworkMonitor.status == .lost {
                    // if so, refresh data
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "retrieveData"), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "returned"), object: nil)
                    }
                }
                
                NetworkMonitor.status = .normal
            } else if path.status == .unsatisfied {
                print("no connection")
                NetworkMonitor.connection = false
                NetworkMonitor.status = .lost
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fail"), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkWhoops"), object: nil)
                    
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        NetworkMonitor.monitor.start(queue: queue)
    }
    
    func changeUnit(index: Int) {
        if index == 0 {
            Temp.currentUnit = .fahrenheit
        } else {
            Temp.currentUnit = .celsius
        }
        
        saveUnit(segment: index)
    }
    
    func getSegment() -> Int {
        switch Temp.currentUnit {
        case .fahrenheit:
            return 0
        case .celsius:
            return 1
        }
    }
    
    func getAll() {
        var index = 0
        
        for location in WeatherLocations.list {
            SearchParameters.query = location
            getWeatherData(index: index)
            getAstroData(index: index)
            index += 1
        }
        
        // create page controller pages after data load
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addPage"), object: nil)
    }
    
    func getWeatherData(index: Int) {
        DataManager<ConditionData>.fetch() { result in
            print("fetch")
            switch result {
            case .success(let response):
                WeatherLocations.locationWeather[index] = response
                print(response)
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshContent"), object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAstroData(index: Int) {
        assignCurrentDate()
        
        DataManager<AstronomyCurrent>.fetch() { result in
            print("fetch")
            switch result {
            case .success(let response):
                WeatherLocations.locationAstro[index] = response
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // make sure string date used for astro search is today
    func assignCurrentDate() {
        let dateToday = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let stringToday = dateFormatter.string(from: dateToday)
        SearchParameters.date = stringToday
    }
    
    func getCurrentPage() -> Int {
        return PageManager.currentPage
    }
    
    func getWeatherLocationTotal() -> Int {
        return WeatherLocations.list.count
    }
    
    func loadLocations() {
        var managedContext = CoreDataManager.shared.managedObjectContext
        var fetchRequest = NSFetchRequest<LocationSave>(entityName: "LocationSave")
        
        do {
            WeatherLocations.loaded = try managedContext.fetch(fetchRequest)
            print("locations loaded")
            
            for location in WeatherLocations.loaded {
                WeatherLocations.list.append(location.name ?? "")
            }
            
            getAll()
        } catch let error as NSError {
            //showAlert(title: "Could not retrieve data", message: "\(error.userInfo)")
        }
    }
    
    func loadUnit() {
        var managedContext = CoreDataManager.shared.managedObjectContext
        var fetchRequest = NSFetchRequest<UnitSave>(entityName: "UnitSave")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            Temp.loaded = result.first
            print("unit loaded")
            
            if let unit = Temp.loaded {
                if let loadedValue = TemperatureUnit(rawValue: Int(unit.which)) {
                    Temp.currentUnit = loadedValue
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateSegment"), object: nil)
                }
            }
        } catch let error as NSError {
            //showAlert(title: "Could not retrieve data", message: "\(error.userInfo)")
        }
    }
    
    func saveUnit(segment: Int) {
        var managedContext = CoreDataManager.shared.managedObjectContext
        
        guard let currentSave = Temp.loaded else {
            let unitSave = UnitSave(context: managedContext)
            
            unitSave.which = Int16(segment)
            
            do {
                try managedContext.save()
                print("unit saved")
            } catch {
                // this should never be displayed but is here to cover the possibility
                //showAlert(title: "Save failed", message: "Notice: Data has not successfully been saved.")
            }
            
            return
        }
        
        currentSave.which = Int16(segment)
        
        do {
            try managedContext.save()
            print("unit resaved")
        } catch {
            // this should never be displayed but is here to cover the possibility
            //showAlert(title: "Save failed", message: "Notice: Data has not successfully been saved.")
        }
    }
}

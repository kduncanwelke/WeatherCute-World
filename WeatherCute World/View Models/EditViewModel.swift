//
//  EditViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/22/21.
//

import Foundation

public class EditViewModel {
    
    func getTotalLocations() -> Int {
        return WeatherLocations.list.count
    }
    
    func getPlaceName(index: Int) -> String {
        return WeatherLocations.list[index]
    }
    
    func removeLocation(index: Int) {
        WeatherLocations.list.remove(at: index)
        
        // FIXME: Core data
        
        // locations changed, re-fetch data to match up with new order
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "retrieveData"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getPrevPage"), object: nil)
    }
    
    func swap(source: Int, destination: Int) {
        var swapping = WeatherLocations.list.remove(at: source)
        WeatherLocations.list.insert(swapping, at: destination)
        
        // FIXME: Core dara
        
        // order was changed, re-fetch data to match up with new order
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "retrieveData"), object: nil)
    }
}

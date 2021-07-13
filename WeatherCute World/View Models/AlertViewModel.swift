//
//  AlertViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/21/21.
//

import Foundation

public class AlertViewModel {
    
    var alertIndex = 0
    
    func goForward() -> Bool {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            if alertIndex < alerts.alert.count-1 {
                alertIndex += 1
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func goBack() -> Bool {
        if alertIndex > 0 {
            alertIndex -= 1
            return true
        } else {
           return false
        }
    }
    
    func enableBackButton() -> Bool {
        if alertIndex == 0 {
            return false
        } else {
            return true
        }
    }
    
    func enableNextButton() -> Bool {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            if alertIndex == (alerts.alert.count - 1) || alerts.alert.count == 1 {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    func getEventText() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].event
        } else {
            return "No data"
        }
    }
    
    func getSeverity() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].severity
        } else {
            return "No data"
        }
    }
    
    func getCertainty() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].certainty
        } else {
            return "No data"
        }
    }
    
    func getUrgency() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].urgency
        } else {
            return "No data"
        }
    }
    
    func getHeadline() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].headline
        } else {
            return "No data"
        }
    }
    
    func getAreas() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].areas
        } else {
            return "No data"
        }
    }
    
    func getDescription() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            return alerts.alert[alertIndex].desc
        } else {
            return "No data"
        }
    }
    
    func getInstruction() -> String {
        if let alerts = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            if alerts.alert[alertIndex].instruction == "" {
                return "No instructions"
            } else {
                return alerts.alert[alertIndex].instruction
            }
        } else {
            return "No data"
        }
    }
}

//
//  ViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/12/21.
//

import Foundation

public class ViewModel {
    
    func changeUnit(index: Int) {
        if index == 0 {
            Temp.currentUnit = .fahrenheit
        } else {
            Temp.currentUnit = .celsius
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
    }
    
    func getWeatherData(index: Int) {
        DataManager<ConditionData>.fetch() { [weak self] result in
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
        
        DataManager<AstronomyCurrent>.fetch() { [weak self] result in
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
}

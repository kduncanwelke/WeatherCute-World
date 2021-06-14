//
//  ViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/12/21.
//

import Foundation

public class ViewModel {
    
    // add selected location
    func addLocation() {
        WeatherLocations.list.append(SearchParameters.query)
        
        // FIXME: add core data save
    }
    
    func checkIsLocationValid(parameter: String) {
        SearchParameters.query = parameter
        
        DataManager<ConditionData>.fetch() { [weak self] result in
            print("fetch")
            switch result {
            case .success(let response):
                self?.validity(isValid: true)
                print(response)
            case .failure(let error):
                self?.validity(isValid: false)
                print(error)
            }
        }
    }
    
    func validity(isValid: Bool) {
        if isValid {
            // FIXME: toggle ability to add location
            print("found valid location/data")
        } else {
            // FIXME: supply failure message
            print("could not find location/data")
        }
    }
    
    func getAll() {
        for location in WeatherLocations.list {
            var index = 0
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
}

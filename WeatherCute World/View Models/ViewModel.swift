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
    
    func search(parameter: String) {
        SearchParameters.query = parameter
        
        DataManager<SearchResult>.fetchArray() { [weak self] result in
            print("fetch")
            switch result {
            case .success(let response):
                print(response)
                SearchParameters.searchResults = response
            case .failure(let error):
                print(error)
            }
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
    
    func getCurrentPage() -> Int {
        return PageManager.currentPage
    }
    
    func getWeatherLocationTotal() -> Int {
        return WeatherLocations.list.count
    }
}

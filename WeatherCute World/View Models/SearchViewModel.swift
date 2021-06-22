//
//  SearchViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/22/21.
//

import Foundation

public class SearchViewModel {
    
    private let viewModel = ViewModel()
    
    func getResultCount() -> Int {
        return SearchParameters.searchResults.count
    }
    
    func getLocationName(index: Int) -> String {
        var place = SearchParameters.searchResults[index].name
        return place
    }
    
    func addSelectedLocation(index: Int) {
        WeatherLocations.list.append(SearchParameters.searchResults[index].name)
        
        viewModel.getWeatherData(index: WeatherLocations.list.count-1)
        viewModel.getAstroData(index: WeatherLocations.list.count-1)
        
        // FIXME: Add core data save
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addPage"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getNextPage"), object: nil)
    }
    
    func search(parameter: String) {
        SearchParameters.query = parameter
        
        DataManager<SearchResult>.fetchArray() { [weak self] result in
            print("fetch")
            switch result {
            case .success(let response):
                print(response)
                SearchParameters.searchResults = response
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showResults"), object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func clearSearch() {
        SearchParameters.query = ""
        SearchParameters.searchResults.removeAll()
    }
}

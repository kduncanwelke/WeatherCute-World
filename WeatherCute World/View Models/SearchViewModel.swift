//
//  SearchViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/22/21.
//

import Foundation
import CoreData

public class SearchViewModel {
    
    private let viewModel = ViewModel()
    
    func getResultCount() -> Int {
        return SearchParameters.searchResults.count
    }
    
    func getLocationName(index: Int) -> String {
        var city = SearchParameters.searchResults[index].name
        var region = SearchParameters.searchResults[index].region
        var country = SearchParameters.searchResults[index].country
        var place = "\(city), \(region), \(country)"
        
        return place
    }
    
    func addSelectedLocation(index: Int) {
        // retrieve data from api
        WeatherLocations.list.append(SearchParameters.searchResults[index].name)
        viewModel.getWeatherData(index: WeatherLocations.list.count-1)
        viewModel.getAstroData(index: WeatherLocations.list.count-1)
        print(WeatherLocations.list)
        saveLocation(name: SearchParameters.searchResults[index].name)
    }
    
    func search(parameter: String) {
        SearchParameters.query = parameter
        
        DataManager<SearchResult>.fetchArray() { result in
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
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fail"), object: nil)
                }
            }
        }
    }
    
    func clearSearch() {
        SearchParameters.query = ""
        SearchParameters.searchResults.removeAll()
    }
    
    func saveLocation(name: String) {
        var managedContext = CoreDataManager.shared.managedObjectContext
        
        let newLocation = LocationSave(context: managedContext)
        
        newLocation.name = name

        WeatherLocations.loaded.append(newLocation)
        
        do {
            try managedContext.save()
            print("saved")
        } catch {
            // this should never be displayed but is here to cover the possibility
            //showAlert(title: "Save failed", message: "Notice: Data has not successfully been saved.")
        }

        // add page to page controller, refresh page count etc
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addPage"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getNextPage"), object: nil)
    }
}

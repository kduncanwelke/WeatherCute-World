//
//  PageControllerViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/16/21.
//

import Foundation

public class PageControllerViewModel {
    
    func getWeatherLocationTotal() -> Int {
        return WeatherLocations.list.count
    }
    
    func getCurrentPage() -> Int {
        return PageManager.currentPage
    }
    
    func getPendingIndex() -> Int {
        return PageManager.pendingIndex
    }
    
    func setPendingPage(page: Int) {
        PageManager.pendingIndex = page
    }
    
    func setCurrentPage(page: Int) {
        PageManager.currentPage = page
    }
}

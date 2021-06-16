//
//  ContentViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/16/21.
//

import Foundation

public class ContentViewModel {
    
    func getLocationName() -> String {
        return WeatherLocations.list[PageManager.currentPage]
    }
}

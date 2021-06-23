//
//  TemperatureUnit.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/15/21.
//

import Foundation

enum TemperatureUnit: Int {
    case fahrenheit, celsius
}

struct Temp {
    static var currentUnit: TemperatureUnit = .fahrenheit
    
    static var loaded: UnitSave?
}

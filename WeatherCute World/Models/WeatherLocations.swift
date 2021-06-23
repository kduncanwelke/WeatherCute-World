//
//  WeatherLocations.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/14/21.
//

import Foundation
import CoreData

struct WeatherLocations {
    static var list: [String] = []
    // ["Corpus Christi", "El Paso", "54911"]
    
    static var locationWeather: [Int: ConditionData] = [:]
    static var locationAstro: [Int: AstronomyCurrent] = [:]
    
    static var loaded: [LocationSave] = []
}

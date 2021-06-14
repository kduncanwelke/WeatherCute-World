//
//  WeatherLocations.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/14/21.
//

import Foundation

struct WeatherLocations {
    static var list: [String] = ["El Paso", "54911"]
    
    static var locationWeather: [Int: ConditionData] = [:]
    static var locationAstro: [Int: AstronomyCurrent] = [:]
}

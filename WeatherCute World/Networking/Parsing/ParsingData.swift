//
//  Current.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/11/21.
//

import Foundation

struct ConditionData: SearchType {
    static var endpoint = Endpoint.forecast
    
    var location: Location
    var current: CurrentConditions
    var forecast: Forecast
    var alerts: Alerts
}

struct AstronomyCurrent: SearchType {
    static var endpoint = Endpoint.astronomy
    
    var location: Location
    var astronomy: Astronomy
}

struct Location: Decodable {
    var name: String
    var region: String
    var country: String
    var localtime: String
}

struct CurrentConditions: Decodable {
    var tempC: Double
    var tempF: Double
    var isDay: Int
    var condition: Condition
    var windMph: Double
    var windKph: Double
    var pressureMb: Double
    var pressureIn: Double
    var humidity: Int
    var feelslikeC: Double
    var feelslikeF: Double
    var uv: Double
    var gustMph: Double
    var gustKph: Double
    var airQuality: AirQuality
}

struct Condition: Decodable {
    var text: String
    var icon: String
}

struct AirQuality: Decodable {
    var co: Double
    var no2: Double
    var o3: Double
    var so2: Double
    var pm25: Double
    var pm10: Double
}

struct Forecast: Decodable {
    var forecastday: [ForecastData]
}

struct ForecastData: Decodable {
    var day: Day
    var astro: Astro
}

struct Alerts: Decodable {
    var alert: [AlertData]
}

struct AlertData: Decodable {
    var headline: String
    var severity: String
    var urgency: String
    var areas: String
    var certainty: String
    var event: String
    var effective: String
    var expires: String
    var desc: String
    var instruction: String
}

struct Day: Decodable {
    var maxtempC: Double
    var maxtempF: Double
    var avgtempC: Double
    var avgtempF: Double
    var mintempC: Double
    var mintempF: Double
    var maxwindKph: Double
    var maxwindMph: Double
    var avghumidity: Double
    var dailyChanceOfRain: String
    var dailyChanceOfSnow: String
    var condition: Condition
    var uv: Double
}

struct Astronomy: Decodable {
    var astro: Astro
}

struct Astro: Decodable {
    var sunrise: String
    var sunset: String
    var moonPhase: String
    var moonIllumination: String
}


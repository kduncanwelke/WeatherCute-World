//
//  Endpoint.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/11/21.
//

import Foundation

enum Endpoint {
    case forecast
    case astronomy
    case search
    
    private var baseURL: URL {
        return URL(string: "https://api.weatherapi.com/v1/")!
    }
    
    private var key: String {
        return ""
    }
    
    // generate url based on type
    func url() -> URL {
        switch self {
        case .forecast:
            var components = URLComponents(url: baseURL.appendingPathComponent("forecast.json"), resolvingAgainstBaseURL: false)
            
            components!.queryItems = [
                URLQueryItem(name: "key", value: "\(key)"),
                URLQueryItem(name: "q", value: "\(SearchParameters.query)"),
                URLQueryItem(name: "days", value: "3"),
                URLQueryItem(name: "aqi", value: "yes"),
                URLQueryItem(name: "alerts", value: "yes")
            ]
            
            return components!.url!
        case .astronomy:
            var components = URLComponents(url: baseURL.appendingPathComponent("astronomy.json"), resolvingAgainstBaseURL: false)
            
            components!.queryItems = [
                URLQueryItem(name: "key", value: "\(key)"),
                URLQueryItem(name: "q", value: "\(SearchParameters.query)"),
                URLQueryItem(name: "dt", value: "\(SearchParameters.date)"),
            ]
            
            return components!.url!
        case .search:
            var components = URLComponents(url: baseURL.appendingPathComponent("search.json"), resolvingAgainstBaseURL: false)
            
            components!.queryItems = [
                URLQueryItem(name: "key", value: "\(key)"),
                URLQueryItem(name: "q", value: "\(SearchParameters.query)")
            ]
            
            return components!.url!
        }
    }
}

//
//  SearchType.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/11/21.
//

import Foundation

// protocol for requests, used for generics in data manager
protocol SearchType: Decodable {
    static var endpoint: Endpoint { get }
}

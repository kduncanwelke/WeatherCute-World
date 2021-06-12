//
//  Result.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/11/21.
//

import Foundation

// enum to manage results from data manager
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

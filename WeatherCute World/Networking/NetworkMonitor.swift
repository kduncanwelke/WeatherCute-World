//
//  NetworkMonitor.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/11/21.
//

import Foundation
import Network

struct NetworkMonitor {
    
    static let monitor = NWPathMonitor()
    static var connection = true
    
    static var status: NetworkStatus = .normal
    static var prevStatus: NetworkStatus = .normal
    
    enum NetworkStatus {
        case normal
        case lost
        case other
    }
}

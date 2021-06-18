//
//  ForecastCollectionViewCell.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/18/21.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var uv: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var rainChance: UILabel!
    @IBOutlet weak var snowChance: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var moonrise: UILabel!
    @IBOutlet weak var moonset: UILabel!
    @IBOutlet weak var phase: UILabel!
    @IBOutlet weak var illumination: UILabel!
}

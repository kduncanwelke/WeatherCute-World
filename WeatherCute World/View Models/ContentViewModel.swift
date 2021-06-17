//
//  ContentViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/16/21.
//

import Foundation
import UIKit

public class ContentViewModel {
    
    func getLocationName() -> String {
        if let location = WeatherLocations.locationWeather[PageManager.currentPage]?.location {
            return location.name
        } else {
            return "Unknown"
        }
    }
    
    func getLocationTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = "MMM dd, hh:mma"
        
        let metricyStringDateFormatter = DateFormatter()
        metricyStringDateFormatter.dateFormat = "dd MMM, HH:mm"
        
        if let location = WeatherLocations.locationWeather[PageManager.currentPage]?.location {
            
            if let changed = dateFormatter.date(from: location.localtime) {
                switch Temp.currentUnit {
                case .fahrenheit:
                    let stringy = stringDateFormatter.string(from: changed)
                    return stringy
                case .celsius:
                    let stringy = metricyStringDateFormatter.string(from: changed)
                    return stringy
                }
            } else {
                return "Unknown"
            }
        } else {
            return "Unknown"
        }
    }
    
    func getCurrentCondition() -> String {
        return WeatherLocations.locationWeather[PageManager.currentPage]?.current.condition.text ?? "No data"
    }
    
    func getTemperature() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(current.tempF))°F"
            case .celsius:
                return "\(Int(current.tempC))°C"
            }
        } else {
            return "No data"
        }
    }
    
    func getFeelsLike() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(current.feelslikeF))°F"
            case .celsius:
                return "\(Int(current.feelslikeC))°C"
            }
        } else {
            return "No data"
        }
    }
    
    func getHumidity() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            return "\(Int(current.humidity))%"
        } else {
            return "No data"
        }
    }
    
    func getUV() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            return "\(Int(current.uv))"
        } else {
            return "No data"
        }
    }
    
    func getPressure() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(current.pressureIn))in"
            case .celsius:
                return "\(Int(current.pressureMb))mb"
            }
        } else {
            return "No data"
        }
    }
    
    func getWind() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(current.windMph))mph"
            case .celsius:
                return "\(Int(current.windKph))kph"
            }
        } else {
            return "No data"
        }
    }
    
    func getGust() -> String {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(current.gustMph))mph"
            case .celsius:
                return "\(Int(current.gustKph))kph"
            }
        } else {
            return "No data"
        }
    }
    
    func getSunrise() -> String {
        if let astronomy = WeatherLocations.locationAstro[PageManager.currentPage]?.astronomy {
            return astronomy.astro.sunrise
        } else {
            return "No data"
        }
    }
    
    func getSunset() -> String {
        if let astronomy = WeatherLocations.locationAstro[PageManager.currentPage]?.astronomy {
            return astronomy.astro.sunset
        } else {
            return "No data"
        }
    }
    
    func getMoonrise() -> String {
        if let astronomy = WeatherLocations.locationAstro[PageManager.currentPage]?.astronomy {
            return astronomy.astro.moonrise
        } else {
            return "No data"
        }
    }
    
    func getMoonset() -> String {
        if let astronomy = WeatherLocations.locationAstro[PageManager.currentPage]?.astronomy {
            return astronomy.astro.moonset
        } else {
            return "No data"
        }
    }
    
    func getMoonPhase() -> String {
        if let astronomy = WeatherLocations.locationAstro[PageManager.currentPage]?.astronomy {
            return astronomy.astro.moonPhase
        } else {
            return "No data"
        }
    }
    
    func getMoonIllumination() -> String {
        if let astronomy = WeatherLocations.locationAstro[PageManager.currentPage]?.astronomy {
            return "\(astronomy.astro.moonIllumination)%"
        } else {
            return "No data"
        }
    }
    
    func getWeatherImage() -> UIImage? {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.current {
            if current.isDay == 1 {
                // it is day
                return getDayImage(code: current.condition.code)
            } else {
                // it is night
                return getNightImage(code: current.condition.code)
            }
        } else {
            return UIImage(named: "none")
        }
    }
    
    func getDayImage(code: Int) -> UIImage? {
        if code == 1000 {
            return UIImage(named: "sunny")
        } else if code == 1003 {
            return UIImage(named: "partlycloudy")
        } else if code == 1006 || code == 1009 {
            return UIImage(named: "cloudy")
        } else if code == 1030 || code == 1135 || code == 1147 {
            return UIImage(named: "haze")
        } else if code == 1063 || code == 1150 || code == 1153 || code == 1180 || code == 1183 || code == 1186 || code == 1189 || code == 1192 || code == 1195 || code == 1240 || code == 1243 || code == 1246 {
            return UIImage(named: "rain")
        } else if code == 1066 || code == 1114 || code == 1210 || code == 1213 || code == 1216 || code == 1219 || code == 1222 || code == 1225 || code == 1255 || code == 1258 {
            return UIImage(named: "snow")
        } else if code == 1069 || code == 1072 || code == 1168 || code == 1171 || code == 1198 || code == 1201 || code == 1204 || code == 1207 || code == 1249 || code == 1252 {
            return UIImage(named: "sleet")
        } else if code == 1087 || code == 1273 || code == 1276 || code == 1279 {
            return UIImage(named: "thunderstorm")
        } else if code == 1117 {
            return UIImage(named: "blizzard")
        } else if code == 1237 || code == 1261 || code == 1264 {
            return UIImage(named: "mix")
        } else if code == 1279 || code == 1282 {
            // FIXME: add thundersnow icon
            return UIImage(named: "none")
        } else {
            return UIImage(named: "none")
        }
    }
    
    func getNightImage(code: Int) -> UIImage? {
        if code == 1000 {
            return UIImage(named: "nightsunny")
        } else if code == 1003 {
            return UIImage(named: "nightpartlycloudy")
        } else if code == 1006 || code == 1009 {
            return UIImage(named: "nightcloudy")
        } else if code == 1030 || code == 1135 || code == 1147 {
            return UIImage(named: "nighthaze")
        } else if code == 1063 || code == 1150 || code == 1153 || code == 1180 || code == 1183 || code == 1186 || code == 1189 || code == 1192 || code == 1195 || code == 1240 || code == 1243 || code == 1246 {
            return UIImage(named: "nightrain")
        } else if code == 1066 || code == 1114 || code == 1210 || code == 1213 || code == 1216 || code == 1219 || code == 1222 || code == 1225 || code == 1255 || code == 1258 {
            return UIImage(named: "nightsnow")
        } else if code == 1069 || code == 1072 || code == 1168 || code == 1171 || code == 1198 || code == 1201 || code == 1204 || code == 1207 || code == 1249 || code == 1252 {
            return UIImage(named: "nightsleet")
        } else if code == 1087 || code == 1273 || code == 1276 || code == 1279 {
            return UIImage(named: "nightthunderstorm")
        } else if code == 1117 {
            return UIImage(named: "nightblizzard")
        } else if code == 1237 || code == 1261 || code == 1264 {
            return UIImage(named: "nightmix")
        } else if code == 1279 || code == 1282 {
            // FIXME: add thundersnow icon
            return UIImage(named: "none")
        } else {
            return UIImage(named: "none")
        }
    }
}

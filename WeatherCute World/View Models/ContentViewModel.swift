//
//  ContentViewModel.swift
//  WeatherCute World
//
//  Created by Kate Duncan-Welke on 6/16/21.
//

import Foundation
import UIKit

public class ContentViewModel {
    
    private let viewModel = ViewModel()
    
    func isThereData() -> Bool {
        if WeatherLocations.locationWeather.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func hasNetwork() -> Bool {
        return NetworkMonitor.connection
    }
    
    func refreshData() {
        // retrieve anew when page is refreshed
        var index = PageManager.currentPage
        SearchParameters.query = WeatherLocations.list[index]
      
        viewModel.getWeatherData(index: index)
        viewModel.getAstroData(index: index)
    }
    
    func getLocationName() -> String {
        if let location = WeatherLocations.locationWeather[PageManager.currentPage]?.location {
            return location.name
        } else {
            return "Unknown"
        }
    }
    
    func hideAlertButton() -> Bool {
        if let current = WeatherLocations.locationWeather[PageManager.currentPage]?.alerts {
            if current.alert.isEmpty {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    func getLocationTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = "MMM dd, hh:mma"
        
        let metricyStringDateFormatter = DateFormatter()
        metricyStringDateFormatter.dateFormat = "dd MMM, hh:mma"
        
        if let location = WeatherLocations.locationWeather[PageManager.currentPage]?.location {
            
            if let changed = dateFormatter.date(from: location.localtime) {
                switch Temp.currentUnit {
                case .fahrenheit:
                    // US style date format
                    let stringy = stringDateFormatter.string(from: changed)
                    return stringy
                case .celsius:
                    // metric style date format
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
    
    func getCarbonDioxide() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            return "\(Int(airQuality.co))μg/m3"
        } else {
            return "No data"
        }
    }
    
    func getOzone() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            return "\(Int(airQuality.o3))μg/m3"
        } else {
            return "No data"
        }
    }
    
    func getNitrogenDioxide() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            return "\(Int(airQuality.no2))μg/m3"
        } else {
            return "No data"
        }
    }
    
    func getSulphurDioxide() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            return "\(Int(airQuality.so2))μg/m3"
        } else {
            return "No data"
        }
    }
    
    func getPM2() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            return "\(Int(airQuality.pm25))μg/m3"
        } else {
            return "No data"
        }
    }
    
    func getPM10() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            return "\(Int(airQuality.pm10))μg/m3"
        } else {
            return "No data"
        }
    }
    
    func getAirQualityIndex() -> String {
        if let airQuality = WeatherLocations.locationWeather[PageManager.currentPage]?.current.airQuality {
            
            if airQuality.usEpaIndex == 1 {
                return "Good"
            } else if airQuality.usEpaIndex == 2 {
                return "Moderate"
            } else if airQuality.usEpaIndex == 3 {
                return "Unhealthy for sensitive individuals"
            } else if airQuality.usEpaIndex == 4 {
                return "Unhealthy"
            } else if airQuality.usEpaIndex == 5 {
                return "Very Unhealthy"
            } else if airQuality.usEpaIndex == 6 {
                return "Hazardous"
            } else {
                return "No data"
            }
            
        } else {
            return "No data"
        }
    }
    
    func getForecastTotal() -> Int {
        return WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday.count ?? 0
    }
    
    func getForecastDay(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index] {
            let day = forecast.date
            let forecastInfo = forecast.day.condition.text
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let stringDateFormatter = DateFormatter()
            stringDateFormatter.dateFormat = "EEEE"
            
            if let changed = dateFormatter.date(from: day) {
                return "\(stringDateFormatter.string(from: changed)) - \(forecastInfo) "
            } else {
                return "No data"
            }
        } else {
            return "No data"
        }
    }
    
    func getForecastTemp(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(forecast.avgtempF))°F"
            case .celsius:
                return "\(Int(forecast.avgtempC))°C"
            }
        } else {
            return "No data"
        }
    }
    
    func getForecastHumidity(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            return "\(Int(forecast.avghumidity))%"
        } else {
            return "No data"
        }
    }
    
    func getRainChance(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            return "\(forecast.dailyChanceOfRain)% chance"
        } else {
            return "No data"
        }
    }
    
    func getSnowChance(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            return "\(forecast.dailyChanceOfSnow)% chance"
        } else {
            return "No data"
        }
    }
    
    func getForecastUV(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            return "\(Int(forecast.uv))"
        } else {
            return "No data"
        }
    }
    
    func getSunrise(index: Int) -> String {
        if let astro = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].astro {
            return "\(astro.sunrise)"
        } else {
            return "No data"
        }
    }
    
    func getSunset(index: Int) -> String {
        if let astro = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].astro {
            return "\(astro.sunset)"
        } else {
            return "No data"
        }
    }
    
    func getMoonrise(index: Int) -> String {
        if let astro = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].astro {
            return "\(astro.moonrise)"
        } else {
            return "No data"
        }
    }
    
    func getMoonset(index: Int) -> String {
        if let astro = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].astro {
            return "\(astro.moonset)"
        } else {
            return "No data"
        }
    }
    
    func getMoonPhase(index: Int) -> String {
        if let astro = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].astro {
            return "\(astro.moonPhase)"
        } else {
            return "No data"
        }
    }
    
    func getMoonIllumination(index: Int) -> String {
        if let astro = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].astro {
            return "\(astro.moonIllumination)%"
        } else {
            return "No data"
        }
    }
    
    func getForecastWind(index: Int) -> String {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            switch Temp.currentUnit {
            case .fahrenheit:
                return "\(Int(forecast.maxwindMph))mph"
            case .celsius:
                return "\(Int(forecast.maxwindKph))kph"
            }
        } else {
            return "No data"
        }
    }
    
    func getForecastWeatherImage(index: Int) -> UIImage? {
        if let forecast = WeatherLocations.locationWeather[PageManager.currentPage]?.forecast.forecastday[index].day {
            return getDayImage(code: forecast.condition.code)
        } else {
            return UIImage(named: "none")
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
            return UIImage(named: "thundersnow")
        } else {
            return UIImage(named: "none")
        }
    }
}

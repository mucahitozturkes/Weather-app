//
//  WeatherModel.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import UIKit

struct Images {
    let brokenClouds    = ["broken clouds1", "broken clouds2", "broken clouds3"] // 803-804
    let clearSky        = ["clear sky1", "clear sky2", "clear sky3", "clear sky4", "clear sky5"] // 800
    let fewClouds       = ["few clouds1", "few clouds2"] // 801
    let highRain        = ["high rain1", "high rain2", "high rain3", "high rain4"] //500-531
    let mist            = ["mist1", "mist2"] //700-781
    let rain            = ["rain1", "rain2", "rain3"] //300-321
    let scatteredClouds = ["scattered clouds1", "scattered clouds2"] // 802
    let snow            = ["snow1", "snow2", "snow3", "snow4", "snow5"] //600-622
    let thunderstorm    = ["thunderstorm1", "thunderstorm2", "thunderstorm3", "thunderstorm4"] // 200-232
}

struct WeatherModel {
        
    let conditonId: Int
    let cityName: String
    let temperature: Float
    let descriptions: String
    let feelsLike: Float
    let humidity: Float
    let wind: Float
 
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var feelsLikeString: String {
        return String(format: "%.0fº", feelsLike)
    }
    var humidityString: String {
        return String(format: "%.0f%%", humidity)
    }
    var windString: String {
        return String(format: "%.0fkm/h", wind)
    }
    
     func getConditionName() -> String {
            switch conditonId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.sun"
                default:
                    return "cloud"
            }
        }
    
    func setBackgroundImageAsLabel() -> String {
        switch conditonId {
            case 800:
            return getNextCloudImage()
            case 200...232:
            return getNextCloudImage()
            case 300...321:
            return getNextCloudImage()
            case 500...531:
            return getNextCloudImage()
            case 600...622:
            return getNextCloudImage()
            case 701...781:
            return getNextCloudImage()
            case 801:
            return getNextCloudImage()
            case 802:
            return getNextCloudImage()
            case 803...804:
            return getNextCloudImage()
        default:
            return "clear sky2"
        }
    }

    func getNextCloudImage() -> String {
        var nextImageNumber = UserDefaults.standard.integer(forKey: "nextCloudImage")
        nextImageNumber += 1
        
        var maxImageNumber: Int
        var imageList: [String]
        
        switch conditonId {
        case 200...232:
            maxImageNumber = 4
            imageList = Images().thunderstorm
        case 300...321:
            maxImageNumber = 3
            imageList = Images().rain
        case 500...531:
            maxImageNumber = 4
            imageList = Images().highRain
        case 600...622:
            maxImageNumber = 5
            imageList = Images().snow
        case 700...781:
            maxImageNumber = 2
            imageList = Images().mist
        case 800:
            maxImageNumber = 5
            imageList = Images().clearSky
        case 801:
            maxImageNumber = 2
            imageList = Images().fewClouds
        case 802:
            maxImageNumber = 2
            imageList = Images().scatteredClouds
        case 803...804:
            maxImageNumber = 3
            imageList = Images().brokenClouds
        default:
            maxImageNumber = 1
            imageList = []
        }
        
        if nextImageNumber > maxImageNumber {
            nextImageNumber = 1
        }
        
        UserDefaults.standard.set(nextImageNumber, forKey: "nextCloudImage")
        return "\(imageList[nextImageNumber - 1])"
    }

}

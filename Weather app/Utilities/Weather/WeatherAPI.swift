//
//  IPAKey.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import Foundation
import CoreLocation

struct WeatherAPI {
    
    static var shared = WeatherAPI()
    
    var baseURL         = "https://api.openweathermap.org/data/2.5/weather?"
    var JSONKey         = SecureWeatherKey.JSONKey.APIKey
    var metric          = "&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(baseURL)q=\(cityName)&appid=\(JSONKey)\(metric)"
        
        WeatherNetworkManager.shared.performRequestWeather(with: urlString)
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(baseURL)lat=\(latitude)&lon=\(longitude)&appid=\(JSONKey)\(metric)"
        WeatherNetworkManager.shared.performRequestWeather(with: urlString)
    }
}

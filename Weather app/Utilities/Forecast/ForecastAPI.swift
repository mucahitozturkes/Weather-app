//
//  ForecastAPI.swift
//  Weather app
//
//  Created by mücahit öztürk on 17.03.2024.
//

import Foundation
import CoreLocation

struct ForecastAPI {

    static let shared = ForecastAPI()

    var baseURL             = "https://api.openweathermap.org/data/2.5/forecast?"
    let secureForecastKey   = SecureForecastKey.JSONKey.APIKey
    var metric              = "&units=metric"
    var appied              = "&appid="

    
    func fetchForecastCityName(cityName: String) {
        let urlString = baseURL + "q=\(cityName)" + appied + secureForecastKey + metric
        
        ForecastNetworkManager.shared.performRequestForecast(with: urlString)
    }

    func fetchCityLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {

        let urlString = baseURL + "lat=\(latitude)&lon=\(longitude)" + appied + secureForecastKey + metric

        ForecastNetworkManager.shared.performRequestForecast(with: urlString)
    }

}

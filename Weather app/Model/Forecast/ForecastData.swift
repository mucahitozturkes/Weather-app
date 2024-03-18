//
//  ForecastData.swift
//  Weather app
//
//  Created by mücahit öztürk on 17.03.2024.
//

import Foundation

struct ForecastData: Codable {
    let list: [ListItem]
   
   
}

struct ListItem: Codable {
    let dt_txt: String
    let main: MainItem
    let weather: [WeatherItem]
}


struct MainItem: Codable {
    let temp: Float
}

struct WeatherItem: Codable {
    let id: Float
}







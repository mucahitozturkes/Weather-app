//
//  WeatherData.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}


struct Main: Codable {
    let temp: Float
    let feels_like: Float
    let humidity: Float
}


struct Weather: Codable {
    let description: String
    let id: Int
}


struct Wind: Codable {
    let speed: Float
}



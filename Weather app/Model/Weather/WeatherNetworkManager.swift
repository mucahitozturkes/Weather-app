//
//  NetworkManager.swift
//  Weather app
//
//  Created by mücahit öztürk on 15.03.2024.
//

import Foundation


protocol NetworkManagerDelegate {
    func didUpdateWeather(_ weatherNetworkManager: WeatherNetworkManager, weather: WeatherModel)
    func didFailWithErrorWeather(error: Error)
}

class WeatherNetworkManager {
    
    static let shared = WeatherNetworkManager()
    
    var delegate: NetworkManagerDelegate?
    
    func performRequestWeather(with urlString: String) {
  
        if let url = URL(string: urlString) {
       
            
            let session = URLSession(configuration: .default)
      
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithErrorWeather(error: error!)
                    return
                }
             
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                       
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
                
            }
            
                task.resume()
            }
        }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
           
            let name        = decodedData.name
            let id          = decodedData.weather[0].id
            let temp        = decodedData.main.temp
            let description = decodedData.weather[0].description
            let feeling     = decodedData.main.feels_like
            let humidity    = decodedData.main.humidity
            let wind        = decodedData.wind.speed
         
            
            
            let weather = WeatherModel(conditonId: id, cityName: name, temperature: temp, descriptions: description, feelsLike: feeling, humidity: humidity, wind: wind)
            
           
            
            return weather
          
            
        } catch {
            delegate?.didFailWithErrorWeather(error: error)
            return nil
        }
    }
    
    


    
    
}

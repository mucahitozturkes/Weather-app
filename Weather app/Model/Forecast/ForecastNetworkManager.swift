//
//  ForecastNetworkManager.swift
//  Weather app
//
//  Created by mücahit öztürk on 17.03.2024.
//

import Foundation

protocol ForecastNetworkManagerDelegate {
    func didUpdateForecast(_ forecastNetworkManager: ForecastNetworkManager, forecast: ForecastModel)
    func didFailWithErrorForecast(error: Error)
}

class ForecastNetworkManager {
    
    static let shared = ForecastNetworkManager()
    
    var delegate: ForecastNetworkManagerDelegate?
    
    func performRequestForecast(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    self.delegate?.didFailWithErrorForecast(error: error!)
                    return
                }
                if let safeData = data {
                    if let forecast = self.parseJSONForecast(forecastData: safeData) {
                        
                        self.delegate?.didUpdateForecast(self, forecast: forecast)
                    }
                    
                }
                
            }
            task.resume()
            
        }
    }
    func parseJSONForecast(forecastData: Data) -> ForecastModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            
            var temps: [Float] = []
            var dates: [String] = []
            
            for item in decodedData.list {
                if item.dt_txt.hasSuffix("12:00:00") {
                    temps.append(item.main.temp)
                    dates.append(ForecastModel.formattedDateString(item.dt_txt))
                }
            }
            
            if temps.count >= 4 {
                let forecast = ForecastModel(temp1: temps[0], temp2: temps[1], temp3: temps[2], temp4: temps[3],
                                             dates1: dates[0], dates2: dates[1], dates3: dates[2], dates4: dates[3])
                return forecast
            } else {
                return nil
            }
            
        } catch {
            delegate?.didFailWithErrorForecast(error: error)
            return nil
        }
    }




   }

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
            
            let dates1 = ForecastModel.formattedDateString(decodedData.list[6].dt_txt)     //list[6].dt_txt
            let dates2 = ForecastModel.formattedDateString(decodedData.list[14].dt_txt)    //list[14].dt_txt
            let dates3 = ForecastModel.formattedDateString(decodedData.list[22].dt_txt)    //list[22].dt_txt
            let dates4 = ForecastModel.formattedDateString(decodedData.list[30].dt_txt)    //list[30].dt_txt
           
            
            let forecast = ForecastModel(dates1: dates1, dates2: dates2, dates3: dates3, dates4: dates4)
            
            return forecast
            
        } catch {
            delegate?.didFailWithErrorForecast(error: error)
            return nil
        }
    }

}


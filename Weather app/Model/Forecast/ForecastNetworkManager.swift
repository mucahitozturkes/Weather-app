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
            
            let date1 = ForecastModel.formattedDateString(decodedData.list[9].dt_txt)
            let date2 = ForecastModel.formattedDateString(decodedData.list[17].dt_txt)
            let date3 = ForecastModel.formattedDateString(decodedData.list[25].dt_txt)
            let date4 = ForecastModel.formattedDateString(decodedData.list[33].dt_txt)
            
            let id1   = decodedData.list[9].weather[0].id
            let id2   = decodedData.list[17].weather[0].id
            let id3   = decodedData.list[25].weather[0].id
            let id4   = decodedData.list[33].weather[0].id
            
            let temp1 = decodedData.list[9].main.temp
            let temp2 = decodedData.list[17].main.temp
            let temp3 = decodedData.list[25].main.temp
            let temp4 = decodedData.list[33].main.temp
    
    
            let forecast = ForecastModel(id1: id1, id2: id2, id3: id3, id4: id4, temp1: temp1, temp2: temp2, temp3: temp3, temp4: temp4, dates1: date1, dates2: date2, dates3: date3, dates4: date4)
            return forecast
            
        } catch {
            delegate?.didFailWithErrorForecast(error: error)
            return nil
        }
    }



   
   }




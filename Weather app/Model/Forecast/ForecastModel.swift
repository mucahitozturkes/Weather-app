//
//  ForecastModel.swift
//  Weather app
//
//  Created by mücahit öztürk on 17.03.2024.
//

import Foundation

struct ForecastModel {
    
    
    let dates1: String
    let dates2: String
    let dates3: String
    let dates4: String
    
    init(dates1: String, dates2: String, dates3: String, dates4: String) {
            self.dates1 = dates1
            self.dates2 = dates2
            self.dates3 = dates3
            self.dates4 = dates4
        }
        
     
        static func formattedDateString(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "dd EE"
                return dateFormatter.string(from: date)
            }
            return ""
        }
}

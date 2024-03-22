//
//  Date+Ext.swift
//  Weather app
//
//  Created by mücahit öztürk on 22.03.2024.
//

import Foundation

extension ForecastModel {
    static func formattedDateString(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "E dd"
        return dateFormatter.string(from: date)
    }
}

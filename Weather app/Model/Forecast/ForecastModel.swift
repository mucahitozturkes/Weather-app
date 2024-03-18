//
//  ForecastModel.swift
//  Weather app
//
//  Created by mücahit öztürk on 17.03.2024.
//

import Foundation

struct ForecastModel {
 
    
    let id1: Float
    let id2: Float
    let id3: Float
    let id4: Float
    
    func getConditionName(id: Float) -> String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
        default:
            return "cloud"
        }
    }
    
        var id1String: String { return String(format: "%.0f", id1) }
        var id2String: String { return String(format: "%.0f", id2) }
        var id3String: String { return String(format: "%.0f", id3) }
        var id4String: String { return String(format: "%.0f", id4) }
    
    
    let temp1: Float
    let temp2: Float
    let temp3: Float
    let temp4: Float
    
       var temp1String: String { return String(format: "%.0fº", temp1) }
       var temp2String: String { return String(format: "%.0fº", temp2) }
       var temp3String: String { return String(format: "%.0fº", temp3) }
       var temp4String: String { return String(format: "%.0fº", temp4) }
       
    
    let dates1: String
    let dates2: String
    let dates3: String
    let dates4: String
    
}

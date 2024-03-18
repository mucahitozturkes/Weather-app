//
//  ForecastModel.swift
//  Weather app
//
//  Created by mücahit öztürk on 17.03.2024.
//

import Foundation

struct ForecastModel {
    
    
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

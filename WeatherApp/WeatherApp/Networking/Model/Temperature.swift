//
//  Temperature.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation



struct Temperature {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve : Double
    let morn : Double
}

extension Temperature: Decodable {
    
    private enum TemperatureResponseCodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TemperatureResponseCodingKeys.self)
        
        day = try container.decode(Double.self, forKey: .day)
        min = try container.decode(Double.self, forKey: .min)
        max = try container.decode(Double.self, forKey: .max)
        night = try container.decode(Double.self, forKey: .night)
        eve = try container.decode(Double.self, forKey: .eve)
        morn = try container.decode(Double.self, forKey: .morn)
    }
}

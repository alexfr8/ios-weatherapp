//
//  Main.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

struct Main {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity : Double
    let temp_kf : Double
}

extension Main: Decodable {
    
    private enum MainResponseCodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MainResponseCodingKeys.self)
        
        temp = try container.decode(Double.self, forKey: .temp)
        temp_min = try container.decode(Double.self, forKey: .temp_min)
        temp_max = try container.decode(Double.self, forKey: .temp_max)
        pressure = try container.decode(Double.self, forKey: .pressure)
        sea_level = try container.decode(Double.self, forKey: .sea_level)
        grnd_level = try container.decode(Double.self, forKey: .grnd_level)
        humidity = try container.decode(Double.self, forKey: .humidity)
        temp_kf = try container.decode(Double.self, forKey: .temp_kf)
    }
}

//
//  Forecast7.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation



struct Forecast {
    let dt: Int
    let temp: Temperature
    let pressure: Double
    let humidity  : Int
    let weather : [Weather]
    let speed : Double
    let deg : Int
    let clouds : Int
    let snow : Double
}

extension Forecast: Decodable {
    
    private enum ForecastResponseCodingKeys: String, CodingKey {
        case dt = "dt"
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
        case speed = "speed"
        case deg = "deg"
        case clouds = "clouds"
        case snow = "snow"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ForecastResponseCodingKeys.self)
        
        dt  = try container.decode(Int.self, forKey: .dt)
        temp = try container.decode(Temperature.self, forKey: .temp)
        pressure = try container.decode(Double.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
        weather = try container.decode([Weather].self, forKey: .weather)
        speed = try container.decode(Double.self, forKey: .speed)
        deg = try container.decode(Int.self, forKey: .deg)
        clouds = try container.decode(Int.self, forKey: .clouds)
        snow = try container.decode(Double.self, forKey: .snow)
    }
}

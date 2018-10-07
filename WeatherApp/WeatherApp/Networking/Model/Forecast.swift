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
    let weather : [Weather]
    let clouds : Clouds
    let main : Main
    let wind : Wind
    let dt_txt : String
    
}

extension Forecast: Decodable {
    
    private enum ForecastResponseCodingKeys: String, CodingKey {
        case dt = "dt"
        case weather = "weather"
        case clouds = "clouds"
        case main = "main"
        case wind = "wind"
        case dt_txt = "dt_txt"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ForecastResponseCodingKeys.self)
        
        dt  = try container.decode(Int.self, forKey: .dt)
        weather = try container.decode([Weather].self, forKey: .weather)
        clouds = try container.decode(Clouds.self, forKey: .clouds)
        main = try container.decode(Main.self, forKey: .main)
        wind = try container.decode(Wind.self, forKey: .wind)
        dt_txt = try container.decode(String.self, forKey: .dt_txt)
    }
}

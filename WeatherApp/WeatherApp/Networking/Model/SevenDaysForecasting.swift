//
//  SevenDaysForecasting.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation



struct SevenDaysForecasting {
    let cod : String
    let message: Int
    let city: City
    let cnt : Int
    let list : [Forecast]
}

extension SevenDaysForecasting: Decodable {
    
    private enum SevenDaysForecastingCodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case city = "city"
        case cnt = "cnt"
        case list = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SevenDaysForecastingCodingKeys.self)
        
        cod = try container.decode(String.self, forKey: .cod)
        message = try container.decode(Int.self, forKey: .message)
        city = try container.decode(City.self, forKey: .city)
        cnt = try container.decode(Int.self, forKey: .cnt)
        list = try container.decode([Forecast].self, forKey: .list)
    }
}

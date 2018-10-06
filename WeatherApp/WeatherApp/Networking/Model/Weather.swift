//
//  Weather.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation


struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon : String
}

extension Weather: Decodable {
    
    private enum WeatherResponseCodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WeatherResponseCodingKeys.self)
        
       id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

//weather":{
//        "id": 600,
//        "main": "Snow",
//        "description": "light snow",
//        "icon": "13d"
//        }


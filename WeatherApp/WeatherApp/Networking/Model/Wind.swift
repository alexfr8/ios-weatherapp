//
//  Wind.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation


struct Wind {
    let speed: Double
    let deg: Double
}

extension Wind: Decodable {
    
    private enum WindResponseCodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WindResponseCodingKeys.self)
        
        
        speed = try container.decode(Double.self, forKey: .speed)
        deg = try container.decode(Double.self, forKey: .deg)
      
    }
}

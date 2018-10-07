//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

struct Coordinate {
    let lat: Double
    let lon: Double
}

extension Coordinate: Decodable {
    
    private enum CoordinateResponseCodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoordinateResponseCodingKeys.self)
        
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
       
    }
}

//"coord": {
//    "lat": -31.8607,
//    "lon": 115.8942
//}


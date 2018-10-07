//
//  File.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

struct City {
    let id: Int
    let name: String
    let coord : Coordinate
    let country: String
    let population: Int
}

extension City: Decodable {
    
    private enum CityResponseCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country  = "country"
        case population = "population"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CityResponseCodingKeys.self)
        
   
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        coord = try container.decode(Coordinate.self, forKey: .coord)
        country = try container.decode(String.self, forKey: .country)
        population = try container.decode(Int.self, forKey: .population)
        
    }
}

// example on 06/10/2018
//"city": {
//    "name": "Malaga",
//    "country": "AU",
//    "population": 1446704,
//    "id": 2063523,
//    "coord": {
//        "lat": -31.8607,
//        "lon": 115.8942
//    }
//}


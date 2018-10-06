//
//  File.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

struct City {
    let geoname_Id: Int
    let name: String
    let lat : Double
    let lon : Double
    let country: String
    let iso2 : String
    let type : String
    let population: Int
}

extension City: Decodable {
    
    private enum CityResponseCodingKeys: String, CodingKey {
        case geoname_Id = "geoname_id"
        case name = "name"
        case lat = "lat"
        case lon = "lon"
        case country  = "country"
        case iso2 = "iso2"
        case type = "type"
        case population = "population"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CityResponseCodingKeys.self)
        
   
        geoname_Id = try container.decode(Int.self, forKey: .geoname_Id)
        name = try container.decode(String.self, forKey: .name)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
        country = try container.decode(String.self, forKey: .country)
        iso2 = try container.decode(String.self, forKey: .iso2)
        type = try container.decode(String.self, forKey: .type)
        population = try container.decode(Int.self, forKey: .population)
        
    }
}

// example on 06/10/2018
//"city": {
//    "geoname_id": 524901,
//    "name": "Moscow",
//    "lat": 55.7522,
//    "lon": 37.6156,
//    "country": "RU",
//    "iso2": "RU",
//    "type": "city",
//    "population": 0
//}


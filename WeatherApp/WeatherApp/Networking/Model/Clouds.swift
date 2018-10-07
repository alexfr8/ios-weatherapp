//
//  Clouds.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation


struct Clouds {
    let all: Int
}

extension Clouds: Decodable {
    
    private enum CloudsResponseCodingKeys: String, CodingKey {
        case all = "all"
       
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CloudsResponseCodingKeys.self)
        
        all = try container.decode(Int.self, forKey: .all)
       
    }
}

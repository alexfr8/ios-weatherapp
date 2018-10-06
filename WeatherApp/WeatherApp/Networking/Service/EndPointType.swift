//
//  EndPointType.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

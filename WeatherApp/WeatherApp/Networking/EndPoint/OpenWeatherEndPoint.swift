//
//  OpenWheatherEndPoint.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
enum NetworkEnvironment {
    case qa
    case production
    case staging
}


public enum OpenWeatherEndPoint {
    
    
    case forecastSevendDaysByCityName(city:String)
    case forecastSevendDaysByCoord(lat:Double, long: Double)
    
}


extension OpenWeatherEndPoint: EndPointType {
    
    
    
    var environmentBaseURL : String {
        switch OpenWeatherManager.appEnvironment {
        case .production: return "https://api.openweathermap.org"
        case .qa: return "https://api.openweathermap.org"
        case .staging: return "https://api.openweathermap.org"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
            
        case .forecastSevendDaysByCityName( _):
            return "/data/2.5/forecast"
                //q=London&mode=xml&units=metric&cnt=7
        case .forecastSevendDaysByCoord:
            return "/data/2.5/forecast"
            ///data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}
        }
        
        
    
    }
    
    
    var httpMethod: HTTPMethod {
        switch self {
        
        case .forecastSevendDaysByCityName( _):
            return .get
        case .forecastSevendDaysByCoord( _, _):
            return .get
        }
    }
    var task: HTTPTask {
        switch self {
            //q=London&mode=xml&units=metric&cnt=7
        case .forecastSevendDaysByCityName(let city):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["q":city,
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
            
       
        
        case .forecastSevendDaysByCoord(let lat, let long):
            return .requestParameters(bodyParameters: [:],
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["lat": String(format:"%.8f",  lat),
                                                      "lon":String(format:"%.8f",  long),
                                                      "mode":"json",
                                                      "units":"metric",
                                                      "cnt":"60",
                                                      "appid":Constants.OpenWeatherAPIKEY])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}


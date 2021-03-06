//
//  OpenWeatherManager.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 6/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation



enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct OpenWeatherManager {
    static let appEnvironment : NetworkEnvironment = .production
    
    let router = Router<OpenWeatherEndPoint>()
    
    func getSevenDaysForecastByCoordinates(lat: Double, long: Double, completion: @escaping (_ response : SevenDaysForecasting?, _ error: String?) -> ()) {
        
        router.request(.forecastSevendDaysByCoord(lat: lat, long: long)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let sevendDaysForecast = try JSONDecoder().decode(SevenDaysForecasting.self, from: responseData)
                        print(sevendDaysForecast)
                        completion(sevendDaysForecast, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        
        }
    }
    
    func getSevenDaysForecastByCityName(cityName: String,completion: @escaping (_ response : SevenDaysForecasting?, _ error: String?) -> ()) {
    
        router.request(.forecastSevendDaysByCityName(city: cityName)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                                case .success:
                                    guard let responseData = data else {
                                        completion(nil, NetworkResponse.noData.rawValue)
                                        return
                                    }
                                    do {
                                        print(responseData)
                                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                                        print(jsonData)
                                        let sevendDaysForecast = try JSONDecoder().decode(SevenDaysForecasting.self, from: responseData)
                                        print(sevendDaysForecast)
                                        completion(sevendDaysForecast, nil)
                                    }catch {
                                        print(error)
                                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                                    }
                                case .failure(let networkFailureError):
                                    completion(nil, networkFailureError)
                                }
                            }
        }
        
    }
//    func doLogin(email: String, password: String, completion: @escaping (_ loginResponse : LoginResponse?, _ error: String?) -> ()) {
//
//        router.request(.login(email: email, password: password)) { (data, response, error) in
//            if error != nil {
//                completion(nil, "Please check your network connection.")
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleNetworkResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(nil, NetworkResponse.noData.rawValue)
//                        return
//                    }
//                    do {
//                        print(responseData)
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
//                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: responseData)
//                        print(loginResponse)
//                        completion(loginResponse, nil)
//                    }catch {
//                        print(error)
//                        completion(nil, NetworkResponse.unableToDecode.rawValue)
//                    }
//                case .failure(let networkFailureError):
//                    completion(nil, networkFailureError)
//                }
//            }
//        }
//
//    }
//
    
    /* func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?,_ error: String?)->()){
     router.request(.newMovies(page: page)) { data, response, error in
     
     if error != nil {
     completion(nil, "Please check your network connection.")
     }
     
     if let response = response as? HTTPURLResponse {
     let result = self.handleNetworkResponse(response)
     switch result {
     case .success:
     guard let responseData = data else {
     completion(nil, NetworkResponse.noData.rawValue)
     return
     }
     do {
     print(responseData)
     let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
     print(jsonData)
     let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
     completion(apiResponse.movies,nil)
     }catch {
     print(error)
     completion(nil, NetworkResponse.unableToDecode.rawValue)
     }
     case .failure(let networkFailureError):
     completion(nil, networkFailureError)
     }
     }
     }
     }*/
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

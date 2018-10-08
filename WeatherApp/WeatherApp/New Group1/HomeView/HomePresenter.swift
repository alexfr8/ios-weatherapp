//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import CoreLocation


protocol HomeVCDelegate{
    func showProgress(msg:String)
    func hideProgress()
    func setupView()
    func showClear()
    func hideClear()
    func enableForecastButton()
    func disableForecastButton()
    func showError(error: String)
    func showSuccess(forecast : SevenDaysForecasting)
}

class HomePresenter : BasePresenter{
    var delegate: HomeVCDelegate
    var networkManager: OpenWeatherManager!
    let locManager = CLLocationManager()
    init(delegate: HomeVCDelegate) {
        self.delegate = delegate
        self.networkManager = OpenWeatherManager()
    }
    
    func setupUI() {
        self.delegate.setupView()
       
    }
    
    func manageTextFieldComplements(value : String) {
        if (value == "") {
            delegate.hideClear()
            delegate.disableForecastButton()
        } else {
            delegate.showClear()
            delegate.enableForecastButton()
        }
        
    }
    
    func performSearchCityForecast(city: String) {
        
        delegate.showProgress(msg: "")
        networkManager.getSevenDaysForecastByCityName(cityName: city) { (forecast, error) in
            if (error == nil) {
                self.delegate.showSuccess(forecast: forecast!)
            } else {
                self.delegate.showError(error: error!)
            }
            self.delegate.hideProgress()
        }
    }
    
    func performCoreLocationPermissions() {
        locManager.requestWhenInUseAuthorization()
    }
    
    func performSearchCoordinatesForecast() {
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startUpdatingLocation()
        locManager.startMonitoringSignificantLocationChanges()
        var currentLocation: CLLocation!
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locManager.location
            
            delegate.showProgress(msg: "")
            if (currentLocation != nil) {
            networkManager.getSevenDaysForecastByCoordinates(lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude, completion: { (forecast, error) in
                if (error == nil) {
                    self.delegate.showSuccess(forecast: forecast!)
                } else {
                    self.delegate.showError(error: error!)
                }
                self.delegate.hideProgress()
            })
            } else {
                self.delegate.showError(error: "Core location not available")
                self.delegate.hideProgress()
            }
        }
        
        //let latfake = 36.7206277
        //let longfake = -4.4687514
//        let latfake = 37.3754864
     /*   let longfake = -6.0252703
        
        delegate.showProgress(msg: "")
        
        
        networkManager.getSevenDaysForecastByCoordinates(lat: latfake, long:longfake, completion: { (forecast, error) in
        if (error == nil) {
        self.delegate.showSuccess(forecast: forecast!)
        } else {
        self.delegate.showError(error: error!)
        }
        self.delegate.hideProgress()
        })*/
    }
    
}





//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation



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
    
}

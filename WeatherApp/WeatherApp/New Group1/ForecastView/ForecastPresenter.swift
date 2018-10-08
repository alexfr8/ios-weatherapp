//
//  ForecastPresenter.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import UIKit



protocol ForecastVCDelegate{
    func showProgress(msg:String)
    func hideProgress()
    func setupView()
    func navigateToDetail(detailForecast : Forecast)
    func showError(error: String)
    func showSuccess(forecast : SevenDaysForecasting)
}

class ForecastPresenter : BasePresenter{

    var delegate: ForecastVCDelegate!
    var networkManager: OpenWeatherManager!
    
    init(delegate: ForecastVCDelegate) {
        self.delegate = delegate
        self.networkManager = OpenWeatherManager()
    }
    
    func setupUI() {
        self.delegate.setupView()
        
    }
    
    func prepareUITableviewCell(forecast : Forecast, table : UITableView, indexPath: IndexPath) -> UITableViewCell {
       // let cell = table.dequeueReusableCell(withIdentifier: "cell")
        
        let cell = table.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
            as! ForecastTableViewCell
        
        cell.imgWeather.imageFromURL(urlString: Constants.OpenWeatherIconURL + forecast.weather[0].icon + Constants.iconExtension)
        
        cell.lblTemp.text = "Min: " + String(format:"%.1f",  forecast.main.temp_min) + "º \n" + "Max: " + String(format:"%.1f", forecast.main.temp_max) + "º"
        cell.lblDesc.text = forecast.weather[0].description
        cell.lblDate.text = Date.getFormattedDate(string: forecast.dt_txt, formatter: "")
        return cell
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
    
    func performNavigationDetailForecast(forecastList: [Forecast], index: IndexPath) {
        self.delegate.navigateToDetail(detailForecast: forecastList[index.row])
    }
}

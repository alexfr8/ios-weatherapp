//
//  DetailPresenter.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation


protocol DetailVCDelegate{
    func showProgress(msg:String)
    func hideProgress()
    func setupView()
    func showError(error: String)
}

class DetailPresenter : BasePresenter{
    
    var delegate: DetailVCDelegate!
  //var networkManager: OpenWeatherManager!
    
    init(delegate: DetailVCDelegate) {
        self.delegate = delegate
//      self.networkManager = OpenWeatherManager()
    }
    
    func setupUI() {
        self.delegate.setupView()
    }
}


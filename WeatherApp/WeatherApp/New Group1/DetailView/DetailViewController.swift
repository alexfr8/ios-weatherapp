//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import PKHUD

class DetailViewController: BaseViewController {
    //MARK: - IBOUTLET
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblMinTitle: UILabel!
    @IBOutlet weak var lblMinValue: UILabel!
    @IBOutlet weak var lblMaxTitle: UILabel!
    @IBOutlet weak var lblMaxValue: UILabel!
    @IBOutlet weak var lblNightTitle: UILabel!
    @IBOutlet weak var lblNigthValue: UILabel!
    @IBOutlet weak var lblEveningTitle: UILabel!
    @IBOutlet weak var lblEveningValue: UILabel!
    @IBOutlet weak var lblMorningTitle: UILabel!
    @IBOutlet weak var lblMorningValue: UILabel!
    @IBOutlet weak var lblWindTitle: UILabel!
    @IBOutlet weak var lblWindValue: UILabel!
    @IBOutlet weak var lblCloudsTitle: UILabel!
    @IBOutlet weak var lblCloudsValue: UILabel!
    
    
    //MARK: - PRIVATE
    var forecast : Forecast!
    var sevendaysForecast: SevenDaysForecasting!
    var presenter : DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter =  DetailPresenter(delegate: self)
        presenter.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DetailViewController : DetailVCDelegate {
    func showProgress(msg: String) {
        
        DispatchQueue.main.async {
            HUD.dimsBackground = false
            HUD.allowsInteraction = false
            HUD.show(.progress)
            
        }
    }
    
    func hideProgress() {
        
        DispatchQueue.main.async {
            HUD.dimsBackground = true
            HUD.allowsInteraction = true
            HUD.hide()
            
        }
    }
    
    func setupView() {
        
        self.title = Date.getFormattedDate(string: forecast.dt_txt, formatter: "")
        self.lblCity.text = sevendaysForecast.city.name
        self.lblMinTitle.text = NSLocalizedString("detail_min", comment: "")
        self.lblMaxTitle.text = NSLocalizedString("detail_max", comment: "")
        self.lblNightTitle.text = NSLocalizedString("detail_night", comment: "")
        self.lblEveningTitle.text = NSLocalizedString("detail_evening", comment: "")
        self.lblMorningTitle.text  = NSLocalizedString("detail_morning", comment: "")
        self.lblWindTitle.text = NSLocalizedString("detail_wind_speed", comment: "")
        self.lblCloudsTitle.text = NSLocalizedString("detail_clouds", comment: "")
        
        self.lblMinValue.text = String(format:"%.1f",  forecast.main.temp_min) + "º"
        self.lblMaxValue.text = String(format:"%.1f",  forecast.main.temp_max) + "º"
        self.lblNigthValue.text = "?"
        self.lblEveningValue.text = "?"
        self.lblMorningValue.text = "?"
        self.lblWindValue.text = String(format:"%.1f",  forecast.wind.speed) + "mtr/s"
        self.lblCloudsValue.text = String(forecast.clouds.all) + "%"
        print(String(forecast.clouds.all) + "%")
        self.imgWeather.imageFromURL(urlString: Constants.OpenWeatherIconURL + forecast.weather[0].icon + Constants.iconExtension)
    }
    
    func showError(error: String) {
        
    }
    
    
}

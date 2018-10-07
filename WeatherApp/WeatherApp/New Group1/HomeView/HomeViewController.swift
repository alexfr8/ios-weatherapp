//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import PKHUD

class HomeViewController: BaseViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var imgSearch: UIImageView!
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnForecast: UIButtonRounded!
    
    
    //MARK: - Private data
    var presenter : HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter =  HomePresenter(delegate: self)
        
        presenter.setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBACTIONS
    

    @IBAction func btnForecast(_ sender: Any) {
        if (txtSearchField.text != "") {
            presenter.performSearchCityForecast(city: txtSearchField.text!)
        }
    }
    
    @IBAction func btnClear(_ sender: Any) {
        txtSearchField.text = ""
        presenter.manageTextFieldComplements(value: txtSearchField.text!)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension HomeViewController : UITextFieldDelegate {
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((string == "") && (range.location == 0)) {
            presenter.manageTextFieldComplements(value:"")
        } else {
            presenter.manageTextFieldComplements(value: textField.text! + string)
        }
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}

extension HomeViewController : HomeVCDelegate {
    func showClear() {
        btnClear.isHidden = false
    }
    
    func hideClear() {
        btnClear.isHidden = true
    }
    
    func enableForecastButton() {
        btnForecast.isEnabled = true
        btnForecast.backgroundColor = UIColor(rgbColorCodeRed: 25, green: 25, blue: 25, alpha: 1)
        btnForecast.setTitleColor(UIColor.white, for: .normal)
        btnForecast.setTitleColor(UIColor.white, for: .highlighted)
    }
    
    func disableForecastButton() {
        btnForecast.isEnabled = false
        btnForecast.backgroundColor = UIColor(rgbColorCodeRed: 246, green: 246, blue: 246, alpha: 1)
        btnForecast.setTitleColor(UIColor(rgbColorCodeRed: 25, green: 25, blue: 25, alpha: 1), for: .normal)
        btnForecast.setTitleColor(UIColor(rgbColorCodeRed: 25, green: 25, blue: 25, alpha: 1), for: .highlighted)
    }
    
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
        
        
        self.title = NSLocalizedString("home_title", comment: "")
        lblMsg.text = NSLocalizedString("home_desc", comment: "")
        txtSearchField.text = ""
        txtSearchField.placeholder = NSLocalizedString("home_plahceholder_txt", comment: "")
        btnForecast.setTitle(NSLocalizedString("home_search_button", comment: ""), for: .normal)
        btnForecast.setTitle(NSLocalizedString("home_search_button", comment: ""), for: .highlighted)
        btnForecast.setTitle(NSLocalizedString("home_search_button", comment: ""), for: .disabled)
        
        self.disableForecastButton()
        
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            self.lblError.text = error
            self.lblError.isHidden = false
        }
    }
    
    func showSuccess(forecast : SevenDaysForecasting) {
        
        DispatchQueue.main.async {
            self.lblError.text = ""
            self.lblError.isHidden = true
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let forecastVC = storyBoard.instantiateViewController(withIdentifier: "ForecastViewController") as! ForecastViewController
            forecastVC.forecast = forecast
            self.navigationController?.pushViewController(forecastVC, animated: true)
        }
    }
    
    
}

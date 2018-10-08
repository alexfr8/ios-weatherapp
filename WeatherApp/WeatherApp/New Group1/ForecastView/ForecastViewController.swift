//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class ForecastViewController: BaseViewController {

    // MARK: - IBOUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - PRIVATE DATA
    var forecast : SevenDaysForecasting! = nil
    var presenter : ForecastPresenter!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ForecastViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter =  ForecastPresenter(delegate: self)
        
        presenter.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        
        presenter.performSearchCityForecast(city: forecast.city.name)
        
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ForecastViewController : ForecastVCDelegate {
    func navigateToDetail(detailForecast: Forecast) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier :"DetailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func showProgress(msg: String) {
        
    }
    
    func hideProgress() {
        
    }
    
    func setupView() {
        
        self.title = forecast.city.name
        self.tableView.addSubview(self.refreshControl)
    }
    
    func showError(error: String) {
        
    }
    
    func showSuccess(forecast: SevenDaysForecasting) {
        self.forecast = forecast
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
    }
    
    
}

extension ForecastViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (forecast != nil){
            return forecast.getFilteredList().count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.prepareUITableviewCell(forecast: forecast.getFilteredList()[indexPath.row], table: tableView, indexPath:  indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.performNavigationDetailForecast(forecastList: forecast.list, index: indexPath)
        
    }
    
    
}

//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    var forecast : Forecast!
    var presenter : DetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.presenter =  DetailPresenter(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DetailViewController : DetailVCDelegate {
    
}

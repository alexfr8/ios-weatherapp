//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var imgWeather: UIImageView!
}

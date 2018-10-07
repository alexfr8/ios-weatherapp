//
//  UIButtonRounded.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import UIKit

class UIButtonRounded: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: Code for our button
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}

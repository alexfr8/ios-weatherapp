//
//  Date.swift
//  WeatherApp
//
//  Created by Alejandro Fernández Ruiz on 7/10/18.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation


extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //2018-10-08 03:00:00
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy/MM/dd"
        
        let date: Date? = dateFormatterGet.date(from: string /*"2018-02-01T19:10:04+00:00"*/)
        print("Date",dateFormatterPrint.string(from: date!)) 
        return dateFormatterPrint.string(from: date!);
    }
}

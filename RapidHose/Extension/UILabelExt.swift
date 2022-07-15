//
//  UILabelExt.swift
//  RapidHose
//
//  Created by Ashok on 16/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

func lblAttributedTxt(lblName: UILabel,str1: String, str2: String, font1: UIFont,font2: UIFont){
    
    let attrs1 = [NSAttributedString.Key.font : font1, NSAttributedString.Key.foregroundColor : UIColor.black]

    let attrs2 = [NSAttributedString.Key.font : font2, NSAttributedString.Key.foregroundColor : UIColor.black]

    let attributedString1 = NSMutableAttributedString(string: str1, attributes:attrs1 as [NSAttributedString.Key : Any])

    let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2 as [NSAttributedString.Key : Any])

    attributedString1.append(attributedString2)
    lblName.attributedText = attributedString1
}

func changeUnderLineColor(text: String) -> NSAttributedString{
    let textColor: UIColor = .black
    let underLineColor: UIColor = .black
        //UIColor.init(red: 172/255, green: 36/255, blue: 42/255, alpha: 1.0000)
    let underLineStyle = NSUnderlineStyle.single.rawValue
    let labelAtributes:[NSAttributedString.Key : Any]  = [
        NSAttributedString.Key.foregroundColor: textColor,
        NSAttributedString.Key.underlineStyle: underLineStyle,
        NSAttributedString.Key.underlineColor: underLineColor
           ]

    let underlineAttributedString = NSAttributedString(string: text, attributes: labelAtributes)
    return underlineAttributedString
}


func timeStampToDate(timeStamp: Int) -> String{
    let unixTimeStamp: Double = Double(timeStamp) / 1000.0
    let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
    let dateFormatt = DateFormatter()
    dateFormatt.dateFormat = "dd-MM-yyy hh:mm a"
    dateFormatt.timeZone = .current
    print(dateFormatt.string(from: exactDate as Date))
    let dateStr = dateFormatt.string(from: exactDate as Date)
    return dateStr
}

func timeStampToOnlyDate(timeStamp: Int) -> String{
    let unixTimeStamp: Double = Double(timeStamp) / 1000.0
    let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
    let dateFormatt = DateFormatter()
    dateFormatt.dateFormat = "dd-MM-yyy"
    dateFormatt.timeZone = .current
    print(dateFormatt.string(from: exactDate as Date))
    let dateStr = dateFormatt.string(from: exactDate as Date)
    return dateStr
}

func timeStampToTime(timeStamp: Int) -> String{
    let unixTimeStamp: Double = Double(timeStamp) / 1000.0
    let exactDate = NSDate.init(timeIntervalSince1970: unixTimeStamp)
    let dateFormatt = DateFormatter()
    dateFormatt.dateFormat = "hh:mm a"
    print(dateFormatt.string(from: exactDate as Date))
    let dateStr = dateFormatt.string(from: exactDate as Date)
    return dateStr
}


func localToUTC(date:String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyy hh:mm a"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let date = dateFormatter.date(from: date)

    // change to a readable time format and change to local time zone
    dateFormatter.dateFormat = "dd-MM-yyy hh:mm a"
    dateFormatter.timeZone = NSTimeZone.local
    let timeStamp = dateFormatter.string(from: date!)
    print(timeStamp)
    return timeStamp
}

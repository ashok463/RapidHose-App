//
//  UIDateExt.swift
//  RapidHose
//
//  Created by Ashok on 01/07/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
        
    }
}

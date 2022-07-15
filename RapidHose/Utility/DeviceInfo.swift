//
//  DeviceInfo.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 03/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

struct DeviceInfo{
    
    static var deviceId : String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    static var devieName : String{
        return UIDevice.current.name
    }
    
    static var deviceModel : String{
        return UIDevice.current.model
    }
    
    static var systemName : String{
        return UIDevice.current.systemName
    }
    
    static var systemVersion : String{
        return UIDevice.current.systemVersion
    }
}

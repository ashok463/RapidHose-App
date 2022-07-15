//
//  Userdata.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 03/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation

class UserData : Codable{
    var email : String? = Constants.empty
    var name : String? = Constants.empty
    var phone : String? = Constants.empty
    var status : Int? = 0
    var deviceDetails : DeviceInformation?
    var notification : Notification?
    
}

class DeviceInformation : Codable{
    var os : String = Constants.empty
    var osversion : String = Constants.empty
    var buildNumber : String = Constants.empty
    var buildVersion : String?
    var deviceIdentifier : String?
    var deviceModel : String?
    var deviceName : String = Constants.empty
}

class Notification : Codable{
    var notificationToken : String = Constants.empty
    var sendNotification : Bool = true
}

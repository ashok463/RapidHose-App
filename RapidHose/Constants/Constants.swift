//
//  Constants.swift
//  DailySpend
//
//  Created by Kirti Ahlawat on 10/10/19.
//  Copyright © 2019 outect. All rights reserved.
//

import Foundation

struct Constants{
    
    static let empty = ""
    static let dateFormat = "MMM d, yyyy"
    static let currency = Locale.current.currencyCode ?? "inr"
    static let monthFormat = "MMMM yyyy"
    
    struct storyboardIdentifier{
        
    }
    
    struct alert{
       static let alertType = "Alert"
       static let actionBtnType = "Ok"
       //Sign UP Screen Alert
       static let confirmAndCreatePasswordNotMatched = "Create and confirm password not matched!"
    }
    
    struct userDefaulsKeys{
        static let notificationToken = "notificationToken"
        static let isLogin = "isLogin"
        static let taskID = "taskID"
        static let userName = "userName"
        static let isLoginId = "isLoginId"
        static let isLoginName = "isLoginName"
        static let isLoginEmail = "isLoginEmail"
    }
    
    
}

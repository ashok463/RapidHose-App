//
//  AlertService.swift
//  CustomAlertViewDemo
//
//  Created by Shashank Panwar on 04/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

enum AlertType : Int{
    case informationAlertType
    case confirmationAlertType
}

class AlertService{
    
    private func alert(withtype type: AlertType,withTitle title : String, alertBody body : String, actionButtonTitle : String, completion : (() -> Void)? = nil) -> AlertViewController{
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! AlertViewController
        alertVC.alertTitle = title
        alertVC.alertBody = body
        alertVC.actionBtnTitle = actionButtonTitle
        alertVC.alertType = type
        alertVC.buttonAction = completion
        return alertVC
    }
    
    func showAlert(on vc: UIViewController? = nil, title : String, message : String, actionButtonTitle : String, alertType : AlertType? = .informationAlertType, completion : (()-> Void)? = nil){
         let alertVC = alert(withtype: alertType!, withTitle: title, alertBody: message, actionButtonTitle: actionButtonTitle, completion: completion)
         if vc != nil{
             vc?.present(alertVC, animated: true)
         }else{
             var topViewController = UIApplication.shared.keyWindow?.rootViewController
             while let presentedViewController = topViewController?.presentedViewController{
                 topViewController = presentedViewController
             }
             topViewController?.present(alertVC, animated: true)
         }
     }
    
}

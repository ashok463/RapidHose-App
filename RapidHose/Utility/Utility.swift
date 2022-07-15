//
//  Utility.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 03/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

class Utility{
    
    // MARK:- Empty Text Field Check Function
    /**
     Description : Function check whether one of the text field is empty from the list of text fields.
     */
    static func checkIfAnyTextFieldIsEmpty(_ textFields : UITextField...) -> Bool{
        for textfield in textFields{
            if textfield.text!.isEmpty{
                AlertService().showAlert(title: Constants.alert.alertType, message: "At least one of the text field is Empty!", actionButtonTitle: Constants.alert.actionBtnType, completion: {})
                return false
            }
        }
        return true
    }
    
    
    // MARK:- Radio Btn Logic
    /**
        This function is used to provide the functionality of the radio button within the group of buttons.
     - Parameter radioBtnGroup : Array of buttons involve in the radio button feature.
     - Parameter pressedRadioBtn : Button which is pressed.
     - Returns: Selected radio button title
     
     */
    static func handleRadioBtns(radioBtnGroup : [UIButton], pressedRadioBtn : UIButton) -> String{
        pressedRadioBtn.isSelected.toggle()
//        pressedRadioBtn.setImage(UIImage(named: "selectedRadioBtn"), for: .normal)
        let remainingBtns = radioBtnGroup.filter({ $0 != pressedRadioBtn})
        for radioBtn in remainingBtns{
            radioBtn.isSelected = false
//            radioBtn.setImage(UIImage(named: "unselectedRadioBtn"), for: .normal)
        }
        return pressedRadioBtn.titleLabel!.text!
    }
    
    
    //MARK:- DEVICE INFORMATION
    static func getDeviceAppDetails() -> [String : Any]{
        var deviceInfo = [String : Any]()
        deviceInfo["os"] = DeviceInfo.systemName
        deviceInfo["osversion"] = DeviceInfo.systemVersion
        deviceInfo["buildNumber"] = Bundle.buildVersionNumber
        deviceInfo["buildVersion"] = Bundle.releasedVersionNumber
        deviceInfo["deviceName"] = DeviceInfo.devieName
        deviceInfo["deviceIdentifier"] = DeviceInfo.deviceId
        deviceInfo["deviceModel"] = DeviceInfo.deviceModel
        return deviceInfo
    }
    
    
    static func notificationDetails() -> [String : Any]{
        var notificationInfo = [String : Any]()
        if let notificationToken = UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.notificationToken) as? String{
            notificationInfo["notificationToken"] = notificationToken
        }else{
            notificationInfo["notificationToken"] = AppDelegate.getAppDelegate().notificationToken
        }
        notificationInfo["sendNotification"] = true
        return notificationInfo
    }
    
    
    static func getNotificationInfo() -> Notification?{
        var notificationInfo = Notification()
        do{
            let data = try JSONSerialization.data(withJSONObject: Utility.notificationDetails(), options: .fragmentsAllowed)
            notificationInfo = try JSONDecoder().decode(Notification.self, from: data)
            return notificationInfo
        }catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    
    static func getDeviceInformation() -> DeviceInformation?{
        var deviceInformation = DeviceInformation()
        do{
            let data = try JSONSerialization.data(withJSONObject: Utility.getDeviceAppDetails(), options: .fragmentsAllowed)
            deviceInformation = try JSONDecoder().decode(DeviceInformation.self, from: data)
            return deviceInformation
        }catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return nil
    }
    
    func handlingDecodableErrors(error : DecodingError){
        switch error {
        case .dataCorrupted(let context):
            print(context)
        case .keyNotFound(let key, let context):
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        case .valueNotFound(let value, let context):
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        case .typeMismatch(let type, let context):
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        default:
            print(error)
        }
    }
}

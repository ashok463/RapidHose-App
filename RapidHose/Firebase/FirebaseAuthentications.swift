//
//  FirebaseAuthentications.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 03/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthentications : NSObject{
    
    //MARK:- SIGN IN WITH EMAIL & Password
    class func signIn(with email : String, password : String, completion : @escaping (Bool, FirebaseAuth.User?) -> Void){
        ActivityIndicator.shared().show()
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            ActivityIndicator.shared().hide()
            if let err = error as NSError?{
                handleFirebaseError(error: err)
                completion(false, nil)
                return
            }
            completion(true, authResult?.user)
        }
    }
    
    
    //MARK:- SIGNUP WITH FIREBASE
    class func signUp(with email : String, password : String, completion : @escaping (Bool, FirebaseAuth.User?) -> Void){
        ActivityIndicator.shared().show()
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            ActivityIndicator.shared().hide()
            if let err = error as NSError?{
                handleFirebaseError(error: err)
                completion(false, nil)
                return
            }
            completion(true, authResult?.user)
        }
    }
    
    //MARK:- Forgot Password WITH EMAIL
    class func forgotPassword(with email : String, completion : @escaping (Bool, String) -> Void){
        ActivityIndicator.shared().show()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            DispatchQueue.main.async {
                ActivityIndicator.shared().hide()
                if let error = error {
                    print(error.localizedDescription)
                     completion(false , error.localizedDescription)
                }else{
                    print("We send you an email with instructions on how to reset your password.")
                     completion(true, "")
                }
            }
        }
    }
    
    //MARK:- SIGNOUT
    class func signOut(){
        do{
            try Auth.auth().signOut()
        }catch {
            if let err = error as NSError?{
                handleFirebaseError(error: err)
            }
        }
    }
    
    
    private class func handleFirebaseError(error : NSError){
        switch error.code {
        case AuthErrorCode.wrongPassword.rawValue:
            AlertService().showAlert(title: "Sorry", message: "The password isn't right. We can help you to recover your password.", actionButtonTitle: Constants.alert.actionBtnType)
        case AuthErrorCode.invalidEmail.rawValue:
            AlertService().showAlert(title: Constants.alert.alertType, message: "The email address is badly formatted.", actionButtonTitle: Constants.alert.actionBtnType)
        default:
            AlertService().showAlert(title: Constants.alert.alertType, message: error.localizedDescription, actionButtonTitle: Constants.alert.actionBtnType)
        }
    }
}

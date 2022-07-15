//
//  ViewController.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 01/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import Crashlytics

class LoginVC: UIViewController {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    //Ashok
    @IBOutlet weak var bcImg: UIImageView!
    @IBOutlet weak var emailTextFieldView: UITextField!
    @IBOutlet weak var passwordTextFieldView: UITextField!
    @IBOutlet weak var backgroundTextFieldView: UIView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.btnCornerRadius(radius: 5.0)
        addbottom_Boarder_btn(btn: btnLogin)

    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        bcImg.applyshadowWithCorner(containerView: backgroundTextFieldView, cornerRadious: 5)
        
        self.emailTextFieldView.setLeftIcon("emailTxtImage")
        self.passwordTextFieldView.setLeftIcon("passwordTxtImage")
        
//        emailTxtField.text = ""
//        passwordTxtField.text = ""
        
    }
    
    //Ashok
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        if Utility.checkIfAnyTextFieldIsEmpty(emailTxtField,passwordTxtField){
            //                    sender.animateButton(shouldLoad: true)
            sender.isSelected = true
            FirebaseAuthentications.signIn(with: emailTxtField.text!, password: passwordTxtField.text!) { [weak self](status, firebaseUser) in
                guard let self = self else {return}
                if status{
                    
                    UserDefaults.standard.set(firebaseUser?.uid, forKey: Constants.userDefaulsKeys.isLoginId)
                    
                    FirestoreManager.shared.getUserStatusValue { (status) in
                        if status{
                            FirestoreManager.shared.updateInformationAfterLogin { [weak self] (status) in
                                guard let self = self else {return}
                                //                                sender.animateButton(shouldLoad: false, withMessage: "Submit")
                                UserDefaults.standard.set(true, forKey: Constants.userDefaulsKeys.isLogin)
        //                        self.performSegue(withIdentifier: "loginToMainVC", sender: nil)
                                guard let kyDrawerController = self.storyboard?.instantiateViewController(withIdentifier: "KYDrawerController")  else { return }
                                self.navigationController?.pushViewController(kyDrawerController, animated: true)
                            }
                        }else{
                            AlertService().showAlert(title: "Alert", message: "Your access has been disabled by admin, please contact admin", actionButtonTitle: "Ok", completion: {})
                        }
                    }
                    
                }else{
                    //                            sender.animateButton(shouldLoad: false, withMessage: "Submit")
                }
            }
        }else{
            //                    sender.animateButton(shouldLoad: false, withMessage: "Submit")
        }
        
        //        self.performSegue(withIdentifier: "loginToMainVC", sender: nil)
    }
    
    @IBAction func forgotPasswordBtnAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginToForgotPasswordVC", sender: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: RoundShadowButton) {
        //        if Utility.checkIfAnyTextFieldIsEmpty(emailTextField,passwordTextField){
        //            sender.animateButton(shouldLoad: true)
        //            sender.isSelected = true
        //            FirebaseAuthentications.signIn(with: emailTextField.text!, password: passwordTextField.text!) { [weak self](status, firebaseUser) in
        //                guard let self = self else {return}
        //                if status{
        //                    self.loginHandler(sender: sender)
        //                }else{
        //                    sender.animateButton(shouldLoad: false, withMessage: "Submit")
        //                }
        //            }
        //        }else{
        //            sender.animateButton(shouldLoad: false, withMessage: "Submit")
        //        }
        
        self.performSegue(withIdentifier: "loginToMainVC", sender: nil)
    }
    
    private func loginHandler(sender : RoundShadowButton){
        FirestoreManager.shared.updateInformationAfterLogin { [weak self] (status) in
            guard let self = self else {return}
            sender.animateButton(shouldLoad: false, withMessage: "Submit")
            UserDefaults.standard.set(true, forKey: Constants.userDefaulsKeys.isLogin)
            self.performSegue(withIdentifier: "loginToMainVC", sender: nil)
            print("User Information Successfully Saved")
            
        }
        
    }
    
    
}


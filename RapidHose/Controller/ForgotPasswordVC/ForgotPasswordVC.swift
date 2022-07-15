//
//  ForgotVC.swift
//  RapidHose
//
//  Created by Ashok on 26/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import Firebase


class ForgotPasswordVC: UIViewController {
    
    //Ashok
    @IBOutlet weak var backgroundTextFieldView: UIView!
    @IBOutlet weak var bcImg: UIImageView!
    @IBOutlet weak var emailTextFieldView: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        submitBtn.btnCornerRadius(radius: 5.0)
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        bcImg.applyshadowWithCorner(containerView: backgroundTextFieldView, cornerRadious: 5)
        
        self.emailTextFieldView.setLeftIcon("emailTxtImage")
        
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if Utility.checkIfAnyTextFieldIsEmpty(emailTxtField){
            
            FirebaseAuthentications.forgotPassword(with: emailTxtField.text ?? "") { (status, error) in
                if status{
                    AlertService().showAlert(title: "Successfully", message: "We send you an email with instructions on how to reset your password.", actionButtonTitle: "Ok", completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    AlertService().showAlert(title: "Error", message: error, actionButtonTitle: "Ok", completion: {})
                }
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

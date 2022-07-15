//
//  AlertViewController.swift
//  CustomAlertViewDemo
//
//  Created by Shashank Panwar on 04/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    @IBOutlet weak var alertTitleLbl: UILabel!
    @IBOutlet weak var alertBodyLbl: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var canelBtn: UIButton!
    @IBOutlet weak var alertView: AlertView!
    @IBOutlet weak var titleView: UIView!
    
    var alertTitle = String()
    var alertBody = String()
    var actionBtnTitle = String()
    var alertType = AlertType.informationAlertType
    
    var buttonAction : (() -> Void)?
    
//    var themeColor = ThemeSelection.shared.selectedTheme?.buttonBackgroundColor ?? .black
    var themeColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertTitleLbl.text = alertTitle
        alertBodyLbl.text = alertBody
        actionBtn.setTitle(actionBtnTitle, for: .normal)
        if alertType == .informationAlertType{
            canelBtn.removeFromSuperview()
        }
        setThemeColor()
    }
    
    private func setThemeColor(){
        alertView.borderColor = themeColor
        titleView.backgroundColor = themeColor
        actionBtn.backgroundColor = themeColor
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func actionBtnPressed(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            if let self = self{
                if let btnAction = self.buttonAction{
                    btnAction()
                }
            }
        }
    }
    
}

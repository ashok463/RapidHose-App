//
//  UITextFieldExt.swift
//  RapidHose
//
//  Created by Ashok on 15/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setLeftIcon(_ icon: String) {
        
        let padding = 0
        let size = 30
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = UIImage.init(named: icon)
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    func setRightIcon1(_ icon: String) {
        
        let padding = 40
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = UIImage.init(named: icon)
        outerView.addSubview(iconView)
        
        rightView = outerView
        rightViewMode = .always
    }
    
    func setRightIcon(_ icon: String) {
        self.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        let image = UIImage(named: icon)
        imageView.image = image
        self.rightView = imageView
    }
    
    func setCornerRaduisWithBorder(txt: String, PlaceholderTxtColor: UIColor, borderColor: UIColor){
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.attributedPlaceholder = NSAttributedString(string: txt, attributes: [NSAttributedString.Key.foregroundColor: PlaceholderTxtColor])
    }
}



class SharedClass: NSObject {
    static let sharedInstance = SharedClass()

    //This is my padding function.
    func textFieldLeftPadding(textFieldName: UITextField) {
    // Create a padding view
    textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textFieldName.frame.height))
    textFieldName.leftViewMode = .always//For left side padding
    textFieldName.rightViewMode = .always//For right side padding
    }

    private override init() {

    }
}

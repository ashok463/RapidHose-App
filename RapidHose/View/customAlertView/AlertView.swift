//
//  AlertView.swift
//  CustomAlertViewDemo
//
//  Created by Shashank Panwar on 06/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

@IBDesignable
class AlertView: UIView {

    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor : UIColor = .white{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
}

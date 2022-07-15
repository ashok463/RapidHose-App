//
//  ShadowView.swift
//  CustomAlertViewDemo
//
//  Created by Shashank Panwar on 06/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.clear{
        didSet{
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset : CGSize = .zero{
        didSet{
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0.0{
        didSet{
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0.5{
        didSet{
            layer.shadowOpacity = shadowOpacity
        }
    }
    
}

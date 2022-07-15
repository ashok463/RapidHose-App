//
//  UIViewExt.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 03/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit



extension UIView{
    func fadeTo(alphaValue : CGFloat, withDuration duration : TimeInterval){
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
    func bindtoKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification : NSNotification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue : curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
    
    func setViewBackgroundImg(imgName: String){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: imgName)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }
    
}


//
//  Extensions.swift
//  Steuern
//
//  Created by Shashank Panwar on 09/10/18.
//  Copyright © 2018 Kayosys. All rights reserved.
//

import UIKit
//import AWSCore
//import AWSS3

func addbottom_Boarder_btn(btn: UIButton){
    let bottomBorder: CALayer = CALayer()
    bottomBorder.borderColor = UIColor.white.cgColor
    bottomBorder.borderWidth = 1
    bottomBorder.frame = CGRect(x: 0, y: btn.frame.height, width: btn.frame.width, height: 1)
    btn.layer.addSublayer(bottomBorder)
}

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}

extension UIView{
    
    func addConstraintsWithVisualFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func dropShadow(scale: Bool = true, radius: CGFloat, offset: CGSize) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, radius: CGFloat, cornerRadius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)    {

        var sizeOffset:CGSize = CGSize.zero

        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)


        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)


        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }

        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false

//        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
    
}

//extension UITextField{
//
//    func isFieldEmpty() -> Bool{
//        if self.text == emptyString{
//            return true
//        }
//        return false
//    }
//
//    func isEmpty() -> Bool {
//        if (text?.characters.count)! > 0 {
//            return false
//        } else {
//            return true
//        }
//    }
//}

extension UIColor{
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)-> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}


extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


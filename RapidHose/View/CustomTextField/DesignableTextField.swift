//
//  DesignableTextField.swift
//  CustomTextField
//
//  Created by Shashank Panwar on 01/07/19.
//  Copyright © 2019 Shashank Panwar. All rights reserved.
//

import UIKit

@objc protocol DesignableTextFieldDelegate{
    @objc optional func textFieldShouldReturn(_ textField : UITextField) -> Bool
    @objc optional func textFieldDidEndEditing(_ textField : UITextField)
    @objc optional func textFieldShouldBeginEditing(_ textField : UITextField) -> Bool
}

@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.lightGray.cgColor
            layer.masksToBounds = true
        }
    }

    @IBInspectable var leftImage : UIImage?{
        didSet{
           updateUIView()
        }
    }
    
    @IBInspectable var leftPedding :CGFloat = 0{
        didSet{
            updateUIView()
        }
    }
    
    weak var customDelegate : DesignableTextFieldDelegate?
    
    func updateUIView(){
        if let image = leftImage{
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftPedding, y: 0, width: 20, height: 20))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = tintColor
            var width = leftPedding + 20
            
            if borderStyle == .line || borderStyle == .none{
                width += 5
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 25))
            //view.backgroundColor = UIColor.gray
            view.addSubview(imageView)
            leftView = view
            
        }else{
            //image is nil
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [:])
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
    }
}

extension DesignableTextField : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let customDelegate = customDelegate else {return false}
        if textField.returnKeyType != .next{
            resignFirstResponder()
        }
        if !textField.isSecureTextEntry{
            textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        }
        return customDelegate.textFieldShouldReturn?(textField) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let customDelegate = customDelegate else {return}
        customDelegate.textFieldDidEndEditing?(textField)
    }
    
 
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let customDelegate = customDelegate else {return true}
        return customDelegate.textFieldShouldBeginEditing?(textField) ?? true
    }
}


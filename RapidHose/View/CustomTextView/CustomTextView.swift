//
//  CustomTextView.swift
//  DailySpend
//
//  Created by Shashank Panwar on 21/11/19.
//  Copyright © 2019 outect. All rights reserved.
//

import UIKit

@objc protocol CustomTextViewDelegate {
    
}

@IBDesignable
class CustomTextView: UITextView {

    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.lightGray.cgColor
            layer.masksToBounds = true
        }
    }

    weak var customDelegate : CustomTextViewDelegate?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.text = placeholderText
        textColor = .lightGray
        delegate = self
    }
    
    /// Add custom placeholder text
    var placeholderText = Constants.empty{
        didSet{
            text = placeholderText
            textColor = UIColor.lightGray
        }
    }
    
    /// This variable is used to identify whether text in textview is placeholder or entered text. Default value is false means text is placeholder text.
    var isDataUpdated = false

}

extension CustomTextView : UITextViewDelegate{
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.black {
            textView.text = nil
            textView.textColor = UIColor(named: "grayTextColor")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
            isDataUpdated = false
        }else{
            isDataUpdated = true
            textView.textColor = .black
        }
    }
}

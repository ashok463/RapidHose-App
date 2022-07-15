//
//  RoundShadowView.swift
//  UberClone
//
//  Created by Kirti Ahlawat on 21/11/18.
//  Copyright © 2018 shashank. All rights reserved.
//

import UIKit

class RoundShadowButton: UIButton {
    
    var originalSize : CGRect?

    func setupView(){
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
    }
    
    override func awakeFromNib() {
        //setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    func animateButton(shouldLoad : Bool, withMessage message: String? = nil){
        
        let spinner = UIActivityIndicatorView()
        spinner.backgroundColor = UIColor.red
        spinner.style = UIActivityIndicatorView.Style.whiteLarge
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        if shouldLoad{
            originalSize = self.frame
            self.addSubview(spinner)
            self.setTitle(Constants.empty, for: .normal)
            self.translatesAutoresizingMaskIntoConstraints = true
             
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = self.frame.height / 2
                self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }) { (finished) in
                if finished{
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.height / 2 + 1)
                    spinner.fadeTo(alphaValue: 1.0, withDuration: 0.2)
                }
            }
            self.isUserInteractionEnabled = false
        }else{
            self.isUserInteractionEnabled = true
            for subView in self.subviews{
                if subView.tag == 21{
                    subView.removeFromSuperview()
                }
            }
            UIView.animate(withDuration: 0.2) {
                self.layer.cornerRadius = 5.0
                self.frame = self.originalSize!
                self.setTitle(message, for: .normal)
            }
            
        }
    }
    
}

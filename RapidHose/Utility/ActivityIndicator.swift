//
//  ActivityIndicator.swift
//  CustomUIComponents
//
//  Created by Shashank Panwar on 4/25/18.
//  Copyright © 2018 Shashank Panwar. All rights reserved.
//

import UIKit

class ActivityIndicator{
    private init(){}
    
    private static var sharedInstance : ActivityIndicator?
    
    static func shared() -> ActivityIndicator{
        guard let share = sharedInstance else{
            sharedInstance = ActivityIndicator()
            return sharedInstance!
        }
        return share
    }
    var currentOverlay : UIView?
    var currentOverlayTarget : UIView?
    var currentLoadingText : String?
    
    //Show indicator of main window
    func show(){
        hide()
        guard let mainWindow = UIApplication.shared.keyWindow else{
            print("No Main Window")
            return
        }
        show(mainWindow)
    }
    
    func show(_ loadingText: String){
        hide()
        guard let mainWindow = UIApplication.shared.keyWindow else{
            print("No Main Window")
            return
        }
        show(mainWindow, loadingText: loadingText)
    }
    
    func show(_ overlayTarget: UIView){
        hide()
        show(overlayTarget, loadingText : nil)
    }
    
    func show(_ overlayTarget: UIView, loadingText: String?){
        hide()
        //Add a view over target view
        let overlay = UIView(frame: overlayTarget.frame)
        overlay.center = overlayTarget.center
        overlay.alpha = 0
        overlay.backgroundColor = UIColor.black
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        
        //Create and animate activity indicator
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.center = overlay.center
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        //Create label
        if let textString = loadingText{
            let label = UILabel()
            label.text = textString
            label.textColor = UIColor.white
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            overlay.addSubview(label)
        }
        
        UIView.animate(withDuration: 0.5) {
            overlay.alpha = overlay.alpha > 0 ? 0 : 0.5
        }
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        currentLoadingText = loadingText
        
    }
    
    func updateProgressText(progreess : String){
        if let currentOverlay = currentOverlay{
            for subview in currentOverlay.subviews{
                if let label = subview as? UILabel{
                    label.text = "Uploading...\(progreess)"
                    label.sizeToFit()
                }
            }
        }
    }
    
    func hide(){
        if currentOverlay != nil{
            currentOverlay?.removeFromSuperview()
            currentOverlay = nil
            currentOverlayTarget = nil
            currentLoadingText = nil
        }
    }
}





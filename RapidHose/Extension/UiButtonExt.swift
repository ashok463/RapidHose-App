//
//  UiButtonExt.swift
//  RapidHose
//
//  Created by Ashok on 19/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit



extension UIButton{
    
    func btnCornerRadius(radius: CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}



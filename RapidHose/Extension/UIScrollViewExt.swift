//
//  UIScrollViewExt.swift
//  RapidHose
//
//  Created by Ashok on 04/07/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func scrollsToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}

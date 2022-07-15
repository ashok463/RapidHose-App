//
//  MapViewExt.swift
//  RapidHose
//
//  Created by Ashok on 26/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit
import MapKit

func openMapButtonAction(latitude: Double, longitude: Double, viewcontroller: UIViewController) {

    let appleURL = "http://maps.apple.com/?daddr=\(latitude),\(longitude)"
    let googleURL = "http://maps.google.com/maps?q=loc:\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)"

    let wazeURL = "waze://?ll=\(latitude),\(longitude)&navigate=false"
    
    let googleItem = ("Google Map", URL(string:googleURL)!)
    let wazeItem = ("Waze", URL(string:wazeURL)!)
    var installedNavigationApps = [("Apple Maps", URL(string:appleURL)!)]
    
    if UIApplication.shared.canOpenURL(googleItem.1) {
        installedNavigationApps.append(googleItem)
    }
    
    if UIApplication.shared.canOpenURL(wazeItem.1) {
        installedNavigationApps.append(wazeItem)
    }
    
    let alert = UIAlertController(title: "Selection", message: "Select Navigation App", preferredStyle: .actionSheet)
    for app in installedNavigationApps {
        let button = UIAlertAction(title: app.0, style: .default, handler: { _ in
            UIApplication.shared.open(app.1, options: [:], completionHandler: nil)
        })
        alert.addAction(button)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancel)
    viewcontroller.present(alert, animated: true)
}

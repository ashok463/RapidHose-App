//
//  UIApplicationExtention.swift
//  RapidHose
//
//  Created by Ashok on 01/09/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {

    func applicationVersion() -> String {

        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }

    func applicationBuild() -> String {

        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? ""
    }

    func versionBuild() -> String {

        let version = self.applicationVersion()
        let build = self.applicationBuild()

        return "v\(version)(\(build))"
    }
}

//
//  PrivacyPolicyVC.swift
//  RapidHose
//
//  Created by Ashok on 02/09/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var webView: WKWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       /* webView.navigationDelegate = self
        ActivityIndicator.shared().show()
  */
        let url = URL(string: "https://rapidhose.com/privacy-policy")
        let requestObj = URLRequest(url: url! as URL)
        webView.load(requestObj)
       
        webView.navigationDelegate = self
        webView.uiDelegate = self


    
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicator.shared().hide()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ActivityIndicator.shared().show()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       ActivityIndicator.shared().hide()
    }
    
    //Ashok
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

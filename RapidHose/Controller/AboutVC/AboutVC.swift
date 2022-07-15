//
//  AboutVC.swift
//  RapidHose
//
//  Created by Ashok on 02/09/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var buildVersionLbl: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        backgroundImage.layer.cornerRadius = 10.0
        backgroundImage.layer.masksToBounds = true
        let version = UIApplication.shared.applicationVersion()
        let build = UIApplication.shared.applicationBuild()
        buildVersionLbl.text = "Build \(build) Version \(version)"
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
    }
    
    //Ashok
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

}

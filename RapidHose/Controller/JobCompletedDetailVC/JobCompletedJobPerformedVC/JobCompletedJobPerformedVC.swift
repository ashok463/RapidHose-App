//
//  JobCompletedJobPerformedVC.swift
//  RapidHose
//
//  Created by Ashok on 26/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedJobPerformedVC: UIViewController {

    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var textView: CustomTextView!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    var task : Task_modelClass?
    
    var delegate: MoveViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        
        nextBtn.btnCornerRadius(radius: 5.0)
        
        if self.task?.jobPerformed == "" || self.task?.jobPerformed == nil{
            textView.placeholderText = "Add Job Description..."
            textView.textColor = .lightGray
        }else{
            self.textView.text = self.task?.jobPerformed
            textView.textColor = .black
        }
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
    }

    @IBAction func btn1Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 0)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 1)
    }
    
    @IBAction func btn3Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 2)
    }
    
    @IBAction func btn4Action(_ sender: UIButton) {
//        delegate?.moveViewController(index: 3)
    }
    
    @IBAction func btn5Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 4)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        delegate?.moveViewController(index: 4)
    }
    
}

//
//  JobCompletedEditTaskInfoVC.swift
//  RapidHose
//
//  Created by Ashok on 26/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedEditTaskInfoVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var siteContactLb: UILabel!
    @IBOutlet weak var siteContactPhoneLbl: UILabel!
    @IBOutlet weak var machineTypeLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var machineSerialNumberLbl: UILabel!
    @IBOutlet weak var unitNumberLbl: UILabel!
    @IBOutlet weak var siteContactPhoneImg: UIImageView!
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

        
        if task?.sitePersonName == "" || task?.sitePersonName == nil{
            siteContactLb.text = "\n"
        }else{
            siteContactLb.text = task?.sitePersonName
        }
        
        if task?.sitePersonPhone == "" || task?.sitePersonPhone == nil{
            siteContactPhoneLbl.text = "\n"
        }else{
            siteContactPhoneLbl.attributedText = changeUnderLineColor(text: task?.sitePersonPhone ?? "")
        }
        
        if task?.machineType == "" || task?.machineType == nil{
            machineTypeLbl.text = "\n"
        }else{
            machineTypeLbl.text = task?.machineType
        }
        
        if task?.machineModel == "" || task?.machineModel == nil{
            modelLbl.text = "\n"
        }else{
            modelLbl.text = task?.machineModel
        }
        
        if task?.machineSerialNo == "" || task?.machineSerialNo == nil{
            machineSerialNumberLbl.text = "\n"
        }else{
            machineSerialNumberLbl.text = task?.machineSerialNo
        }
        
        if task?.unitNo == "" || task?.unitNo == nil{
            unitNumberLbl.text = "\n"
        }else{
            unitNumberLbl.text = task?.unitNo
        }
        
        if task?.sitePersonPhone == ""{
            siteContactPhoneImg.image = UIImage.init(named: "callerphonenumberIc")
        }else{
            siteContactPhoneImg.image = UIImage.init(named: "callerphonenumberRedIc")
        }
        
        scrollView.scrollsToBottom(animated: true)
        
        siteContactPhoneLbl.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.phoneNumberLabelTap))
        tap.delegate = self
        siteContactPhoneLbl.addGestureRecognizer(tap)
    }
    
    @objc func phoneNumberLabelTap(){
        
        if let url = URL(string: "tel://\(siteContactPhoneLbl.text ?? "")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }else {
            AlertService().showAlert(on: self, title: "Alert", message: "Your device doesn't support this feature.", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: nil)
        }
    }
    
     //Ashok
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           
//           self.view.setViewBackgroundImg(imgName: "backgroundimage")
//           backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
           backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
       }
       
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           //        let scrollSize = CGSize(width: backgroundImg.frame.size.width, height: backgroundTxtView.frame.size.height + 50)
           //        scrollView.contentSize = scrollSize
           scrollView.contentSize.width = backgroundImg.frame.size.width
       }
    
    @IBAction func btn1Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 0)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
//        delegate?.moveViewController(index: 1)
    }
    @IBAction func btn3Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 2)
    }
    @IBAction func btn4Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 3)
    }
    @IBAction func btn5Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 4)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        delegate?.moveViewController(index: 2)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

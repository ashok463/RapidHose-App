//
//  JobCompletedTaskInfoVC.swift
//  RapidHose
//
//  Created by Ashok on 26/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedTaskInfoVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var issueReportLbl: UILabel!
    @IBOutlet weak var timeReportStartedLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var callerLbl: UILabel!
    @IBOutlet weak var callReceivedTimeLbl: UILabel!
    @IBOutlet weak var callerPhoneNumberLbl: UILabel!
    @IBOutlet weak var milesDrivenroundedLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var estimateSiteTime: UILabel!
    @IBOutlet weak var estimateBackToShopTime: UILabel!
    @IBOutlet weak var estimateOnSiteTime: UILabel!
    @IBOutlet weak var tottalTime: UILabel!
    @IBOutlet weak var purchaseOrderLbl: UILabel!
    @IBOutlet weak var callerImg: UIImageView!
    @IBOutlet weak var locationImg: UIImageView!
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
        
        print("task detail : \(task)")
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        
        nextBtn.btnCornerRadius(radius: 5.0)
        
//        estimateSiteTime.text = "31 mins"
//        estimateBackToShopTime.text = "30 mins"
//        estimateOnSiteTime.text = "89 mins"
//        tottalTime.text = "2 hous 30 mins"
        
        if task?.issueReported == "" || task?.issueReported == nil{
            issueReportLbl.text = ""
        }else{
            issueReportLbl.text = task?.issueReported
        }
        
        if task?.createdAt == 0 || task?.createdAt == nil{
            timeReportStartedLbl.text = "\n"
        }else{
            timeReportStartedLbl.text = timeStampToDate(timeStamp: Int(task?.createdAt ?? 00))
        }
        
        if task?.customerName == "" || task?.customerName == nil{
            customerNameLbl.text = "\n"
        }else{
            customerNameLbl.text = task?.customerName
        }
        
        if task?.callerName == "" || task?.callerName == nil{
            callerLbl.text = "\n"
        }else{
            callerLbl.text = task?.callerName
        }
        
        if task?.calledTime == 0 || task?.calledTime == nil {
            callReceivedTimeLbl.text = "\n"
        }else{
            callReceivedTimeLbl.text = timeStampToDate(timeStamp: Int(task?.calledTime ?? 00))
        }
        
        if task?.callerPhone == "" || task?.callerPhone == nil{
            callerPhoneNumberLbl.text = "\n"
        }else{
            callerPhoneNumberLbl.attributedText = changeUnderLineColor(text: task?.callerPhone ?? "")
        }
        
        if task?.miles == 0 || task?.miles == nil{
            milesDrivenroundedLbl.text = "\n"
        }else{
            milesDrivenroundedLbl.text = "\(task?.miles ?? 0)"
        }
        
        if task?.jobLocation == "" || task?.jobLocation == nil{
            locationLbl.text = "\n"
        }else{
            locationLbl.attributedText = changeUnderLineColor(text: task?.jobLocation ?? "")
        }
        
        if task?.time1 == "" || task?.time1 == nil{
            estimateSiteTime.text = "\n"
        }else{
            estimateSiteTime.text = task?.time1
        }
        
        if task?.time2 == "" || task?.time2 == nil{
            estimateBackToShopTime.text = "\n"
        }else{
            estimateBackToShopTime.text = task?.time2
        }
        
        if task?.time3 == "" || task?.time3 == nil{
            estimateOnSiteTime.text = "\n"
        }else{
            estimateOnSiteTime.text = task?.time3
        }
        
        if task?.totalTime == "" || task?.totalTime == nil{
            tottalTime.text = "\n"
        }else{
            tottalTime.text = task?.totalTime
        }
        
        if task?.purchasedOrder == "" || task?.purchasedOrder == nil{
            purchaseOrderLbl.text = "\n"
        }else{
            purchaseOrderLbl.text = task?.purchasedOrder
        }
        
        if task?.customerName == "" || task?.customerName == nil{
            customerNameLbl.text = "\n"
        }else{
            customerNameLbl.text = task?.customerName
        }
        
        if task?.callerPhone == ""{
            callerImg.image = UIImage.init(named: "callerphonenumberIc")
        }else{
            callerImg.image = UIImage.init(named: "callerphonenumberRedIc")
        }
        
        if task?.jobLocation == ""{
            locationImg.image = UIImage.init(named: "locationIc")
        }else{
            locationImg.image = UIImage.init(named: "locationRedIc")
        }
        
        
        
        scrollView.scrollsToBottom(animated: true)
        
        callerPhoneNumberLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.phoneNumberLabelTap))
        tap.delegate = self
        callerPhoneNumberLbl.addGestureRecognizer(tap)
        
    }
    
    @objc func phoneNumberLabelTap(){
        
        if let url = URL(string: "tel://\(callerPhoneNumberLbl.text ?? "")"), UIApplication.shared.canOpenURL(url) {
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
        
//        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //        let scrollSize = CGSize(width: backgroundImg.frame.size.width, height: backgroundTxtView.frame.size.height + 50)
        //        scrollView.contentSize = scrollSize
        scrollView.contentSize.width = backgroundImg.frame.size.width
    }
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        
        openMapButtonAction(latitude: task?.jobCoordinates?.lat ?? 0.0, longitude: task?.jobCoordinates?.lng ?? 0.0, viewcontroller: self)
    }
    
    @IBAction func btn1Action(_ sender: UIButton) {
//        delegate?.moveViewController(index: 0)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 1)
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
        delegate?.moveViewController(index: 1)
    }
}

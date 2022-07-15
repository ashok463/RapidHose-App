//
//  TaskInfoVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 09/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import FirebaseFunctions

class TaskInfoVC: UIViewController, UIGestureRecognizerDelegate {
    
    //    var task : Task?
    
    //Ashok
    var task : Task_modelClass?
    
    @IBOutlet weak var purchasedOrderTextField: UITextField!
    
    //Ashok
    @IBOutlet weak var lbltop: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusTittleLbl: UILabel!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var issueReportEditBtn: UIButton!
    @IBOutlet weak var issueReportSaveBtn: UIButton!
    
    @IBOutlet weak var issueReportTxtField: UITextField!
    @IBOutlet weak var timeReportStartedTxtField: UITextField!
    @IBOutlet weak var customerNameTxtField: UITextField!
    @IBOutlet weak var callerTxtField: UITextField!
    @IBOutlet weak var timeWhenTheyCalledTxtField: UITextField!
    @IBOutlet weak var callerPhoneNumberTxtField: UITextField!
    @IBOutlet weak var milesTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var purchasedOrderTxtField: UITextField!
    
    @IBOutlet weak var issueReportLbl: UILabel!
    @IBOutlet weak var timeReportStartedLbl: UILabel!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var callerLbl: UILabel!
    @IBOutlet weak var timeWhenTheyCalledLbl: UILabel!
    @IBOutlet weak var callerPhoneNumberLbl: UILabel!
    @IBOutlet weak var milesLbl: UILabel!
    
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var statusBtn6: UIButton!
    
    @IBOutlet weak var purchasedOrderLbl: UILabel!
    @IBOutlet weak var purchasedOrderEditBtn: UIButton!
    @IBOutlet weak var purchasedOrderSaveBtn: UIButton!
    @IBOutlet weak var heightPurchasedOrderTxtField: NSLayoutConstraint!
    @IBOutlet weak var topPurchaseOrderedTxtField: NSLayoutConstraint!
    
    @IBOutlet weak var callerImg: UIImageView!
    @IBOutlet weak var locationImg: UIImageView!
    
    @IBOutlet weak var dispatchBtn: UIButton!
    
    @IBOutlet weak var heightissueReportTxtField: NSLayoutConstraint!
    @IBOutlet weak var topissueReportTxtField: NSLayoutConstraint!
    
    @IBOutlet weak var forwordBtn: UIButton!
    
    
    lazy var functions = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        purchasedOrderTextField.delegate = self
        
        timeReportStartedTxtField.delegate = self
        customerNameTxtField.delegate = self
        callerTxtField.delegate = self
        timeWhenTheyCalledTxtField.delegate = self
        callerPhoneNumberTxtField.delegate = self
        milesTxtField.delegate = self
        locationTxtField.delegate = self
        purchasedOrderTxtField.delegate = self
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        statusBtn6.btnCornerRadius(radius: statusBtn6.frame.width/2)
        
        dispatchBtn.btnCornerRadius(radius: 5.0)
        
        issueReportTxtField.isHidden = true
        issueReportSaveBtn.isHidden = true
        
        heightissueReportTxtField.constant = 0
        heightPurchasedOrderTxtField.constant = 0
        
        lbltop.text = "Task Id : \(task?.randomTaskId ?? 0)"
        statusTittleLbl.text = JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus()
        statusImg.image = UIImage.init(named: (JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())!)
        issueReportTxtField.text = task?.issueReported
        timeReportStartedTxtField.text = timeStampToDate(timeStamp: Int(task?.createdAt ?? 00))
        customerNameTxtField.text = task?.customerName
        callerTxtField.text = task?.callerName
        timeWhenTheyCalledTxtField.text = timeStampToDate(timeStamp: Int(task?.calledTime ?? 00))
        callerPhoneNumberTxtField.text = task?.callerPhone
        milesTxtField.text = "\(task?.miles ?? 0)"
        locationTxtField.text = task?.jobLocation
        purchasedOrderTxtField.text = task?.purchasedOrder
        
        issueReportLbl.text = task?.issueReported
        timeReportStartedLbl.text = timeStampToDate(timeStamp: Int(task?.createdAt ?? 00))
        customerNameLbl.text = task?.customerName
        callerLbl.text = task?.callerName
        timeWhenTheyCalledLbl.text = timeStampToDate(timeStamp: Int(task?.calledTime ?? 00))
        callerPhoneNumberLbl.attributedText = changeUnderLineColor(text: task?.callerPhone ?? "")
        milesLbl.text = "\(task?.miles ?? 0)"
        locationLbl.attributedText = changeUnderLineColor(text: task?.jobLocation ?? "")
        purchasedOrderLbl.text = task?.purchasedOrder
        
        issueReportEditBtn.isHidden = true
        heightPurchasedOrderTxtField.constant = 0
        purchasedOrderSaveBtn.isHidden = true
        
        if issueReportLbl.text == "" || issueReportLbl.text == nil{
            topissueReportTxtField.constant = 25
        }else{
            topissueReportTxtField.constant = 15
        }
        
        if task?.callerPhone == ""{
            callerImg.image = UIImage.init(named: "callerphonenumberIc")
        }else{
            callerImg.image = UIImage.init(named: "callerphonenumberRedIc")
        }
        
        if purchasedOrderLbl.text == "" || purchasedOrderLbl.text == nil{
            topPurchaseOrderedTxtField.constant = 25
        }else{
            self.heightPurchasedOrderTxtField.constant = 0
        }
        
        if task?.jobLocation == ""{
            locationImg.image = UIImage.init(named: "locationIc")
        }else{
            locationImg.image = UIImage.init(named: "locationRedIc")
        }
        
        if task?.jobStatus == 2 || task?.jobStatus == 6{
            dispatchBtn.setTitle("Dispatch", for: .normal)
        }else{
            dispatchBtn.setTitle("Next", for: .normal)
        }
        
        scrollView.scrollsToBottom(animated: true)
        
        callerPhoneNumberLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.phoneNumberLabelTap))
        tap.delegate = self
        callerPhoneNumberLbl.addGestureRecognizer(tap)
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
        getTaskInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        let scrollSize = CGSize(width: backgroundImg.frame.size.width, height: backgroundTxtView.frame.size.height + 130)
        //        scrollView.contentSize = scrollSize
        scrollView.contentSize.width = backgroundImg.frame.size.width
    }
    
    func getTaskInfo(){
        FirestoreManager.shared.getSingleTaskInformation(taskId: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.taskID) as? String ?? "") { (status, taskModelData) in
            if status{
                self.task = taskModelData[0]
                self.viewDidLoad()
            }
        }
    }
    
    func getTaskInfo(completion : @escaping (Bool) -> ()){
        FirestoreManager.shared.getSingleTaskInformation(taskId: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.taskID) as? String ?? "") { (status, taskModelData) in
            if status && taskModelData.count != 0{
                self.task = taskModelData[0]
                completion(true)
            }else{
                completion(false)
            }
        }
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
    
    @IBAction func issueReportEditBtnAction(_ sender: UIButton) {
        
        issueReportTxtField.isHidden = false
        issueReportSaveBtn.isHidden = false
        issueReportEditBtn.isHidden = true
        issueReportLbl.isHidden = true
        heightissueReportTxtField.constant = 40
        
        if issueReportLbl.text == "" || issueReportLbl.text == nil{
            topissueReportTxtField.constant = 25
        }else{
            topissueReportTxtField.constant = 15
        }
    }
    
    @IBAction func issueReportSaveBtnAction(_ sender: UIButton) {
        
        issueReportLbl.text = issueReportTxtField.text ?? ""
        timeReportStartedLbl.text = timeStampToDate(timeStamp: Int(task?.createdAt ?? 00))
        customerNameLbl.text = task?.customerName
        callerLbl.text = task?.callerName
        timeWhenTheyCalledLbl.text = timeStampToDate(timeStamp: Int(task?.calledTime ?? 00))
        callerPhoneNumberLbl.text = task?.callerPhone
        milesLbl.text = "\(task?.miles ?? 0)"
        locationLbl.attributedText = changeUnderLineColor(text: task?.jobLocation ?? "")
        purchasedOrderLbl.text = purchasedOrderTxtField.text ?? ""
        
        task?.issueReported = issueReportLbl.text
        task?.createdAt = task?.createdAt
        task?.customerName = task?.customerName
        task?.callerName = callerLbl.text ?? ""
        task?.calledTime = task?.calledTime
        task?.callerPhone = callerPhoneNumberLbl.text ?? ""
        task?.miles = task?.miles
        task?.jobLocation = locationLbl.text ?? ""
        task?.purchasedOrder = purchasedOrderTxtField.text ?? ""
        task?.jobStatus = 6
        task?.issueReportedTime = String(Date.currentTimeStamp)
        
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.issueReportTxtField.isHidden = true
                self.issueReportSaveBtn.isHidden = true
                self.issueReportEditBtn.isHidden = false
                self.issueReportLbl.isHidden = false
                self.heightissueReportTxtField.constant = 0
                self.topissueReportTxtField.constant = 15
                self.issueReportLbl.text = self.issueReportTxtField.text
                self.statusTittleLbl.text = JobStatus(rawValue: self.task!.jobStatus ?? 0)?.getJobStatus()
                self.statusImg.image = UIImage.init(named: (JobStatus(rawValue: self.task!.jobStatus ?? 0)?.getJobStatus())!)
                self.getTaskInfo { (status) in
                    if status{
                        self.issueReportLbl.text = self.issueReportTxtField.text
                        self.statusTittleLbl.text = JobStatus(rawValue: self.task!.jobStatus ?? 0)?.getJobStatus()
                        self.statusImg.image = UIImage.init(named: (JobStatus(rawValue: self.task!.jobStatus ?? 0)?.getJobStatus())!)
                    }
                }
            }
        }
    }
    
    @IBAction func purchasedOrderEditBtnAction(_ sender: UIButton) {
        
        getTaskInfo { (status) in
            if status{
                self.purchasedOrderTxtField.isHidden = false
                self.purchasedOrderSaveBtn.isHidden = false
                self.purchasedOrderEditBtn.isHidden = true
                self.purchasedOrderLbl.isHidden = true
                self.heightPurchasedOrderTxtField.constant = 40
                if self.purchasedOrderLbl.text == "" || self.purchasedOrderLbl.text == nil{
                    self.topPurchaseOrderedTxtField.constant = 25
                }else{
                    self.topPurchaseOrderedTxtField.constant = 15
                }
            }else{
                AlertService().showAlert(on: self, title: "Alert", message: "This Job is not assigned to you anymore", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
        
    }
    
    @IBAction func purchasedOrderSaveBtnAction(_ sender: UIButton) {
        
        getTaskInfo { (status) in
            if status{
                self.issueReportLbl.text = self.issueReportTxtField.text ?? ""
                self.timeReportStartedLbl.text = timeStampToDate(timeStamp: Int(self.task?.createdAt ?? 00))
                self.customerNameLbl.text = self.task?.customerName
                self.callerLbl.text = self.task?.callerName
                self.timeWhenTheyCalledLbl.text = timeStampToDate(timeStamp: Int(self.task?.calledTime ?? 00))
                self.callerPhoneNumberLbl.text = self.task?.callerPhone
                self.milesLbl.text = "\(self.task?.miles ?? 0)"
                self.locationLbl.attributedText = changeUnderLineColor(text: self.task?.jobLocation ?? "")
                self.purchasedOrderLbl.text = self.purchasedOrderTxtField.text ?? ""
                
                self.task?.issueReported = self.issueReportLbl.text
                self.task?.createdAt = self.task?.createdAt
                self.task?.customerName = self.task?.customerName
                self.task?.callerName = self.callerLbl.text ?? ""
                self.task?.calledTime = self.task?.calledTime
                self.task?.callerPhone = self.callerPhoneNumberLbl.text ?? ""
                self.task?.miles = self.task?.miles
                self.task?.jobLocation = self.locationLbl.text ?? ""
                self.task?.purchasedOrder = self.purchasedOrderTxtField.text ?? ""
                
                FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                    guard let self = self else {return}
                    if status{
                        print("True")
                        self.purchasedOrderTxtField.isHidden = true
                        self.purchasedOrderSaveBtn.isHidden = true
                        self.purchasedOrderEditBtn.isHidden = false
                        self.purchasedOrderLbl.isHidden = false
                        self.heightPurchasedOrderTxtField.constant = 0
                        self.topPurchaseOrderedTxtField.constant = 15
                        self.purchasedOrderLbl.text = self.purchasedOrderTxtField.text
                        self.getTaskInfo { (status) in
                            if status{
                                self.purchasedOrderLbl.text = self.purchasedOrderTxtField.text
                            }
                        }
                    }
                }
            }else{
                AlertService().showAlert(on: self, title: "Alert", message: "This Job is not assigned to you anymore", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
        
    }
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        
        openMapButtonAction(latitude: task?.jobCoordinates?.lat ?? 0.0, longitude: task?.jobCoordinates?.lng ?? 0.0, viewcontroller: self)
    }
    
    //Ashok
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
         getTaskInfo { (status) in
                   if status{
                    if self.task?.jobStatus == 2 || self.task?.jobStatus == 6{
                        self.task?.issueReported = self.issueReportLbl.text ?? ""
                        self.task?.createdAt = self.task?.createdAt ?? 00
                        self.task?.customerName = self.customerNameTxtField.text ?? ""
                        self.task?.callerName = self.callerTxtField.text ?? ""
                        self.task?.calledTime = self.task?.calledTime ?? 00
                        self.task?.callerPhone = self.callerPhoneNumberTxtField.text ?? ""
                        self.task?.miles = self.task?.miles ?? 00
                        self.task?.jobLocation = self.locationTxtField.text ?? ""
                        self.task?.purchasedOrder = self.purchasedOrderTxtField.text ?? ""
                        self.task?.jobStatus = 3
                        self.task?.dispatchedTime = String(Date.currentTimeStamp)
                           
                        FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                               guard let self = self else {return}
                               if status{
                                   self.getTaskInfo { (status) in
                                       if status{
                                        self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Dispatched", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                                           FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 3, notificationId: "") { (satus) in
                                               if status{
                                                   print(status)
                                                   self.performSegue(withIdentifier: "taskInfoVCToEditTaskInfoVC", sender: nil)
                                               }
                                           }
                                       }
                                   }
                               }
                           }
                       }else{
                           self.performSegue(withIdentifier: "taskInfoVCToEditTaskInfoVC", sender: nil)
                       }
                   }else{
                       AlertService().showAlert(on: self, title: "Alert", message: "This Job is not assigned to you anymore", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: {
                           self.navigationController?.popViewController(animated: true)
                       })
                   }
               }
        
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditTaskInfoVC") as! EditTaskInfoVC
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func cloudFunction(customerName: String, employeeName: String, jobId: String, jobStatus: String, randomTaskId: String, callerPhone: String, sitePersonPhone: String, createdBy: String){
        functions.httpsCallable("notifyOnJobStatusChange").call(["customerName": customerName, "employeeName": employeeName, "jobId": jobId, "jobStatus": jobStatus, "randomTaskId": randomTaskId, "callerPhone": callerPhone, "sitePersonPhone": sitePersonPhone,"createdBy": createdBy]) { (result, error) in
      if let error = error as NSError? {
        if error.domain == FunctionsErrorDomain {
          let code = FunctionsErrorCode(rawValue: error.code)
          let message = error.localizedDescription
          let details = error.userInfo[FunctionsErrorDetailsKey]
        }
        // ...
      }
      if let text = (result?.data as? [String: Any])?["text"] as? String {
        print(text)
      }
    }
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
            guard let self = self else {return}
            if status{
                self.performSegue(withIdentifier: "taskInfoVCToEditTaskInfoVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskInfoVCToEditTaskInfoVC"{
            if let destination = segue.destination as? EditTaskInfoVC{
                destination.task = task
            }
        }
    }
}

extension TaskInfoVC : UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //Ashok
        switch textField {
        case issueReportTxtField:
            task?.issueReported = issueReportTxtField.text ?? ""
        case timeReportStartedTxtField:
            task?.createdAt = task?.createdAt ?? 00
        case customerNameTxtField:
            task?.customerName = customerNameTxtField.text ?? ""
        case callerTxtField:
            task?.callerName = callerTxtField.text ?? ""
        case timeWhenTheyCalledTxtField:
            task?.calledTime = task?.calledTime ?? 00
        case callerPhoneNumberTxtField:
            task?.callerPhone = callerPhoneNumberTxtField.text ?? ""
        case milesTxtField:
            task?.miles = task?.miles ?? 00
        case locationTxtField:
            task?.jobLocation = locationTxtField.text ?? ""
        case purchasedOrderTxtField:
            task?.purchasedOrder = purchasedOrderTxtField.text ?? ""
            print("TaskData: \(String(describing: task))")
        default:
            print("Default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        if textField == purchasedOrderTextField{
        //            task?.purchasedOrder = textField.text
        //        }
        
        //        timeReportStartedTxtField.text = timeStampToDate(timeStamp: task?.createdAt ?? 00)
        //        customerNameTxtField.text = task?.customerName
        //        callerTxtField.text = task?.callerName
        //        timeWhenTheyCalledTxtField.text = timeStampToTime(timeStamp: task?.calledTime ?? 00)
        //        callerPhoneNumberTxtField.text = task?.callerPhone
        //        milesTxtField.text = "\(String(describing: task?.miles))"
        //        locationTxtField.text = task?.jobLocation
        //        purchasedOrderTxtField.text = task?.purchasedOrder
        
        //Ashok
        switch textField {
        case issueReportTxtField:
            task?.issueReported = issueReportTxtField.text ?? ""
        case timeReportStartedTxtField:
            task?.createdAt = task?.createdAt ?? 00
        case customerNameTxtField:
            task?.customerName = customerNameTxtField.text ?? ""
        case callerTxtField:
            task?.callerName = callerTxtField.text ?? ""
        case timeWhenTheyCalledTxtField:
            task?.calledTime = task?.calledTime ?? 00
        case callerPhoneNumberTxtField:
            task?.callerPhone = callerPhoneNumberTxtField.text ?? ""
        case milesTxtField:
            task?.miles = task?.miles ?? 00
        case locationTxtField:
            task?.jobLocation = locationTxtField.text ?? ""
        case purchasedOrderTxtField:
            task?.purchasedOrder = purchasedOrderTxtField.text ?? ""
            print("TaskData: \(String(describing: task))")
        default:
            print("Default")
        }
    }
}





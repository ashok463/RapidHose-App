//
//  ConfirmationTaskProceedVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 09/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import DropDown
import FirebaseFunctions

class ConfirmationTaskProceedVC: UIViewController {
    
    weak var delegate : MoveToInspection?
    //    var task : Task?
    
    //Ashok
    @IBOutlet weak var lbltop: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusTittleLbl: UILabel!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var hoseSerialNumberTxtField: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField: NSLayoutConstraint!
    @IBOutlet weak var heightNextBtn: NSLayoutConstraint!
    @IBOutlet weak var topLayoutNextBtn: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField1: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField1: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField2: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField2: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField3: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField3: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField4: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField4: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField5: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField5: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField6: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField6: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField7: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField7: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField8: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField8: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField9: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField9: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField10: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField10: NSLayoutConstraint!
    
    @IBOutlet weak var topLayoutSerialTxtField1: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField2: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField3: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField4: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField5: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField6: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField7: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField8: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField9: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField10: NSLayoutConstraint!
    
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var statusBtn6: UIButton!
    
    //Ashok
    var task : Task_modelClass?
    let dropDown = DropDown()
    weak var editTaskInfoVC : EditTaskInfoVC?

    lazy var functions = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yesBtn.btnCornerRadius(radius: 5.0)
        noBtn.btnCornerRadius(radius: 5.0)
        nextBtn.btnCornerRadius(radius: 5.0)
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        statusBtn6.btnCornerRadius(radius: statusBtn6.frame.width/2)
        
        
        lbltop.text = "Task Id : \(task?.randomTaskId ?? 0)"
        statusTittleLbl.text = JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus()
        statusImg.image = UIImage.init(named: (JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())!)
        
        hoseSerialNumberTxtField.isHidden = true
        heightSerialNumberTxtField.constant = 0
        topLayoutSerialTxtField.constant = 0
        nextBtn.isHidden = true
        heightNextBtn.constant = 0
        topLayoutNextBtn.constant = 0
        dropDown.anchorView = hoseSerialNumberTxtField
        dropDown.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        dropDown.width = hoseSerialNumberTxtField.frame.width
        dropDown.direction = .bottom
        
        hoseSerialNumberTxtField.setRightIcon("dropDown_ic")
        
        heightSerialNumberTxtField1.constant = 0
        heightSerialNumberTxtField2.constant = 0
        heightSerialNumberTxtField3.constant = 0
        heightSerialNumberTxtField4.constant = 0
        heightSerialNumberTxtField5.constant = 0
        heightSerialNumberTxtField6.constant = 0
        heightSerialNumberTxtField7.constant = 0
        heightSerialNumberTxtField8.constant = 0
        heightSerialNumberTxtField9.constant = 0
        heightSerialNumberTxtField10.constant = 0
        
        topLayoutSerialTxtField1.constant = 0
        topLayoutSerialTxtField2.constant = 0
        topLayoutSerialTxtField3.constant = 0
        topLayoutSerialTxtField4.constant = 0
        topLayoutSerialTxtField5.constant = 0
        topLayoutSerialTxtField6.constant = 0
        topLayoutSerialTxtField7.constant = 0
        topLayoutSerialTxtField8.constant = 0
        topLayoutSerialTxtField9.constant = 0
        topLayoutSerialTxtField10.constant = 0
        
        dropDown.selectRow(0)
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.hoseSerialNumberTxtField.text = item
            if item == "1"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 0
                self.heightSerialNumberTxtField3.constant = 0
                self.heightSerialNumberTxtField4.constant = 0
                self.heightSerialNumberTxtField5.constant = 0
                self.heightSerialNumberTxtField6.constant = 0
                self.heightSerialNumberTxtField7.constant = 0
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 0
                self.topLayoutSerialTxtField3.constant = 0
                self.topLayoutSerialTxtField4.constant = 0
                self.topLayoutSerialTxtField5.constant = 0
                self.topLayoutSerialTxtField6.constant = 0
                self.topLayoutSerialTxtField7.constant = 0
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
                
            }
            if item == "2"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 0
                self.heightSerialNumberTxtField4.constant = 0
                self.heightSerialNumberTxtField5.constant = 0
                self.heightSerialNumberTxtField6.constant = 0
                self.heightSerialNumberTxtField7.constant = 0
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 0
                self.topLayoutSerialTxtField4.constant = 0
                self.topLayoutSerialTxtField5.constant = 0
                self.topLayoutSerialTxtField6.constant = 0
                self.topLayoutSerialTxtField7.constant = 0
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "3"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 0
                self.heightSerialNumberTxtField5.constant = 0
                self.heightSerialNumberTxtField6.constant = 0
                self.heightSerialNumberTxtField7.constant = 0
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 0
                self.topLayoutSerialTxtField5.constant = 0
                self.topLayoutSerialTxtField6.constant = 0
                self.topLayoutSerialTxtField7.constant = 0
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "4"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 0
                self.heightSerialNumberTxtField6.constant = 0
                self.heightSerialNumberTxtField7.constant = 0
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 0
                self.topLayoutSerialTxtField6.constant = 0
                self.topLayoutSerialTxtField7.constant = 0
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "5"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 40
                self.heightSerialNumberTxtField6.constant = 0
                self.heightSerialNumberTxtField7.constant = 0
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 10
                self.topLayoutSerialTxtField6.constant = 0
                self.topLayoutSerialTxtField7.constant = 0
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "6"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 40
                self.heightSerialNumberTxtField6.constant = 40
                self.heightSerialNumberTxtField7.constant = 0
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 10
                self.topLayoutSerialTxtField6.constant = 10
                self.topLayoutSerialTxtField7.constant = 0
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "7"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 40
                self.heightSerialNumberTxtField6.constant = 40
                self.heightSerialNumberTxtField7.constant = 40
                self.heightSerialNumberTxtField8.constant = 0
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 10
                self.topLayoutSerialTxtField6.constant = 10
                self.topLayoutSerialTxtField7.constant = 10
                self.topLayoutSerialTxtField8.constant = 0
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "8"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 40
                self.heightSerialNumberTxtField6.constant = 40
                self.heightSerialNumberTxtField7.constant = 40
                self.heightSerialNumberTxtField8.constant = 40
                self.heightSerialNumberTxtField9.constant = 0
                self.heightSerialNumberTxtField10.constant = 0
                
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 10
                self.topLayoutSerialTxtField6.constant = 10
                self.topLayoutSerialTxtField7.constant = 10
                self.topLayoutSerialTxtField8.constant = 10
                self.topLayoutSerialTxtField9.constant = 0
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "9"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 40
                self.heightSerialNumberTxtField6.constant = 40
                self.heightSerialNumberTxtField7.constant = 40
                self.heightSerialNumberTxtField8.constant = 40
                self.heightSerialNumberTxtField9.constant = 40
                self.heightSerialNumberTxtField10.constant = 0
                
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 10
                self.topLayoutSerialTxtField6.constant = 10
                self.topLayoutSerialTxtField7.constant = 10
                self.topLayoutSerialTxtField8.constant = 10
                self.topLayoutSerialTxtField9.constant = 10
                self.topLayoutSerialTxtField10.constant = 0
            }
            
            if item == "10"{
                self.heightSerialNumberTxtField1.constant = 40
                self.heightSerialNumberTxtField2.constant = 40
                self.heightSerialNumberTxtField3.constant = 40
                self.heightSerialNumberTxtField4.constant = 40
                self.heightSerialNumberTxtField5.constant = 40
                self.heightSerialNumberTxtField6.constant = 40
                self.heightSerialNumberTxtField7.constant = 40
                self.heightSerialNumberTxtField8.constant = 40
                self.heightSerialNumberTxtField9.constant = 40
                self.heightSerialNumberTxtField10.constant = 40
                
                
                self.topLayoutSerialTxtField1.constant = 10
                self.topLayoutSerialTxtField2.constant = 10
                self.topLayoutSerialTxtField3.constant = 10
                self.topLayoutSerialTxtField4.constant = 10
                self.topLayoutSerialTxtField5.constant = 10
                self.topLayoutSerialTxtField6.constant = 10
                self.topLayoutSerialTxtField7.constant = 10
                self.topLayoutSerialTxtField8.constant = 10
                self.topLayoutSerialTxtField9.constant = 10
                self.topLayoutSerialTxtField10.constant = 10
                
            }
        }
    }
    
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        
        getTaskInfo()
    }
    
    func getTaskInfo(){
        FirestoreManager.shared.getSingleTaskInformation(taskId: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.taskID) as? String ?? "") { (status, taskModelData) in
            if status{
                self.task = taskModelData[0]
                self.viewDidLoad()
            }
        }
    }
    
    @IBAction func btnHoseSerialNoAction(_ sender: UIButton) {
        
        dropDown.show()
    }
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.init(red: 172/255, green: 36/255, blue: 42/255, alpha: 1.0000)
        noBtn.backgroundColor = .black
        hoseSerialNumberTxtField.isHidden = false
        heightSerialNumberTxtField.constant = 40
        topLayoutSerialTxtField.constant = 20
        heightSerialNumberTxtField1.constant = 40
        topLayoutSerialTxtField1.constant = 20
        self.hoseSerialNumberTxtField.text = "1"
        self.hoseSerialNumberTxtField1.text = ""
        self.hoseSerialNumberTxtField2.text = ""
        self.hoseSerialNumberTxtField3.text = ""
        self.hoseSerialNumberTxtField4.text = ""
        self.hoseSerialNumberTxtField5.text = ""
        self.hoseSerialNumberTxtField6.text = ""
        self.hoseSerialNumberTxtField7.text = ""
        self.hoseSerialNumberTxtField8.text = ""
        self.hoseSerialNumberTxtField9.text = ""
        self.hoseSerialNumberTxtField10.text = ""
        
        nextBtn.isHidden = false
        heightNextBtn.constant = 40
        topLayoutNextBtn.constant = 20
        nextBtn.setTitle("Completed", for: .normal)
    }
    
    @IBAction func noBtnAction(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.init(red: 172/255, green: 36/255, blue: 42/255, alpha: 1.0000)
        yesBtn.backgroundColor = .black
        hoseSerialNumberTxtField.isHidden = true
        hoseSerialNumberTxtField.text = ""
        heightSerialNumberTxtField.constant = 0
        self.heightSerialNumberTxtField1.constant = 0
        self.heightSerialNumberTxtField2.constant = 0
        self.heightSerialNumberTxtField3.constant = 0
        self.heightSerialNumberTxtField4.constant = 0
        self.heightSerialNumberTxtField5.constant = 0
        self.heightSerialNumberTxtField6.constant = 0
        self.heightSerialNumberTxtField7.constant = 0
        self.heightSerialNumberTxtField8.constant = 0
        self.heightSerialNumberTxtField9.constant = 0
        self.heightSerialNumberTxtField10.constant = 0
        
        
        self.topLayoutSerialTxtField1.constant = 0
        self.topLayoutSerialTxtField2.constant = 0
        self.topLayoutSerialTxtField3.constant = 0
        self.topLayoutSerialTxtField4.constant = 0
        self.topLayoutSerialTxtField5.constant = 0
        self.topLayoutSerialTxtField6.constant = 0
        self.topLayoutSerialTxtField7.constant = 0
        self.topLayoutSerialTxtField8.constant = 0
        self.topLayoutSerialTxtField9.constant = 0
        self.topLayoutSerialTxtField10.constant = 0
        
        nextBtn.isHidden = false
        heightNextBtn.constant = 40
        topLayoutNextBtn.constant = 20
        nextBtn.setTitle("Next", for: .normal)

    }
    
    func cloudFunction(customerName: String, employeeName: String, jobId: String, jobStatus: String, randomTaskId: String, callerPhone: String, sitePersonPhone: String, createdBy: String){
        functions.httpsCallable("notifyOnJobStatusChange").call(["customerName": customerName, "employeeName": employeeName, "jobId": jobId, "jobStatus": jobStatus, "randomTaskId": randomTaskId, "callerPhone": callerPhone, "sitePersonPhone": sitePersonPhone, "createdBy": createdBy]) { (result, error) in
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
    
    func cloudFunctionSaveEstimateTime(jobCompletedTime: String, jobStartedTime: String, time4: Int, time5: Int, taskId: String){
        functions.httpsCallable("calculateDistance").call(["jobCompletedTime": jobCompletedTime, "jobStartedTime": jobStartedTime, "time4": time4, "time5": time4, "taskId": taskId]) { (result, error) in
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
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if nextBtn.currentTitle == "Next"{
            print("Next")
             task?.DoYouOnlyBuildTheHose = false
            FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                guard let self = self else {return}
                self.dismiss(animated: true) {
                    self.delegate?.moveToInspectionVC?()
                }
                //                        self.navigationController?.popToRootViewController(animated: true)
            }
        }else {
            
            print("Completed")
            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField){
            guard let delegate = delegate else {return}
                task?.DoYouOnlyBuildTheHose = true
                if hoseSerialNumberTxtField.text == "1"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "2"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "3"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "4"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "5"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "6"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "7"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "8"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "9"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8, hoseSerialNumberTxtField9){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? "")"
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
                if hoseSerialNumberTxtField.text == "10"{
                    if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8, hoseSerialNumberTxtField9, hoseSerialNumberTxtField10){
                        task?.hoseSerialNumber = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
                        
                        task?.DoYouOnlyBuildTheHose = true
                        self.task?.jobStatus = 5
                        self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                        
                        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
                            guard let self = self else {return}
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    self.dismiss(animated: true) {
                                        
                                        self.delegate?.moveToMainVC?()
                                    }
                                }
                            }
                        }
                    }
                }
                
            
        }
        }
    }
    
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        
        
        guard let delegate = delegate else {return}
        //        task?.DoYouOnlyBuildTheHose = false
        FirestoreManager.shared.updateTaskInformation(task: task!) {[weak self] (status) in
            guard let self = self else {return}
            self.dismiss(animated: true) {
                delegate.moveToInspectionVC?()
            }
        }
        
        
    }
    
}

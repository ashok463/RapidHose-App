//
//  editTaskInfoVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 09/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import MRCountryPicker
import FirebaseFunctions

@objc protocol MoveToInspection{
    @objc optional func moveToInspectionVC()
    @objc optional func moveToMainVC()
}

class EditTaskInfoVC: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var siteContactTextField: UITextField!
    @IBOutlet weak var machineTypeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var unitNumberTextField: UITextField!
    
    //Ashok
    @IBOutlet weak var lbltop: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusTittleLbl: UILabel!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var statusBtn6: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var siteContactEditBtn: UIButton!
    @IBOutlet weak var siteContactSaveBtn: UIButton!
    @IBOutlet weak var siteContactPhoneNumberEditBtn: UIButton!
    @IBOutlet weak var siteContactPhoneNumberSaveBtn: UIButton!
    
    @IBOutlet weak var machineTypeEditBtn: UIButton!
    @IBOutlet weak var machineTypeSaveBtn: UIButton!
    @IBOutlet weak var modelEditBtn: UIButton!
    @IBOutlet weak var modelSaveBtn: UIButton!
    @IBOutlet weak var machineSerialNumberEditBtn: UIButton!
    @IBOutlet weak var machineSerialNumberSaveBtn: UIButton!
    @IBOutlet weak var unitNoEditBtn: UIButton!
    @IBOutlet weak var unitNoSaveBtn: UIButton!
    @IBOutlet weak var siteContactTxtField: UITextField!
    @IBOutlet weak var siteContactPhoneCodeTxtField: UITextField!
    @IBOutlet weak var siteContactPhoneNumberTxtField: UITextField!
    @IBOutlet weak var machineTypeTxtField: UITextField!
    @IBOutlet weak var modelTxtField: UITextField!
    @IBOutlet weak var machineSerialNumberTxtField: UITextField!
    @IBOutlet weak var unitNoTxtField: UITextField!
    @IBOutlet weak var siteContactLbl: UILabel!
    @IBOutlet weak var siteContactPhoneLbl: UILabel!
    @IBOutlet weak var machineTypeLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var machineSerialNumberLbl: UILabel!
    @IBOutlet weak var unitNoLbl: UILabel!
    
    @IBOutlet weak var heightSitecontactTxtField: NSLayoutConstraint!
    @IBOutlet weak var topSitecontactTxtField: NSLayoutConstraint!
    @IBOutlet weak var heightSitecontactPhoneNumberTxtField: NSLayoutConstraint!
    
    @IBOutlet weak var topSitecontactPhonenumberTxtField: NSLayoutConstraint!
    @IBOutlet weak var heightMachineTypeTxtField: NSLayoutConstraint!
    @IBOutlet weak var topMachineTypeTxtField: NSLayoutConstraint!
    @IBOutlet weak var heightModelTxtField: NSLayoutConstraint!
    @IBOutlet weak var topModelTxtField: NSLayoutConstraint!
    @IBOutlet weak var heightMachineSerialNumberTxtField: NSLayoutConstraint!
    @IBOutlet weak var topMachineSerialNumberTxtField: NSLayoutConstraint!
    @IBOutlet weak var heightUnitNoTxtField: NSLayoutConstraint!
    @IBOutlet weak var topUnitNoTxtField: NSLayoutConstraint!
    
    @IBOutlet weak var countryCodePickerView: MRCountryPicker!
    
    @IBOutlet weak var siteContactPhoneImg: UIImageView!
    
    
    lazy var functions = Functions.functions()
    
    var task : Task_modelClass?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodePickerView.backgroundColor = .white
        countryCodePickerView.isHidden = true
        countryCodePickerView.countryPickerDelegate = self
        
        siteContactTextField.delegate = self
        siteContactPhoneNumberTxtField.delegate = self
        siteContactPhoneCodeTxtField.delegate = self
        machineTypeTextField.delegate = self
        modelTextField.delegate = self
        serialNumberTextField.delegate = self
        unitNumberTextField.delegate = self
        
        siteContactTxtField.delegate = self
        machineTypeTxtField.delegate = self
        modelTxtField.delegate = self
        machineSerialNumberTxtField.delegate = self
        unitNoTxtField.delegate = self
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        statusBtn6.btnCornerRadius(radius: statusBtn6.frame.width/2)
        
        nextBtn.btnCornerRadius(radius: 5.0)
        
        siteContactTxtField.isHidden = true
        siteContactSaveBtn.isHidden = true
        siteContactPhoneNumberTxtField.isHidden = true
        siteContactPhoneNumberSaveBtn.isHidden = true
        machineTypeTxtField.isHidden = true
        machineTypeSaveBtn.isHidden = true
        modelTxtField.isHidden = true
        modelSaveBtn.isHidden = true
        machineSerialNumberTxtField.isHidden = true
        machineSerialNumberSaveBtn.isHidden = true
        unitNoTxtField.isHidden = true
        unitNoSaveBtn.isHidden = true
        
        heightSitecontactTxtField.constant = 0
        heightSitecontactPhoneNumberTxtField.constant = 0
        heightMachineTypeTxtField.constant = 0
        heightModelTxtField.constant = 0
        heightMachineSerialNumberTxtField.constant = 0
        heightUnitNoTxtField.constant = 0
        
        lbltop.text = "Task Id : \(task?.randomTaskId ?? 0)"
        statusTittleLbl.text = JobStatus(rawValue: task?.jobStatus ?? 0)?.getJobStatus()
        statusImg.image = UIImage.init(named: (JobStatus(rawValue: task?.jobStatus ?? 0)?.getJobStatus()) ?? "New")
        siteContactTxtField.text = task?.sitePersonName
        
        
        siteContactPhoneNumberTxtField.text = task?.sitePersonPhone
        machineTypeTextField.text = task?.machineType
        modelTxtField.text = task?.machineModel
        machineSerialNumberTxtField.text = task?.machineSerialNo
        unitNoTxtField.text = task?.unitNo
        
        siteContactLbl.text = task?.sitePersonName
        siteContactPhoneLbl.attributedText = changeUnderLineColor(text: task?.sitePersonPhone ?? "")
        machineTypeLbl.text = task?.machineType
        modelLbl.text = task?.machineModel
        machineSerialNumberLbl.text = task?.machineSerialNo
        unitNoLbl.text = task?.unitNo
        
        if siteContactLbl.text == "" || siteContactLbl.text == nil{
            topSitecontactTxtField.constant = 25
        }else{
            topSitecontactTxtField.constant = 15
        }
        
        if siteContactPhoneLbl.text == "" || siteContactPhoneLbl.text == nil{
            topSitecontactPhonenumberTxtField.constant = 32
        }else{
            topSitecontactPhonenumberTxtField.constant = 15
        }
        
        if machineTypeLbl.text == "" || machineTypeLbl.text == nil{
            topMachineTypeTxtField.constant = 25
        }else{
            topMachineTypeTxtField.constant = 15
        }
        
        if modelLbl.text == "" || modelLbl.text == nil{
            topModelTxtField.constant = 25
        }else{
            topModelTxtField.constant = 15
        }
        
        if machineSerialNumberLbl.text == "" || machineSerialNumberLbl.text == nil{
            topMachineSerialNumberTxtField.constant = 25
        }else{
            topMachineSerialNumberTxtField.constant = 15
        }
        
        if unitNoLbl.text == "" || unitNoLbl.text == nil{
            topUnitNoTxtField.constant = 25
        }else{
            topUnitNoTxtField.constant = 15
        }
        
        if task?.sitePersonPhone == ""{
            siteContactPhoneImg.image = UIImage.init(named: "callerphonenumberIc")
        }else{
            siteContactPhoneImg.image = UIImage.init(named: "callerphonenumberRedIc")
        }
        
        if task?.jobStatus == 3{
            nextBtn.setTitle("Start Job", for: .normal)
        }else{
            nextBtn.setTitle("Next", for: .normal)
        }
        
        scrollView.scrollsToBottom(animated: true)
        
        siteContactPhoneLbl.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.phoneNumberLabelTap))
        tap.delegate = self
        siteContactPhoneLbl.addGestureRecognizer(tap)
        
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
        
        //        let scrollSize = CGSize(width: backgroundImg.frame.size.width, height: backgroundTxtView.frame.size.height + 50)
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
            if status{
                self.task = taskModelData[0]
                completion(status)
            }else{
                completion(status)
            }
        }
        
    }
    
    @objc func phoneNumberLabelTap(){
        
        //        let coord = task?.sitePersonPhone?.components(separatedBy: "-")
        //        let code = String(coord?[0] ?? "")
        //        let phone = String(coord?[1] ?? "")
        //        siteContactPhoneCodeTxtField.text = code
        //        siteContactPhoneNumberTxtField.text = phone
        
        if let url = URL(string: "tel://\(task?.sitePersonPhone ?? "")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }else {
            AlertService().showAlert(on: self, title: "Alert", message: "Your device doesn't support this feature.", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: nil)
        }
    }
    
    
    @IBAction func siteContactEditBtnAction(_ sender: UIButton) {
        
        siteContactTxtField.isHidden = false
        siteContactSaveBtn.isHidden = false
        siteContactEditBtn.isHidden = true
        siteContactLbl.isHidden = true
        heightSitecontactTxtField.constant = 40
        
        if siteContactLbl.text == "" || siteContactLbl.text == nil{
            topSitecontactTxtField.constant = 25
        }else{
            topSitecontactTxtField.constant = 15
        }
    }
    
    @IBAction func siteContactSaveBtnAction(_ sender: UIButton) {
        
        task?.sitePersonName = siteContactTxtField.text ?? ""
        task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        task?.machineType = machineTypeTxtField.text ?? ""
        task?.machineModel = modelTxtField.text ?? ""
        task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        task?.unitNo = unitNoTxtField.text ?? ""
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.siteContactTxtField.isHidden = true
                self.siteContactSaveBtn.isHidden = true
                self.siteContactEditBtn.isHidden = false
                self.siteContactLbl.isHidden = false
                self.heightSitecontactTxtField.constant = 0
                self.topSitecontactTxtField.constant = 15
                self.siteContactLbl.text = self.siteContactTxtField.text
                self.getTaskInfo { (status) in
                    if status{
                        self.siteContactLbl.text = self.siteContactTxtField.text
                    }
                }
            }
        }
    }
    
    @IBAction func siteContactPhoneNumberEditBtnAction(_ sender: UIButton) {
        
        siteContactPhoneNumberTxtField.isHidden = false
        siteContactPhoneNumberSaveBtn.isHidden = false
        siteContactPhoneNumberEditBtn.isHidden = true
        siteContactPhoneLbl.isHidden = true
        heightSitecontactPhoneNumberTxtField.constant = 40
        
        if siteContactPhoneLbl.text == "" || siteContactPhoneLbl.text == nil{
            topSitecontactPhonenumberTxtField.constant = 32
        }else{
            topSitecontactPhonenumberTxtField.constant = 15
            //            let coord = task?.sitePersonPhone?.components(separatedBy: "-")
            //            let code = String(coord?[0] ?? "")
            //            let phone = String(coord?[1] ?? "")
            //            siteContactPhoneCodeTxtField.text = code
            //            siteContactPhoneNumberTxtField.text = phone
        }
    }
    
    @IBAction func siteContactPhoneNumberSaveBtnAction(_ sender: UIButton) {
        
        task?.sitePersonName = siteContactTxtField.text ?? ""
        //        task?.sitePersonPhone = "\(siteContactPhoneCodeTxtField.text ?? "")-\(siteContactPhoneNumberTxtField.text ?? "")"
        task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        task?.machineType = machineTypeTxtField.text ?? ""
        task?.machineModel = modelTxtField.text ?? ""
        task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        task?.unitNo = unitNoTxtField.text ?? ""
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.siteContactPhoneNumberTxtField.isHidden = true
                self.siteContactPhoneNumberSaveBtn.isHidden = true
                self.siteContactPhoneNumberEditBtn.isHidden = false
                self.siteContactPhoneLbl.isHidden = false
                self.heightSitecontactPhoneNumberTxtField.constant = 0
                self.topSitecontactPhonenumberTxtField.constant = 15
                //                self.siteContactPhoneLbl.text = "\(self.siteContactPhoneCodeTxtField.text ?? "")-\(self.siteContactPhoneNumberTxtField.text ?? "")"
                self.siteContactPhoneLbl.attributedText = changeUnderLineColor(text: self.siteContactPhoneNumberTxtField.text ?? "")
                self.getTaskInfo { (status) in
                    if status{
                        //                        self.siteContactPhoneLbl.text = "\(self.siteContactPhoneCodeTxtField.text ?? "")-\(self.siteContactPhoneNumberTxtField.text ?? "")"
                        self.siteContactPhoneLbl.attributedText = changeUnderLineColor(text: self.siteContactPhoneNumberTxtField.text ?? "")
                    }
                }
            }
        }
    }
    
    @IBAction func machineTypeEditBtnAction(_ sender: UIButton) {
        
        machineTypeTxtField.isHidden = false
        machineTypeSaveBtn.isHidden = false
        machineTypeEditBtn.isHidden = true
        machineTypeLbl.isHidden = true
        heightMachineTypeTxtField.constant = 40
        
        if machineTypeLbl.text == "" || machineTypeLbl.text == nil{
            topMachineTypeTxtField.constant = 25
        }else{
            topMachineTypeTxtField.constant = 15
        }
    }
    
    @IBAction func machineTypeSaveBtnAction(_ sender: UIButton) {
        
        task?.sitePersonName = siteContactTxtField.text ?? ""
        task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        task?.machineType = machineTypeTxtField.text ?? ""
        task?.machineModel = modelTxtField.text ?? ""
        task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        task?.unitNo = unitNoTxtField.text ?? ""
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.machineTypeTxtField.isHidden = true
                self.machineTypeSaveBtn.isHidden = true
                self.machineTypeEditBtn.isHidden = false
                self.machineTypeLbl.isHidden = false
                self.heightMachineTypeTxtField.constant = 0
                self.topMachineTypeTxtField.constant = 15
                self.machineTypeLbl.text = self.machineTypeTxtField.text
                self.getTaskInfo { (status) in
                    if status{
                        self.machineTypeLbl.text = self.machineTypeTxtField.text
                    }
                }
            }
        }
    }
    
    @IBAction func modelEditBtnAction(_ sender: UIButton) {
        
        modelTxtField.isHidden = false
        modelSaveBtn.isHidden = false
        modelEditBtn.isHidden = true
        modelLbl.isHidden = true
        heightModelTxtField.constant = 40
        
        if modelLbl.text == "" || modelLbl.text == nil{
            topModelTxtField.constant = 25
        }else{
            topModelTxtField.constant = 15
        }
    }
    
    @IBAction func modelSaveBtnAction(_ sender: UIButton) {
        
        task?.sitePersonName = siteContactTxtField.text ?? ""
        task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        task?.machineType = machineTypeTxtField.text ?? ""
        task?.machineModel = modelTxtField.text ?? ""
        task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        task?.unitNo = unitNoTxtField.text ?? ""
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.modelTxtField.isHidden = true
                self.modelSaveBtn.isHidden = true
                self.modelEditBtn.isHidden = false
                self.modelLbl.isHidden = false
                self.heightModelTxtField.constant = 0
                self.topModelTxtField.constant = 15
                self.modelLbl.text = self.modelTxtField.text
                self.getTaskInfo { (status) in
                    if status{
                        self.modelLbl.text = self.modelTxtField.text
                    }
                }
            }
        }
    }
    
    @IBAction func machineSerialNumberEditBtnAction(_ sender: UIButton) {
        
        machineSerialNumberTxtField.isHidden = false
        machineSerialNumberSaveBtn.isHidden = false
        machineSerialNumberEditBtn.isHidden = true
        machineSerialNumberLbl.isHidden = true
        
        heightMachineSerialNumberTxtField.constant = 40
        
        if machineSerialNumberLbl.text == "" || machineSerialNumberLbl.text == nil{
            topMachineSerialNumberTxtField.constant = 25
        }else{
            topMachineSerialNumberTxtField.constant = 15
        }
    }
    
    @IBAction func machineSerialNumberSaveBtnAction(_ sender: UIButton) {
        
        task?.sitePersonName = siteContactTxtField.text ?? ""
        task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        task?.machineType = machineTypeTxtField.text ?? ""
        task?.machineModel = modelTxtField.text ?? ""
        task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        task?.unitNo = unitNoTxtField.text ?? ""
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.machineSerialNumberTxtField.isHidden = true
                self.machineSerialNumberSaveBtn.isHidden = true
                self.machineSerialNumberEditBtn.isHidden = false
                self.machineSerialNumberLbl.isHidden = false
                self.heightMachineSerialNumberTxtField.constant = 0
                self.topMachineSerialNumberTxtField.constant = 15
                self.machineSerialNumberLbl.text = self.machineSerialNumberTxtField.text
                self.getTaskInfo { (status) in
                    if status{
                        self.machineSerialNumberLbl.text = self.machineSerialNumberTxtField.text
                    }
                }
            }
        }
    }
    
    @IBAction func unitNoEditBtnAction(_ sender: UIButton) {
        
        unitNoTxtField.isHidden = false
        unitNoSaveBtn.isHidden = false
        unitNoEditBtn.isHidden = true
        unitNoLbl.isHidden = true
        heightUnitNoTxtField.constant = 40
        
        if unitNoLbl.text == "" || unitNoLbl.text == nil{
            topUnitNoTxtField.constant = 25
        }else{
            topUnitNoTxtField.constant = 15
        }
    }
    
    @IBAction func unitNoSaveBtnAction(_ sender: UIButton) {
        
        task?.sitePersonName = siteContactTxtField.text ?? ""
        task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        task?.machineType = machineTypeTxtField.text ?? ""
        task?.machineModel = modelTxtField.text ?? ""
        task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        task?.unitNo = unitNoTxtField.text ?? ""
        
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.unitNoTxtField.isHidden = true
                self.unitNoSaveBtn.isHidden = true
                self.unitNoEditBtn.isHidden = false
                self.unitNoLbl.isHidden = false
                self.heightUnitNoTxtField.constant = 0
                self.topUnitNoTxtField.constant = 15
                self.unitNoLbl.text = self.unitNoTxtField.text
                self.getTaskInfo { (status) in
                    if status{
                        self.unitNoLbl.text = self.unitNoTxtField.text
                    }
                }
            }
        }
    }
    
    //Ashok
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if task?.jobStatus == 3{
            task?.sitePersonName = siteContactLbl.text ?? ""
            task?.sitePersonPhone = siteContactPhoneLbl.text ?? ""
            task?.machineType = machineTypeLbl.text ?? ""
            task?.machineModel = modelLbl.text ?? ""
            task?.machineSerialNo = machineSerialNumberLbl.text ?? ""
            task?.unitNo = unitNoLbl.text ?? ""
            task?.jobStatus = 4
            task?.jobStartedTime = String(Date.currentTimeStamp)
            
            FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
                if status{
                    self.getTaskInfo { (status) in
                        if status{
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "InProgress", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", createdBy: self.task?.createdBy ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 4, notificationId: "") { (satus) in
                                if status{
                                    print(status)
                                    self.performSegue(withIdentifier: "editTaskInfoVCToConfirmationTaskProceedVC", sender: nil)
                                }
                            }
                            
                        }
                    }
                }
            }
        }else{
            self.performSegue(withIdentifier: "editTaskInfoVCToConfirmationTaskProceedVC", sender: nil)
        }
        
    }
    
    func cloudFunction(customerName: String, employeeName: String, jobId: String, jobStatus: String, randomTaskId: String, callerPhone: String, createdBy: String, sitePersonPhone: String){
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
        FirestoreManager.shared.updateTaskInformation(task: task!) { (status) in
            if status{
                self.performSegue(withIdentifier: "editTaskInfoVCToConfirmationTaskProceedVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        if segue.identifier == "editTaskInfoVCToConfirmationTaskProceedVC"{
        //            if let destination = segue.destination as? ConfirmationTaskProceedVC{
        //                destination.delegate = self
        //                destination.task = task
        //            }
        //        }
        
        if let destination = segue.destination as? ConfirmationTaskProceedVC{
            destination.delegate = self
            destination.editTaskInfoVC = self
            destination.task = task
        }
        
        if segue.identifier == "editTaskInfoVCToInspectionVCSegue"{
            if let destination = segue.destination as? InspectionVC{
                destination.task = task
            }
        }
    }
}


extension EditTaskInfoVC : UITextFieldDelegate{
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
        case siteContactTxtField:
            task?.sitePersonName = siteContactTxtField.text ?? ""
        case siteContactPhoneCodeTxtField:
            print("siteContactPhoneCodeTxtField")
            //            countryCodePickerView.isHidden = false
        //            siteContactPhoneCodeTxtField.inputView = countryCodePickerView
        case siteContactPhoneNumberTxtField:
            countryCodePickerView.isHidden = true
            task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        case machineTypeTxtField:
            task?.machineType = machineTypeTxtField.text ?? ""
        case modelTxtField:
            task?.machineModel = modelTxtField.text ?? ""
        case machineSerialNumberTxtField:
            task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        case unitNoTxtField:
            task?.unitNo = unitNoTxtField.text ?? ""
        default:
            print("Default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        switch textField {
        //        case siteContactTextField:
        //            task?.sitePersonName = siteContactTextField.text
        //        case machineTypeTextField:
        //            task?.machineType = machineTypeTextField.text
        //        case modelTextField:
        //            task?.model = modelTextField.text
        //        case serialNumberTextField:
        //            task?.machineSerialNumber = serialNumberTextField.text
        //        case unitNumberTextField:
        //            task?.unitNumber = unitNumberTextField.text
        //        default:
        //            print("Default")
        //        }
        
        //Ashok
        
        switch textField {
        case siteContactTxtField:
            task?.sitePersonName = siteContactTxtField.text ?? ""
        case siteContactPhoneCodeTxtField:
            //            countryCodePickerView.isHidden = false
            //            siteContactPhoneCodeTxtField.inputView = countryCodePickerView
            print("siteContactPhoneCodeTxtField")
        case siteContactPhoneNumberTxtField:
            countryCodePickerView.isHidden = true
            task?.sitePersonPhone = siteContactPhoneNumberTxtField.text ?? ""
        case machineTypeTxtField:
            task?.machineType = machineTypeTxtField.text ?? ""
        case modelTxtField:
            task?.machineModel = modelTxtField.text ?? ""
        case machineSerialNumberTxtField:
            task?.machineSerialNo = machineSerialNumberTxtField.text ?? ""
        case unitNoTxtField:
            task?.unitNo = unitNoTxtField.text ?? ""
        default:
            print("Default")
        }
    }
}

extension EditTaskInfoVC : MRCountryPickerDelegate{
    
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        
        self.siteContactPhoneCodeTxtField.text = phoneCode
    }
    
    
}


extension EditTaskInfoVC : MoveToInspection{
    func moveToInspectionVC() {
        performSegue(withIdentifier: "editTaskInfoVCToInspectionVCSegue", sender: nil)
    }
    
    func moveToMainVC() {
        guard let viewControllers = self.navigationController?.viewControllers else {return}
        if let mainVC = viewControllers[1] as? KYDrawerController{
            self.navigationController?.popToViewController(mainVC, animated: true)
        }else{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
}

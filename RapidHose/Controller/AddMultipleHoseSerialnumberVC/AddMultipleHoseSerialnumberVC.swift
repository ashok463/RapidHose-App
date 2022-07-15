//
//  AddMultipleHoseSerialnumberVC.swift
//  RapidHose
//
//  Created by Ashok on 19/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import DropDown

class AddMultipleHoseSerialnumberVC: UIViewController {

    /* IBOUTLETS*/
    @IBOutlet weak var hoseSerialNumberTxtField: UITextField!
       @IBOutlet weak var heightSerialNumberTxtField: NSLayoutConstraint!
       @IBOutlet weak var topLayoutSerialTxtField: NSLayoutConstraint!
    
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
    
    @IBOutlet weak var btnDone: UIButton!
    
    var dropDown = DropDown()
    var indexPath = Int()
    var task : Task_modelClass?
    var parameterInfo: ParameterInfo?
    var inspectionProperties = [ParameterInfo]()
    var taskId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dropDown.anchorView = hoseSerialNumberTxtField
        dropDown.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        dropDown.anchorView = hoseSerialNumberTxtField
        dropDown.width = hoseSerialNumberTxtField.frame.width
        dropDown.direction = .bottom
        
        hoseSerialNumberTxtField.setRightIcon("dropDown_ic")
        
        
        heightSerialNumberTxtField1.constant = 40
        heightSerialNumberTxtField2.constant = 0
        heightSerialNumberTxtField3.constant = 0
        heightSerialNumberTxtField4.constant = 0
        heightSerialNumberTxtField5.constant = 0
        heightSerialNumberTxtField6.constant = 0
        heightSerialNumberTxtField7.constant = 0
        heightSerialNumberTxtField8.constant = 0
        heightSerialNumberTxtField9.constant = 0
        heightSerialNumberTxtField10.constant = 0
        
        topLayoutSerialTxtField1.constant = 10
        topLayoutSerialTxtField2.constant = 0
        topLayoutSerialTxtField3.constant = 0
        topLayoutSerialTxtField4.constant = 0
        topLayoutSerialTxtField5.constant = 0
        topLayoutSerialTxtField6.constant = 0
        topLayoutSerialTxtField7.constant = 0
        topLayoutSerialTxtField8.constant = 0
        topLayoutSerialTxtField9.constant = 0
        topLayoutSerialTxtField10.constant = 0
        
        hoseSerialNumberTxtField.text = "1"
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
        
        getTaskInfo()
    }
    
    func getTaskInfo(){
        FirestoreManager.shared.getSingleTaskInformation(taskId: taskId) { (status, taskModelData) in
            if status{
                self.task = taskModelData[0]
            }
        }
    }
    
    @IBAction func hoseSerialNumberBtnAction(_ sender: UIButton) {
        dropDown.show()
    }
    
    
    @IBAction func btnDoneAction(_ sender: UIButton) {
        
//        if hoseSerialNumberTxtField.text == "1"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text!)"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "2"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2){
//
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "3"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3){
//
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "4"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "All hose serial number added successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "5"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "6"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "7"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "8"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "9"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8, hoseSerialNumberTxtField9){
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
//
//        if hoseSerialNumberTxtField.text == "10"{
//            if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8, hoseSerialNumberTxtField9, hoseSerialNumberTxtField10){
////                parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
//                task?.inspectionData?[indexPath].subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
//                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
//                    guard let self = self else {return}
//                    if status{
//                        AlertService().showAlert(on: self, title: "", message: "Added all hose serial number successfully", actionButtonTitle: "OK", alertType: .informationAlertType) {
//                            self.dismiss(animated: true, completion: nil)
//                        }
//                    }
//                }
//            }
//        }
    }

}

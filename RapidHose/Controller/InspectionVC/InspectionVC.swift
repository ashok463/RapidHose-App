//
//  InspectionVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 05/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class InspectionVC: UIViewController {
    
    @IBOutlet weak var inspectionPropertyTableView: UITableView!
    
    //Ashok
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusTittleLbl: UILabel!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var statusBtn6: UIButton!
    
    var inspectionProperties = [ParameterInfo]()
    var inspectionArr = ["Equipment running upon arrival?", "Visible oil contamination on site?", "Operator present?", "Oil level visible on reservoir gauge?", "Machine locked out / tagged out during repair?", "Hose assembly failure?", "New hose part Number?", "O-Ring failure?", "Pump, Cylinder or other failure?", "Wear & Tear?", "Site/Customer Damage?", "Repair Completed?", "Checked oil level?", "Refilled oil?", "Tested?"]
    
    var isRowInsertionRequired  = false
    //    var task : Task?
    
    var selectedRowIndex = -1
    var selectedCellIndexPath: NSIndexPath?
    
    var task : Task_modelClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inspectionPropertyTableView.dataSource = self
        inspectionPropertyTableView.delegate = self
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        statusBtn6.btnCornerRadius(radius: statusBtn6.frame.width/2)
        
        nextBtn.btnCornerRadius(radius: 5.0)
        
        print("Inspection \(JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())")
        statusTittleLbl.text = JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus()
        statusImg.image = UIImage.init(named: (JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())!)
        
        getInspectionProperties()
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
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
    
    //Ashok
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if task?.jobStatus == 4{
            
            if checkIfNoDataLeft(){
                task?.inspectionData = inspectionProperties
                print(task?.inspectionData?[1].subPropertyValue)
                print(task?.inspectionData?[2].subPropertyValue)
                print(task?.inspectionData?[3].subPropertyValue)
                print(task?.inspectionData?[4].subPropertyValue)
                print(task?.inspectionData?[5].subPropertyValue)
                print(task?.inspectionData?[6].subPropertyValue)
                print(task?.inspectionData?[7].subPropertyValue)
                print(task?.inspectionData?[8].subPropertyValue)
                print(task?.inspectionData?[9].subPropertyValue)
                print(task?.inspectionData?[10].subPropertyValue)
                
                FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
                    guard let self = self else {return}
                    if status{
                        self.getTaskInfo()
                        self.performSegue(withIdentifier: "inspectionVCToJobPerformedVC", sender: nil)
                    }
                }
            }
        }else{
            self.performSegue(withIdentifier: "inspectionVCToJobPerformedVC", sender: nil)
        }
        
    }
    
    //    func setInspectionProperties(){
    //        
    //        for index in 0..<inspectionArr.count{
    //            if index == 0{
    //                FirestoreManager.shared.setInspectionParameters(taskId: task?.taskId ?? "", PropertyName: inspectionArr[index]) { (status) in
    //                                if status {
    //                //                    self.getInspectionProperties()
    //                                }
    //                            }
    //            }else{
    //                FirestoreManager.shared.updateInspectionParameters(taskId: task?.taskId ?? "", PropertyName: inspectionArr[index]) { (status) in
    //                                if status {
    //                //                    self.getInspectionProperties()
    //                                }
    //                            }
    //            }
    //            
    //        }
    //        
    //        
    //    }
    
    func getInspectionProperties(){
        FirestoreManager.shared.getInspectionParameters { (status, inspectionProperties) in
            if status{
                //Successfully get the inspection properties
                self.inspectionProperties = (inspectionProperties?.parameters)!
                
                for i in 0..<self.inspectionProperties.count{
                    if self.task?.inspectionData?.count ?? 0 == 0 || self.task?.inspectionData?.count ?? 0 == nil{
                        print("nil inspection array")
                    }else{
                        self.inspectionProperties[i].status = self.task?.inspectionData?[i].status
                        self.inspectionProperties[i].subPropertyValue = self.task?.inspectionData?[i].subPropertyValue
                    }
                }
                
                self.inspectionPropertyTableView.reloadData()
            }else{
                //Unable to get the inspection properties
                print("not available")
            }
        }
    }
    
    func checkIfNoDataLeft() -> Bool{
        for propertyInfo in inspectionProperties{
            print(propertyInfo.status)
            print(propertyInfo.propertyName)
            print(propertyInfo.subPropertyValue)
            if propertyInfo.status == nil{
                AlertService().showAlert(on: self, title: "Alert", message: "You have not checked the field\n\(propertyInfo.propertyName ?? "").", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: nil)
                return false
            }
            if propertyInfo.subPropertyName != nil && propertyInfo.subPropertyValue == "" && propertyInfo.status == true{
                AlertService().showAlert(on: self, title: "Alert", message: "You have not entered the\n\(propertyInfo.subPropertyName ?? "").", actionButtonTitle: "Ok", alertType: .informationAlertType, completion: nil)
                return false
            }
            
            if propertyInfo === inspectionProperties.last{
                return true
            }
        }
        return false
    }
    
    @IBAction func checkInspectionFilledBtnPressed(_ sender: UIButton) {
        if checkIfNoDataLeft(){
            task?.inspectionData = inspectionProperties
            print(task?.inspectionData)
            FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
                guard let self = self else {return}
                if status{
                    self.performSegue(withIdentifier: "inspectionVCToJobPerformedVC", sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inspectionVCToJobPerformedVC"{
            if let destination = segue.destination as? JobPerformedVC{
                destination.task = task
            }
        }
    }
    
    @objc func addMultipleHoseSerialNumberBtnAction(sender: UIButton){
        print(sender.tag)
        
        //        let index = IndexPath(row: sender.tag, section: 0)
        //        let cell = inspectionPropertyTableView.cellForRow(at: index) as! HoseAssemblyNumberCell
        //
        //
        //        if selectedRowIndex == sender.tag {
        //           selectedRowIndex = -1
        //            cell.hoseSerialNumberTxtField2.isHidden = true
        //            cell.hoseSerialNumberTxtField3.isHidden = true
        //            cell.hoseSerialNumberTxtField4.isHidden = true
        //            cell.hoseSerialNumberTxtField5.isHidden = true
        //            cell.hoseSerialNumberTxtField6.isHidden = true
        //            cell.hoseSerialNumberTxtField7.isHidden = true
        //            cell.hoseSerialNumberTxtField8.isHidden = true
        //            cell.hoseSerialNumberTxtField9.isHidden = true
        //            cell.hoseSerialNumberTxtField10.isHidden = true
        //       } else {
        //            selectedRowIndex = sender.tag
        //            cell.hoseSerialNumberTxtField2.isHidden = false
        //            cell.hoseSerialNumberTxtField3.isHidden = false
        //            cell.hoseSerialNumberTxtField4.isHidden = false
        //            cell.hoseSerialNumberTxtField5.isHidden = false
        //            cell.hoseSerialNumberTxtField6.isHidden = false
        //            cell.hoseSerialNumberTxtField7.isHidden = false
        //            cell.hoseSerialNumberTxtField8.isHidden = false
        //            cell.hoseSerialNumberTxtField9.isHidden = false
        //            cell.hoseSerialNumberTxtField10.isHidden = false
        //       }
        //
        //        inspectionPropertyTableView.reloadRows(at: [index], with: .automatic)
    }
    
}


extension InspectionVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isRowInsertionRequired && indexPath.row == 6{
            return 550 //Expanded
        }else{
            return 150 //Not expanded
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            print("index path of delete: \(indexPath)")
            completionHandler(true)
        }
        
        let rename = UIContextualAction(style: .normal, title: "Edit") { (action, sourceView, completionHandler) in
            print("index path of edit: \(indexPath)")
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [rename, delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

extension InspectionVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isRowInsertionRequired{
            return inspectionProperties.count + 1
        }else{
            return inspectionProperties.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if !isRowInsertionRequired{
            let propertyInfo = inspectionProperties[indexPath.row]
            if propertyInfo.propertyName == "Hose assembly failure?" && propertyInfo.status == true{
                isRowInsertionRequired = true
                if let cell = tableView.dequeueReusableCell(withIdentifier: "hoseAssemblyId") as? HoseAssemblyNumberCell{
                    
                    cell.parameterInfo = inspectionProperties[indexPath.row - 1]
                    cell.delegate = self
                    cell.subPropertyValue = propertyInfo.subPropertyValue ?? ""
                    
                    return cell
                }else{
                    return UITableViewCell()
                }
            }
            if let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCellId") as? InspectionPropertyCell{
                cell.parameterInfo = propertyInfo
                cell.delegate = self
                return cell
            }else{
                return UITableViewCell()
            }
        }
        
        if isRowInsertionRequired && indexPath.row == 6{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "hoseAssemblyId") as? HoseAssemblyNumberCell{
                cell.parameterInfo = inspectionProperties[indexPath.row - 1]
                cell.delegate = self
                //                cell.btnHoseSerialnumber.tag = indexPath.row
                //                cell.btnHoseSerialnumber.addTarget(self, action: #selector(addMultipleHoseSerialNumberBtnAction), for: .touchUpInside)
                return cell
            }
        }else{
            var propertyInfo = ParameterInfo()
            if indexPath.row < 6{
                propertyInfo = inspectionProperties[indexPath.row]
            }else{
                propertyInfo = inspectionProperties[indexPath.row - 1]
            }
            if let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCellId") as? InspectionPropertyCell{
                cell.parameterInfo = propertyInfo
                cell.delegate = self
                return cell
            }else{
                return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
}


extension InspectionVC: CheckboxActions{
    func correctBtnPressed(indexPath: IndexPath) {
        let inspectionProperty : ParameterInfo?
        
        if isRowInsertionRequired && indexPath.row > 5{
            inspectionProperty = inspectionProperties[indexPath.row - 1]
        }else{
            inspectionProperty = inspectionProperties[indexPath.row]
        }
        //        inspectionPropertyTableView.reloadRows(at: [indexPath], with: .fade)
        if indexPath.row == 5 && inspectionProperty!.status == true{
            isRowInsertionRequired = true
            inspectionPropertyTableView.insertRows(at: [IndexPath(row: 6, section: 0)], with: .none)
        }
        
        if indexPath.row == 5 && inspectionProperty!.status == nil{
            isRowInsertionRequired = false
            inspectionPropertyTableView.deleteRows(at: [IndexPath(row: 6, section: 0)], with: .none)
        }
        inspectionPropertyTableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    
    func wrongBtnPressed(indexPath: IndexPath) {
        
        inspectionPropertyTableView.reloadRows(at: [indexPath], with: .fade)
        if indexPath.row == 5 && isRowInsertionRequired{
            isRowInsertionRequired = false
            inspectionProperties[indexPath.row].subPropertyValue = nil
            inspectionPropertyTableView.deleteRows(at: [IndexPath(row: 6, section: 0)], with: .none)
        }
        
    }
}

//
//  JobCompletedInspectionVC.swift
//  RapidHose
//
//  Created by Ashok on 26/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedInspectionVC: UIViewController {

    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var inspectionPropertyTableView: UITableView!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    var inspectionProperties = [ParameterInfo]()
    var isRowInsertionRequired  = false
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
        
        inspectionPropertyTableView.dataSource = self
        inspectionPropertyTableView.delegate = self
        
        getInspectionProperties()
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
    }

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inspectionVCToJobPerformedVC"{
            if let destination = segue.destination as? JobPerformedVC{
                destination.task = task
            }
        }
    }
    
    @IBAction func btn1Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 0)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 1)
    }
    
    @IBAction func btn3Action(_ sender: UIButton) {
//        delegate?.moveViewController(index: 2)
    }
    
    @IBAction func btn4Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 3)
    }
    
    @IBAction func btn5Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 4)
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        delegate?.moveViewController(index: 3)
    }

}


extension JobCompletedInspectionVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 100
        
    }
}

extension JobCompletedInspectionVC : UITableViewDataSource{
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
            /*if propertyInfo.propertyName == "Hose assembly failure?" && propertyInfo.status == true{
                isRowInsertionRequired = true
                if let cell = tableView.dequeueReusableCell(withIdentifier: "hoseAssemblyId") as? HoseAssemblyNumberCell{
                    
                    cell.parameterInfo = inspectionProperties[indexPath.row - 1]
                    cell.delegate = self
                    cell.subPropertyValue = propertyInfo.subPropertyValue ?? ""
                    
                    return cell
                }else{
                    return UITableViewCell()
                }
            } */
            if let cell = inspectionPropertyTableView.dequeueReusableCell(withIdentifier: "JobCompletedInspectionPropertyCell") as? JobCompletedInspectionPropertyCell{
                cell.parameterInfo = propertyInfo
//                cell.delegate = self
                return cell
            }else{
                return UITableViewCell()
            }
        }
        
        if isRowInsertionRequired && indexPath.row == 6{
            if let cell = inspectionPropertyTableView.dequeueReusableCell(withIdentifier: "JobCompletedHoseAssemblyNumberCell") as? JobCompletedHoseAssemblyNumberCell{
//                cell.parameterInfo = inspectionProperties[indexPath.row - 1]
//                cell.delegate = self
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "JobCompletedInspectionPropertyCell") as? JobCompletedInspectionPropertyCell{
                cell.parameterInfo = propertyInfo
//                cell.delegate = self
                return cell
            }else{
                return UITableViewCell()
            }
        }
        
        return UITableViewCell()
    }
}

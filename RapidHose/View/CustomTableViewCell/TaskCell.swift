//
//  taskCell.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 09/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

@objc protocol handlesMapBtnCellActions{
    @objc optional func locationBtnPressed(indexPath : IndexPath)
}


class TaskCell: UITableViewCell {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var jobStatusLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    
    //Ashok
    @IBOutlet weak var bcImg: UIImageView!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var lblTaskId: UILabel!
    @IBOutlet weak var lblTaskAddress: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    
    @IBOutlet weak var locationImg: UIImageView!
    weak var delegate : handlesCellActions?
    
    var task : Task_modelClass?{
        didSet{
            
            print("location: \(String(describing: task!.callerName))")
            print("customerName: \(String(describing: task!.callerPhone))")
            print("callerName: \(String(describing: task!.calledTime))")
            print("employeeId: \(String(describing: task!.createdAt))")
            print("jobId: \(String(describing: task!.customerName))")
            print("jobPerformed: \(String(describing: task!.employeeId))")
            //            print("jobPerformed: \(String(describing: task!.jobCoordinates))")
            print("jobPerformed: \(String(describing: task!.jobLocation))")
            print("jobPerformed: \(String(describing: task!.jobStatus))")
            print("jobPerformed: \(String(describing: task!.machineModel))")
            print("jobPerformed: \(String(describing: task!.machineSerialNo))")
            print("jobPerformed: \(String(describing: task!.machineType))")
            print("jobPerformed: \(String(describing: task!.miles))")
            print("jobPerformed: \(String(describing: task!.purchasedOrder))")
            print("jobPerformed: \(String(describing: task!.sitePersonName))")
            print("jobPerformed: \(String(describing: task!.sitePersonPhone))")
            print("jobPerformed: \(String(describing: task!.taskId))")
            print("jobPerformed: \(String(describing: task!.unitNo))")
            print("rendomTaskId: \(String(describing: task!.randomTaskId))")
            
            //            print("jobStatusLbl: \(String(describing: JobStatus(rawValue: task!.jobStatus!)?.getJobStatus()))")
            //            lblDate.text = task!
            
            //            locationLbl.text = task!.jobLocation
            //            jobStatusLbl.text = JobStatus(rawValue: task!.jobStatus)?.getJobStatus()
            
            //Ashok
            
            lblDate.text = timeStampToOnlyDate(timeStamp: Int(task?.createdAt ?? 00))
            lblTimer.text = timeStampToTime(timeStamp: Int(task?.calledTime ?? 00))
            
            lblLocation.attributedText = changeUnderLineColor(text: task?.jobLocation ?? "")
            
            lblAttributedTxt(lblName: lblTaskId, str1: "Task Id : ", str2: "\(task?.randomTaskId ?? 0)", font1: UIFont.init(name: "Montserrat-SemiBold", size: 15)!, font2: UIFont.init(name: "Montserrat-Regular", size: 15)!)
            lblTaskAddress.text = task?.jobLocation
            statusBtn.setTitle(JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus(), for: .normal)
            statusBtn.backgroundColor = (JobStatusColor(rawValue: task!.jobStatus ?? 0)?.getJobStatusColor())
            
            if task?.jobLocation == ""{
                locationImg.image = UIImage.init(named: "locationIc")
            }else{
                locationImg.image = UIImage.init(named: "locationRedIc")
            }
        }
    }
    
    //Ashok
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bcImg.applyshadowWithCorner(containerView: backgroundCellView, cornerRadious: 5)
        statusBtn.layer.cornerRadius = statusBtn.frame.size.height/2
    }
    
}



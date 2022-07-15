//
//  JobCompletedListTableViewCell.swift
//  RapidHose
//
//  Created by Ashok on 25/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedListTableViewCell: UITableViewCell {
    
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
            
            print("callerName: \(String(describing: task!.callerName))")
            print("callerPhone: \(String(describing: task!.callerPhone))")
            print("calledTime: \(String(describing: task!.calledTime))")
            print("createdAt: \(String(describing: task!.createdAt))")
            print("jobId: \(String(describing: task!.customerName))")
            print("customerName: \(String(describing: task!.employeeId))")
            //            print("jobPerformed: \(String(describing: task!.jobCoordinates))")
            print("jobLocation: \(String(describing: task!.jobLocation))")
            print("jobStatus: \(String(describing: task!.jobStatus))")
            print("machineModel: \(String(describing: task!.machineModel))")
            print("machineSerialNo: \(String(describing: task!.machineSerialNo))")
            print("machineType: \(String(describing: task!.machineType))")
            print("miles: \(String(describing: task!.miles))")
            print("purchasedOrder: \(String(describing: task!.purchasedOrder))")
            print("sitePersonName: \(String(describing: task!.sitePersonName))")
            print("sitePersonPhone: \(String(describing: task!.sitePersonPhone))")
            print("taskId: \(String(describing: task!.taskId))")
            print("unitNo: \(String(describing: task!.unitNo))")
            print("DoYouOnlyBuildTheHose: \(String(describing: task!.DoYouOnlyBuildTheHose))")
            print("jobCompletedTime: \(String(describing: task!.jobCompletedTime))")
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
//        bcImg.applyshadowWithCorner(containerView: backgroundCellView, cornerRadious: 5)
         backgroundCellView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
        statusBtn.layer.cornerRadius = statusBtn.frame.size.height/2
    }
    
}


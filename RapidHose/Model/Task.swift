//
//  Task.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 09/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import UIKit

enum JobStatus : Int{
    case new  = 1
    case assigned = 2
    case dispatched = 3
    case jobStart = 4
    case completed = 5
    case reported = 6
    
    func getJobStatus() -> String{
        switch self {
        case .new:
            return "New"
        case .assigned:
            return "Assigned"
        case .dispatched:
            return "Dispatched"
        case .jobStart:
            return "InProgress"
        case .completed:
            return "Completed"
        case .reported:
            return "Reported"
        }
    }
}

enum JobStatusColor : Int{
    case new  = 1
    case assigned = 2
    case dispatched = 3
    case jobStart = 4
    case completed = 5
    case reported = 6
    
    func getJobStatusColor() -> UIColor{
        switch self {
        case .new:
            return UIColor.init(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0000)
        case .assigned:
            return UIColor.init(red: 20/255, green: 162/255, blue: 179/255, alpha: 1.0000)
//                UIColor.init(red: 172/255, green: 36/255, blue: 42/255, alpha: 1.0000)
        case .dispatched:
            return UIColor.init(red: 172/255, green: 36/255, blue: 42/255, alpha: 1.0000)
//                UIColor.init(red: 20/255, green: 162/255, blue: 179/255, alpha: 1.0000)
        case .jobStart:
            return UIColor.init(red: 255/255, green: 195/255, blue: 0/255, alpha: 1.0000)
        case .completed:
            return UIColor.init(red: 86/255, green: 182/255, blue: 89/255, alpha: 1.0000)
        case .reported:
            return UIColor.init(red: 255/255, green: 158/255, blue: 16/255, alpha: 1.0000)
        }
    }
}

class Task : Codable{
    var jobCreateTime : Int64?
    var customerName : String?
    var callerName : String?
    var calledTime : Int64?
    var employeeId : String?
    var jobId : String?
    var jobStatus : Int?
    var miles : Double?
    var jobLocation : String?
    var purchasedOrder : String?
    var sitePersonName : String?
    var sitePersonNumber : String?
    var machineType : String?
    var model : String?
    var machineSerialNumber : String?
    var unitNumber : String?
    var DoYouOnlyBuildTheHose : Bool?
    var hoseSerialNumber : String?
    var inspectionData : [ParameterInfo]?
    var jobPerformed : String?
}

class Task_modelClass : Codable{
    var taskId : String?
    var customerName : String?
    var callerName : String?
    var calledTime : Int64?
    var callerPhone : String?
    var createdBy : String?
    var miles : Int64?
    var purchasedOrder : String?
    var sitePersonName : String?
    var sitePersonPhone : String?
    var machineType : String?
    var machineModel : String?
    var machineSerialNo : String?
    var unitNo : String?
    var employeeId : String?
    var jobLocation : String?
    var jobCoordinates : jobCoordinates?
    var jobStatus : Int?
    var createdAt : Int64?
    var jobPerformed : String?
    var inspectionData : [ParameterInfo]?
    var taskPictures : [taskPictures]?
    var dispatchedTime : String?
    var reportedTime : String?
    var issueReported : String?
    var jobStartedTime : String?
    var jobCompletedTime : String?
    var hoseSerialNumber : String?
    var DoYouOnlyBuildTheHose : Bool?
    var randomTaskId : Int?
    var issueReportedTime: String?
    var time1: String?
    var time2: String?
    var time3: String?
    var time4: Int?
    var time5: Int?
    var totalTime: String?


}

struct Task_model {
    
    var taskId = String()
    var customerName = String()
    var callerName = String()
    var calledTime = Int()
    var callerPhone = String()
    var createdBy = String()
    var miles = Int()
    var purchasedOrder = String()
    var sitePersonName = String()
    var sitePersonPhone = String()
    var machineType = String()
    var machineModel = String()
    var machineSerialNo = String()
    var unitNo = String()
    var employeeId = String()
    var jobLocation = String()
    var jobCoordinates = NSArray()
    var jobStatus = Int()
    var createdAt = Int()
    var taskPictures : [taskPictures]?
    
    init(task_Value : [String: Any]){
        
        taskId = task_Value["taskId"] as? String ?? ""
        customerName = task_Value["customerName"] as? String ?? ""
        callerName = task_Value["callerName"] as? String ?? ""
        calledTime = task_Value["calledTime"] as? Int ?? 0
        callerPhone = task_Value["callerPhone"] as? String ?? ""
        createdBy = task_Value["createdBy"] as? String ?? ""
        miles = task_Value["miles"] as? Int ?? 0
        purchasedOrder = task_Value["purchasedOrder"] as? String ?? ""
        sitePersonName = task_Value["sitePersonName"] as? String ?? ""
        sitePersonPhone = task_Value["sitePersonPhone"] as? String ?? ""
        machineType = task_Value["month.getMonth()"] as? String ?? ""
        machineModel = task_Value["machineModel"] as? String ?? ""
        machineSerialNo = task_Value["machineSerialNo"] as? String ?? ""
        unitNo = task_Value["unitNo"] as? String ?? ""
        employeeId = task_Value["employeeId"] as? String ?? ""
        jobLocation = task_Value["jobLocation"] as? String ?? ""
        jobCoordinates = task_Value["jobCoordinates"] as? NSArray ?? []
        jobStatus = task_Value["jobStatus"] as? Int ?? 0
        createdAt = task_Value["createdAt"] as? Int ?? 0
        taskPictures = task_Value["taskPictures"] as? [taskPictures]
    }
}

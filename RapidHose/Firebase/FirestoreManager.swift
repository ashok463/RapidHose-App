//
//  FirestoreManager.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 02/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth


let firestoreRef = Firestore.firestore()

enum FirestoreCollections : String {
    case employee = "Employees"
    case inspectionParameters = "InspectionParameters"
    case fieldReport = "FieldReport"
    case task = "task"
    case notification = "notification"
}

enum FirebaseOperation : String{
    case delete
    case update
}

class FirestoreManager{
    private init() {}
    static let shared = FirestoreManager()
    
    func configue(){
        FirebaseApp.configure()
    }
    
    private func reference(to collection : FirestoreCollections) -> CollectionReference{
        return Firestore.firestore().collection(collection.rawValue)
    }
    
    /**
     This function is used to update the device information and notification token at the time of user successfully logged in.
     */
    func updateInformationAfterLogin(completion : ((Bool) -> ())? = nil){
        reference(to: .employee).document(Auth.auth().currentUser!.uid).updateData(["deviceDetails": Utility.getDeviceAppDetails(), "notification": Utility.notificationDetails()]) { (error) in
            if let err = error as NSError?{
                print("Error in updating User Data : \(err.localizedDescription)")
            }else{
                guard let completion = completion else { return }
                
                completion(true)
                print("User Data Successfully updated")
            }
        }
    }
    
    func getUserStatusValue(completion : @escaping(Bool) -> ()){
        reference(to: .employee).document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
            if let document = document, document.exists{
                if let userData = document.data(){
                    do{
                        print(userData)
                        let data = try JSONSerialization.data(withJSONObject: userData, options: .fragmentsAllowed)
                        let userInfo = try JSONDecoder().decode(UserData.self, from: data)
                        if userInfo.status == 1{
                            completion(false)
                        }else{
                            completion(true)
                        }
                    }catch let error{
                        if let decodingError = error as? DecodingError{
                            ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                        }
                    }
                }
            }
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion(false)
                return
            }
        }
    }
    /**
     Method is used to get user information from firestore and store that data in local database i.e. Realm. This method is called after
     successfull login with firebase.
     */
    func getUserInformation(completion : @escaping(Bool, [String: Any]) -> ()){
        reference(to: .employee).document(Auth.auth().currentUser!.uid).getDocument { (document, error) in
            if let document = document, document.exists{
                if let userData = document.data(){
                    do{
                        print(userData)
                        let data = try JSONSerialization.data(withJSONObject: userData, options: .fragmentsAllowed)
                        let userInfo = try JSONDecoder().decode(UserData.self, from: data)
                        userInfo.deviceDetails = Utility.getDeviceInformation()
                        userInfo.notification = Utility.getNotificationInfo()
                       print(userInfo)
                        print(userInfo.email)
                        print(userInfo.name)
                        print(userInfo.phone)
                    }catch let error{
                        if let decodingError = error as? DecodingError{
                            ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                        }
                    }
                    completion(false, userData)
                }
            }
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion(true, ["":""])
                return
            }
        }
    }
    
    func get1UserInformation(){
        reference(to: .employee).document().getDocument { (document, error) in
            print(document)
            if let document = document, document.exists{
                if let userData = document.data(){
                    do{
                        print(userData)
                        let data = try JSONSerialization.data(withJSONObject: userData, options: .fragmentsAllowed)
                        let userInfo = try JSONDecoder().decode(UserData.self, from: data)
                        userInfo.deviceDetails = Utility.getDeviceInformation()
                        userInfo.notification = Utility.getNotificationInfo()
                        print(userInfo.email)
                        print(userInfo.name)
                        print(userInfo.phone)
                    }catch let error{
                        if let decodingError = error as? DecodingError{
                            ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                        }
                    }
                }
            }
            if let err = error as NSError?{
                print(err.localizedDescription)
                return
            }
        }
    }
    
    func setInspectionParameters(taskId : String, PropertyName: String, completion : ((Bool) -> ())? = nil){
        
        reference(to: .inspectionParameters).document("\(taskId)").setData([
            "Parameters": FieldValue.arrayUnion([["PropertyName": PropertyName]])
            ])
        { (error) in
            if let err = error as NSError?{
                print("Error in updating User Data : \(err.localizedDescription)")
            }else{
                print("User Data Successfully Added")
            }
        }
        
    }
    
    func updateInspectionParameters(taskId : String, PropertyName: String, completion : ((Bool) -> ())? = nil){
        
        reference(to: .inspectionParameters).document("\(taskId)").updateData([
            "Parameters": FieldValue.arrayUnion([["PropertyName": PropertyName]])
            ])
        { (error) in
            if let err = error as NSError?{
                print("Error in updating User Data : \(err.localizedDescription)")
            }else{
                print("User Data Successfully updated")
            }
        }
        
    }
    
    func getInspectionParameters(completion : @escaping(Bool, InspectionProperties?) -> ()){
        ActivityIndicator.shared().show()
        reference(to: .inspectionParameters).getDocuments { (snapshot, error) in
            ActivityIndicator.shared().hide()
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion(false, nil)
                return
            }
            guard let snap = snapshot else {return}
            guard let document = snap.documents.first else {return}
            
            do{
                let data = try JSONSerialization.data(withJSONObject: document.data(), options: .fragmentsAllowed)
                let parametersList = try JSONDecoder().decode(InspectionProperties.self, from: data)
                print(parametersList)
                completion(true, parametersList)
            }catch { 
                guard let decodingError = error as? DecodingError else {return}
                ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                completion(false, nil)
            }
        }
    }
    
    func getTaskInformation(completion : @escaping (Bool, [Task_modelClass]) -> ()){
        ActivityIndicator.shared().show()
        print("LoginId: \(UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) ?? "")")
        reference(to: .task).whereField("employeeId", isEqualTo: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) as Any).getDocuments {
            (querySnapshot, error) in
            ActivityIndicator.shared().hide()
            //            var tasks = [Task]()
            
            self.getTaskInformationWithListner() { (status, tasks) in
                if status{
                    completion(true, tasks)
                }else{
                    completion(false, tasks)
                }
            }
            //            //Ashok
            //            var tasks = [Task_modelClass]()
            //
            //            if let err = error as NSError?{
            //                print(err.localizedDescription)
            //                completion(false, tasks)
            //                return
            //            }
            //
            //            for document in querySnapshot!.documents{
            //
            //                if document.exists{
            //                    print(document.data())
            //                }else{
            //                    print("nil")
            //                }
            //                do{
            //                    if document.data().count == 0{
            //                        print("null")
            //                    }else{
            //                        do {
            //                            if JSONSerialization.isValidJSONObject(document.data()) {
            //                                let dataValue = document.data()
            //                                let jobStatus = dataValue["jobStatus"] as? Int
            //                                if jobStatus == 5{
            //                                    print("jobStatus: \(jobStatus)")
            //                                }else{
            //                                    let data = try JSONSerialization.data(withJSONObject: document.data())
            //
            //                                    let task = try JSONDecoder().decode(Task_modelClass.self, from: data)
            //
            //                                    tasks.append(task)
            //                                }
            //                            } else {
            //                                // not valid - do something appropriate
            //
            //                                let dataValue = document.data()
            //                                let customerName = dataValue["customerName"] ?? ""
            //                                print(customerName)
            //
            //                        AlertService().showAlert(title: "Customer Name: \(customerName)", message: "This Data format is not valid.", actionButtonTitle: "Ok", completion: {})
            //                            }
            //
            //
            //                        } catch let error {
            //                            if let decodingError = error as? DecodingError{
            //                                ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
            //                                AlertService().showAlert(title: "Alert", message: "This Data format is not valid.", actionButtonTitle: "Ok", completion: {})
            //                            }
            //
            //
            //                        }
            //
            //                    }
            //
            //                }catch{
            //                    guard let decodingError = error as? DecodingError else {return}
            //                    ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
            //                    completion(false, tasks)
            //                }
            //            }
            //            completion(true, tasks)
        }
    }
    
    
    func getSingleTaskInformation(taskId: String, completion : @escaping (Bool, [Task_modelClass]) -> ()){
        ActivityIndicator.shared().show()
        reference(to: .task).whereField("employeeId", isEqualTo: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) as Any).whereField("taskId", isEqualTo: taskId).getDocuments {
            (querySnapshot, error) in
            ActivityIndicator.shared().hide()
            //            var tasks = [Task]()
            
            //Ashok
            var tasks = [Task_modelClass]()
            
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion(false, tasks)
                return
            }
            
            for document in querySnapshot!.documents{
                
                if document.exists{
                    print(document.data())
                }else{
                    print("nil")
                }
                do{
                    
                    if JSONSerialization.isValidJSONObject(document.data()) {
                        let data = try JSONSerialization.data(withJSONObject: document.data(), options: .fragmentsAllowed)
                        
                        let task = try JSONDecoder().decode(Task_modelClass.self, from: data)
                        
                        tasks.append(task)
                    }else{
                        
                    }
                    
                    
                }catch{
                    guard let decodingError = error as? DecodingError else {return}
                    ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                    completion(false, tasks)
                }
            }
            completion(true, tasks)
        }
    }
    
    
    func updateTaskInformation(task : Task_modelClass, completion : @escaping (Bool) -> ()){
        
        ActivityIndicator.shared().show()
        reference(to: .task).whereField("taskId", isEqualTo: task.taskId ?? "").getDocuments { (snapshot, error) in
            //jobId
            ActivityIndicator.shared().hide()
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion(false)
                return
            }
            guard let document = snapshot?.documents.first else {
                completion (false)
                return
            }
            do{
                
                
                let data = try JSONEncoder().encode(task)
                let taskDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                self.reference(to: .task).document(document.documentID).updateData(taskDict as! [AnyHashable : Any]) { (error) in
                    if let err = error as NSError?{
                        print(err.localizedDescription)
                        completion(false)
                        return
                    }
                    let task_data = Task_model.init(task_Value: document.data())
                    print(task_data)
                    completion(true)
                }
            }catch{
                guard let decodingError = error as? DecodingError else {return}
                ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                completion(false)
            }
        }
    }
    
    func updateFireStoreImagesdata(taskId : String, taskImgUrl: String, taskName: String, completion : ((Bool) -> ())? = nil){
        reference(to: .task).document("\(taskId)").updateData([
            "taskPictures": FieldValue.arrayUnion([["taskImage": taskImgUrl, "taskName": taskName, "timeStamp": String(Date.currentTimeStamp)]])
            ])
        { (error) in
            if let err = error as NSError?{
                print("Error in updating User Data : \(err.localizedDescription)")
            }else{
                guard let completion = completion else { return }
                completion(true)
                print("User Data Successfully updated")
            }
        }
    }
    
    
    func getTaskInformationWithListner(completion : @escaping (Bool, [Task_modelClass]) -> ()){
        
        reference(to: .task).whereField("employeeId", isEqualTo: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) as Any).addSnapshotListener { querySnapshot, error in
    
            guard let querySnapshotData = querySnapshot else {
                return
            }
            if querySnapshot == nil{
                 print("Document data was empty.")
            }else{
                self.getTasksInfoData(querySnapshot: querySnapshot!, error: error as NSError?) { (status, tasks) in
                    if status{
                        completion(true, tasks)
                    }else{
                        completion(false, tasks)
                    }
                }
            }
           
        }
}
    
    func getTasksInfoData(querySnapshot: QuerySnapshot, error: NSError?, completion : @escaping (Bool, [Task_modelClass]) -> ()){
        
        //Ashok
        var tasks = [Task_modelClass]()
        for document in querySnapshot.documents{
            
            if document.exists{
                print(document.data())
            }else{
                print("nil")
            }
            do{
                if document.data().count == 0{
                    print("null")
                }else{
                    do {
                        if JSONSerialization.isValidJSONObject(document.data()) {
                            let dataValue = document.data()
                            let jobStatus = dataValue["jobStatus"] as? Int
                            if jobStatus == 5{
                                print("jobStatus: \(jobStatus)")
                            }else{
                                let data = try JSONSerialization.data(withJSONObject: document.data())
                                
                                let task = try JSONDecoder().decode(Task_modelClass.self, from: data)
                                
                                tasks.append(task)
                            }
                        } else {
                            // not valid - do something appropriate
                            
                            let dataValue = document.data()
                            let customerName = dataValue["customerName"] ?? ""
                            let customerId = dataValue["taskId"] ?? ""
                            print("cus name: \(customerName)")
                            print("cus id: \(customerId)")
                            AlertService().showAlert(title: "Customer Name: \(customerName)", message: "This Data format is not valid.", actionButtonTitle: "Ok", completion: {})
                        }
                        
                        
                    } catch let error {
                        if let decodingError = error as? DecodingError{
                            ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                            AlertService().showAlert(title: "Alert", message: "This Data format is not valid.", actionButtonTitle: "Ok", completion: {})
                        }
                        
                        
                    }
                    
                }
                
            }catch{
                guard let decodingError = error as? DecodingError else {return}
                ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                completion(false, tasks)
            }
        }
        completion(true, tasks)
        
        
        if let err = error as NSError?{
            print(err.localizedDescription)
            completion(false, tasks)
            return
        }
    }

func sendAdminnotification(taskId : String, employeeId: String, timeStamp: String, jobStatus: Int64, notificationId: String, completion : ((Bool) -> ())? = nil){
    let referDocument = reference(to: .notification).document()
    referDocument.setData([
        "taskId" : taskId,
        "employeeId" : employeeId,
        "timeStamp" : timeStamp,
        "jobStatus" : jobStatus,
        "notificationId" : referDocument.documentID])
    { (error) in
        if let err = error as NSError?{
            print("Error in updating User Data : \(err.localizedDescription)")
        }else{
            guard let completion = completion else { return }
            completion(true)
            print("Notification Data Successfully updated")
        }
    }
}
    
    
    /* Job Completed*/
    
    func getCompletedTaskInformationWithListner(completion : @escaping (Bool, [Task_modelClass]) -> ()){
            
        reference(to: .task).whereField("employeeId", isEqualTo: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) as Any).addSnapshotListener { querySnapshot, error in
        
                guard let querySnapshotData = querySnapshot else {
                    return
                }
                if querySnapshot == nil{
                     print("Document data was empty.")
                }else{
                    self.getCompletedTasksInfoData(querySnapshot: querySnapshot!, error: error as NSError?) { (status, tasks) in
                        if status{
                            completion(true, tasks)
                        }else{
                            completion(false, tasks)
                        }
                    }
                }
               
            }
    }
    
    func getCompletedTasksInfoData(querySnapshot: QuerySnapshot, error: NSError?, completion : @escaping (Bool, [Task_modelClass]) -> ()){
        
        //Ashok
        var tasks = [Task_modelClass]()
        for document in querySnapshot.documents{
            
            if document.exists{
                print(document.data())
            }else{
                print("nil")
            }
            do{
                if document.data().count == 0{
                    print("null")
                }else{
                    do {
                        if JSONSerialization.isValidJSONObject(document.data()) {
                            let dataValue = document.data()
                            let jobStatus = dataValue["jobStatus"] as? Int
                            if jobStatus == 5{
                                let data = try JSONSerialization.data(withJSONObject: document.data())
                                
                                let task = try JSONDecoder().decode(Task_modelClass.self, from: data)
                                
                                tasks.append(task)
                                
                            }else{
                                print("jobStatus: \(jobStatus ?? 0)")
                            }
                        } else {
                            // not valid - do something appropriate
                            
                            let dataValue = document.data()
                            let customerName = dataValue["customerName"] ?? ""
                            print(customerName)
                            print("gytryhtyhrthyhhrt\(dataValue)")
                           // AlertService().showAlert(title: "Customer Name: \(customerName)", message: "This Data format is not valid.", actionButtonTitle: "Ok", completion: {})
                        }
                        
                        
                    } catch let error {
                        if let decodingError = error as? DecodingError{
                            ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                            //AlertService().showAlert(title: "Alert", message: "This Data format is not valid.", actionButtonTitle: "Ok", completion: {})
                        }
                        
                        
                    }
                    
                }
                
            }catch{
                guard let decodingError = error as? DecodingError else {return}
                ErrorHandler().jsonDecoderErrorHandler(error: decodingError)
                completion(false, tasks)
            }
        }
        
       completion(true, tasks)
        
        
        if let err = error as NSError?{
            print(err.localizedDescription)
            completion(false, tasks)
            return
        }
    }
    
    func getJobCompletedTaskInformation(completion : @escaping (Bool, [Task_modelClass]) -> ()){
        ActivityIndicator.shared().show()
        print("LoginId: \(UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) ?? "")")
        reference(to: .task).getDocuments {
            (querySnapshot, error) in
            ActivityIndicator.shared().hide()
            //            var tasks = [Task]()
            
            self.getCompletedTaskInformationWithListner() { (status, tasks) in
                if status{
                    completion(true, tasks)
                }else{
                    completion(false, tasks)
                }
            }
            
        }
    }
    //.whereField("employeeId", isEqualTo: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.isLoginId) as Any)

}

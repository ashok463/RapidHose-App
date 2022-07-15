//
//  PictureReportVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 08/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import FirebaseFunctions

class PictureReportVC: UIViewController {
    
    @IBOutlet weak var pictureReportCollectionView: UICollectionView!
    
    //Ashok
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusTittleLbl: UILabel!
    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    @IBOutlet weak var statusBtn6: UIButton!
    
    var photoTasks = [PictureTask]()
    
    let tasksImages = ["dummyImgGallery", "unitnoIc", "serialnumberIc", "hourmeterIc", "siteoverviewIc", "failureareaIc", "faultypartIc", "removedIc", "newassemblyIc", "completerepairIc", "tanklevelc", "otherIc"]
    let tasks = ["Subject", "Unit Number", "Serial Number", "Hour Meter", "Site Overview", "Failure Area", "Faulty Part", "Removed", "New Assembly/Part", "Complete Repair", "Tank Level", "Other"]
    
    var startingFrame : CGRect?
    var blackBackgroundView : UIView?
    var startingImageView : UIImageView?
    
    lazy var functions = Functions.functions()
    //Ashok
    var task : Task_modelClass?
    
    //    var task : Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureReportCollectionView.delegate = self
        pictureReportCollectionView.dataSource = self
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        statusBtn6.btnCornerRadius(radius: statusBtn6.frame.width/2)
        
        submitBtn.btnCornerRadius(radius: 5.0)
        
        statusTittleLbl.text = JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus()
        statusImg.image = UIImage.init(named: (JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())!)
        
        setFlowLayoutOfCollectionView()
        setDataForCollectionView()
    }
    
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
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
    
    //Ashok
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "RapidHose", message: "Do you want to submit the report?", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            self.task?.jobStatus = 5
            self.task?.jobCompletedTime = String(Date.currentTimeStamp)
            
            FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                guard let self = self else {return}
                if status{
                    self.getTaskInfo { (status) in
                        if status{
                            self.cloudFunction(customerName: self.task?.customerName ?? "", employeeName: UserDefaults.standard.value(forKey: Constants.userDefaulsKeys.userName) as? String ?? "", jobId: self.task?.taskId ?? "", jobStatus: "Completed", randomTaskId: "\(self.task?.randomTaskId ?? 0)", callerPhone: self.task?.callerPhone ?? "", sitePersonPhone: self.task?.sitePersonPhone ?? "", createdBy: self.task?.createdBy ?? "")
                            self.cloudFunctionSaveEstimateTime(jobCompletedTime: self.task?.jobCompletedTime ?? "", jobStartedTime: self.task?.jobStartedTime ?? "", time4: self.task?.time4 ?? 0, time5: self.task?.time5 ?? 0, taskId: self.task?.taskId ?? "")
                            FirestoreManager.shared.sendAdminnotification(taskId: self.task?.taskId ?? "", employeeId: self.task?.employeeId ?? "", timeStamp: String(Date.currentTimeStamp), jobStatus: 5, notificationId: "") { (satus) in
                                if status{
                                    guard let viewControllers = self.navigationController?.viewControllers else {return}
                                    if let mainVC = viewControllers[1] as? KYDrawerController{
                                        self.navigationController?.popToViewController(mainVC, animated: true)
                                    }else{
                                        self.navigationController?.popToRootViewController(animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
        
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
    
    private func setDataForCollectionView(){
        
        for i in 0..<12{
            
            let photoTask = PictureTask()
            
            if task?.taskPictures?.count ?? 0 == 0 || task?.taskPictures?.count ?? 0 == nil{
                print("nil array")
                photoTask.taskName = tasks[i]
            }else{
                
                for index in 0..<(task?.taskPictures!.count)!{
                    
                    let image = task?.taskPictures?[index].taskImage
                    let name = task?.taskPictures?[index].taskName
                    
                    if name == tasks[i]{
                        photoTask.taskName = name
                        photoTask.taskImage = image
                    }else{
                        photoTask.taskName = tasks[i]
                    }
                }
            }
            
            photoTask.taskdummyImage = tasksImages[i]
            photoTasks.append(photoTask)
            if i == 11{
                pictureReportCollectionView.reloadData()
            }
        }
    }
    
    func setFlowLayoutOfCollectionView(){
        let flowLayout = pictureReportCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.minimumInteritemSpacing = 15
        flowLayout?.minimumLineSpacing = 20
        flowLayout?.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
//    func saveImage(Image: UIImage) {
//
//        UIImageWriteToSavedPhotosAlbum(Image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
//    }
//
//    //MARK: - Save Image callback
//
//    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//
//        if let error = error {
//
//            print(error.localizedDescription)
//
//        } else {
//
//            print("Success")
//        }
//    }
//
//    func saveImageToDocumentDirectory(fileName: String, image: UIImage) {
//
//        var objCBool: ObjCBool = true
//        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
//        let folderPath = mainPath + "/RapidHoseImages/"
//
//        let isExist = FileManager.default.fileExists(atPath: folderPath, isDirectory: &objCBool)
//        if !isExist {
//            do {
//                try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
//            } catch {
//                print(error)
//            }
//        }
//
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let imageName = "\(fileName).png"
//        let imageUrl = documentDirectory.appendingPathComponent("RapidHoseImages/\(imageName)")
//        if let data = image.jpegData(compressionQuality: 1.0){
//            do {
//                try data.write(to: imageUrl)
//            } catch {
//                print("error saving", error)
//            }
//        }
//    }
}

extension PictureReportVC : UICollectionViewDelegate{
    
}

extension PictureReportVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureReportCellId", for: indexPath) as? PictureTaskCell else {return UICollectionViewCell()}
        cell.pictureTask = photoTasks[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension PictureReportVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {return CGSize(width: 40, height: 40)}
        let minimumLineSpacing = flowLayout.minimumInteritemSpacing
        let insets = flowLayout.sectionInset
        let numberOfColumns = 3
        let padding: CGFloat =  insets.left + insets.right + CGFloat((numberOfColumns - 1))*minimumLineSpacing
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: Int(collectionViewSize)/numberOfColumns, height: Int(collectionViewSize)/numberOfColumns + 30)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 10
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 15
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let noOfCellsInRow = 3
    //
    //        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    //
    //        let totalSpace = flowLayout.sectionInset.left
    //            + flowLayout.sectionInset.right
    //            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
    //
    //        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
    //
    //        return CGSize(width: size, height: size)
    //    }
}

extension PictureReportVC : handlesCellActions{
    func takePictureBtnPressed(indexPath: IndexPath) {
        let photoTask = photoTasks[indexPath.row]
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self, libraryModes: [.camera,.photoLibrary])
        AttachmentHandler.shared.imagePickerBlock = { [weak self](image) in
            guard let self = self else {return}
            
            guard let data = image.jpegData(compressionQuality: 0.2) else {return}
            
//            self.saveImage(Image: image)
            
//            let path = "photo/RapidhoseImages/\(self.task?.randomTaskId ?? 0)/\(Date().timeIntervalSince1970).jpg"
//            let url = image.save(at: .documentDirectory, pathAndImageName: path)
//            print(url)
            CustomPhotoAlbum.sharedInstance.saveImage(image: image)
            //            self.saveImageToDocumentDirectory(fileName: self.tasks[indexPath.row], image: image)
            if let cell = self.pictureReportCollectionView.cellForItem(at: indexPath) as? PictureTaskCell{
                
                FirStorage.shared.uploadTaskImage(cell : cell, taskId: self.task?.taskId ?? "", imageIndex: indexPath.row, withData: data) { (imageURL) in
                    photoTask.taskImage = imageURL.absoluteString
                    photoTask.taskName = self.tasks[indexPath.row]
                    self.getTaskInfo { (status) in
                        if self.task?.taskPictures?.count ?? 0 == 0 || self.task?.taskPictures?.count ?? 0 == nil{
                            print("nil array")
                            FirestoreManager.shared.updateFireStoreImagesdata(taskId: self.task?.taskId ?? "", taskImgUrl: imageURL.absoluteString, taskName: self.tasks[indexPath.row]) { (status) in
                                if status{
                                    
//                                    self.task?.jobStatus = 5
//                                    self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                                    FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                                        guard let self = self else {return}
                                        if status{
                                            self.getTaskInfo { (getStatus) in
                                                if getStatus{
                                                    cell.taskPictureImageView.loadImageUsingCacheWithUrlString(urlString: imageURL.absoluteString)
                                                    cell.taskNameLbl.text = self.tasks[indexPath.row]
                                                }
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }else{
                            
                            let indexvalue = self.task?.taskPictures?.firstIndex{$0.taskName?.contains(self.tasks[indexPath.row]) as! Bool}
                            print("indexValue: \(indexvalue)")
                            
                            if indexvalue == nil{
                                
//                                self.task?.jobStatus = 5
//                                self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                                FirestoreManager.shared.updateFireStoreImagesdata(taskId: self.task?.taskId ?? "", taskImgUrl: imageURL.absoluteString, taskName: self.tasks[indexPath.row]) { (status) in
                                    if status{
                                        self.getTaskInfo { (getStatus) in
                                            if getStatus{
                                                FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                                                    guard let self = self else {return}
                                                    if status{
                                                        self.getTaskInfo { (getStatus) in
                                                            if getStatus{
                                                                cell.taskPictureImageView.loadImageUsingCacheWithUrlString(urlString: imageURL.absoluteString)
                                                                cell.taskNameLbl.text = self.tasks[indexPath.row]
                                                            }
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }else{
                                
//                                self.task?.jobStatus = 5
//                                self.task?.jobCompletedTime = String(Date.currentTimeStamp)
                                self.task?.taskPictures?[indexvalue!].taskImage = imageURL.absoluteString
                                self.task?.taskPictures?[indexvalue!].timeStamp = String(Date.currentTimeStamp)
                                
                                FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                                    guard let self = self else {return}
                                    if status{
                                        self.getTaskInfo { (getStatus) in
                                            if getStatus{
                                                cell.taskPictureImageView.loadImageUsingCacheWithUrlString(urlString: imageURL.absoluteString)
                                                cell.taskNameLbl.text = self.tasks[indexPath.row]
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                            //                            for index in 0..<(self.task?.taskPictures!.count)!{
                            //                                let name = self.task?.taskPictures?[index].taskName
                            //                                let imageIndex = index
                            //                                if name == self.tasks[indexPath.row]{
                            //                                    self.task?.taskPictures?[imageIndex].taskImage = imageURL.absoluteString
                            //                                    self.task?.taskPictures?[imageIndex].timeStamp = String(Date.currentTimeStamp)
                            //
                            //                                    FirestoreManager.shared.updateTaskInformation(task: self.task!) { [weak self](status) in
                            //                                        guard let self = self else {return}
                            //                                        if status{
                            //                                            self.getTaskInfo { (getStatus) in
                            //                                                if getStatus{
                            //                                                   cell.taskPictureImageView.loadImageUsingCacheWithUrlString(urlString: imageURL.absoluteString)
                            //                                                   cell.taskNameLbl.text = self.tasks[indexPath.row]
                            //                                                }
                            //                                            }
                            //
                            //                                        }
                            //                                    }
                            //                                }else{
                            //                                    FirestoreManager.shared.updateFireStoreImagesdata(taskId: self.task?.taskId ?? "", taskImgUrl: imageURL.absoluteString, taskName: self.tasks[indexPath.row]) { (status) in
                            //                                        if status{
                            //                                            self.getTaskInfo { (getStatus) in
                            //                                                if getStatus{
                            //                                                   cell.taskPictureImageView.loadImageUsingCacheWithUrlString(urlString: imageURL.absoluteString)
                            //                                                   cell.taskNameLbl.text = self.tasks[indexPath.row]
                            //                                                }
                            //                                            }
                            //
                            //                                        }
                            //                                    }
                            //                                }
                            //                            }
                        }
                    }
                    
                }
                cell.taskPictureImageView.image = image
                cell.dummyImgView.isHidden = true
                cell.dummyTxtLbl.isHidden = true
                cell.taskNameLbl.isHidden = false
                cell.taskPictureImageView.isHidden = false
                cell.zoomInBtn.isHidden = false
            }
            
        }
    }
    
    func zoomPictureBtnPressed(indexPath: IndexPath, imageView: UIImageView) {
        self.startingImageView =  imageView
        self.startingImageView?.isHidden = true
        startingFrame = imageView.superview?.convert(imageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = UIColor.red
        zoomingImageView.contentMode = .scaleAspectFill
        zoomingImageView.image = imageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        blackBackgroundView = UIView(frame: keyWindow!.frame)
        blackBackgroundView?.backgroundColor = UIColor.black
        blackBackgroundView?.alpha = 1
        
        keyWindow!.addSubview(blackBackgroundView!)
        keyWindow!.addSubview(zoomingImageView)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackBackgroundView?.alpha = 1.0
            let height = (self.startingFrame?.height)! / (self.startingFrame?.width)! * keyWindow!.frame.width
            zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow!.frame.width, height: (height))
            zoomingImageView.center = keyWindow!.center
            
        }) { (completed) in
            
        }
        
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer){
        if let zoomOutImageView = tapGesture.view {
            zoomOutImageView.layer.cornerRadius = 0
            zoomOutImageView.clipsToBounds = true
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
                
            }) { (completed) in
                zoomOutImageView.removeFromSuperview()
                self.startingImageView?.isHidden = false
            }
            
        }
    }
}

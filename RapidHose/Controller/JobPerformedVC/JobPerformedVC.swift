//
//  JobPerformedVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 08/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobPerformedVC: UIViewController {
    
    @IBOutlet weak var jobDescriptionTextView: CustomTextView!
    
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
    
    //Ashok
    var task : Task_modelClass?
    
    //    var task : Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.btnCornerRadius(radius: 5.0)
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        statusBtn6.btnCornerRadius(radius: statusBtn6.frame.width/2)
        
        print("Inspection \(JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())")
        statusTittleLbl.text = JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus()
        statusImg.image = UIImage.init(named: (JobStatus(rawValue: task!.jobStatus ?? 0)?.getJobStatus())!)
        
        if self.task?.jobPerformed == ""{
            jobDescriptionTextView.placeholderText = "Add Job Description..."
            jobDescriptionTextView.textColor = .white
        }else{
            self.jobDescriptionTextView.text = self.task?.jobPerformed
            jobDescriptionTextView.textColor = .black
        }
        
       submitBtn.setTitle("Next", for: .normal)
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
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
            task?.jobPerformed = jobDescriptionTextView.text
            FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
                guard let self = self else {return}
                if status{
                    self.performSegue(withIdentifier: "jobPerformedVCToPhotoReportVC", sender: nil)
                }
            }
        
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        if jobDescriptionTextView.isDataUpdated{
            task?.jobPerformed = jobDescriptionTextView.text
            FirestoreManager.shared.updateTaskInformation(task: task!) { [weak self](status) in
                guard let self = self else {return}
                if status{
                    self.performSegue(withIdentifier: "jobPerformedVCToPhotoReportVC", sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "jobPerformedVCToPhotoReportVC"{
            if let destination = segue.destination as? PictureReportVC{
                destination.task = task
            }
        }
    }
}

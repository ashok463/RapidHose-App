//
//  MainVC.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 04/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import FirebaseCrashlytics
import Crashlytics

class MainVC: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    //    var tasks = [Task_model]()
    //    var selectedTask : Task_model?
    
    //Ashok
    var tasks = [Task_modelClass]()
    var selectedTask : Task_modelClass?
    var refreshControl = UIRefreshControl()
    var tableMsg = "No job assigned to you yet"
    var statusAlert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavigationController()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        taskTableView.addSubview(refreshControl)
        
        
        FirestoreManager.shared.getUserInformation { (error, userData) in
                if error{
                    
                }else{
                    if userData["firstName"] as? String == "" && userData["lastName"] as? String == ""{

                    }else{
                        let userName = "\(userData["firstName"] ?? "") \(userData["lastName"] ?? "")"
                        UserDefaults.standard.set(userName, forKey: "userName")
                    }
                    
                    if userData["email"] as? String == ""{
                        
                    }else{
                        
                    }
                }
            }
    }
    
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        FirestoreManager.shared.getUserStatusValue { (status) in
            if status{
                self.statusAlert = false
                self.getTasks()
            }else{
                if self.statusAlert{
                    self.statusAlert = false
                }else{
                    self.statusAlert = true
                    AlertService().showAlert(title: "Alert", message: "Your access has been disabled by admin, please contact admin", actionButtonTitle: "Ok", completion: {
                        FirebaseAuthentications.signOut()
                        UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.isLogin)
                        UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.taskID)
                        UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.userName)
                        self.navigationController?.popToRootViewController(animated: true)
                    })
                }
                
            }
        }
    }
    
    func getTasks(){
        FirestoreManager.shared.getTaskInformation { [weak self](status, tasks) in
            guard let self = self else {return}
            if status{
                self.tasks = tasks
                
                
                self.tasks = self.tasks.sorted { string1, string2 in
                    
                    let timeStempDate1 = ("\(string1.createdAt ?? 0)").toDouble() ?? 0.0
                    let timeStempDate2 = ("\(string2.createdAt ?? 0)").toDouble() ?? 0.0
                    return timeStempDate1 > timeStempDate2
//                    let completedTimeStemp = string1.jobCompletedTime
//                    let date1 = Date(timeIntervalSince1970: Double(string1.createdAt as? Int ?? 0))
//                    let date2 = Date(timeIntervalSince1970: Double(string1.createdAt as? Int ?? 0))
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
//                    let strDate11 = formatter.string(from: date1)
//                    let strDate12 = formatter.string(from: date2)
//                    guard let strDate1 = formatter.date(from: strDate11) else { return true }
//                    guard let strDate2 = formatter.date(from: strDate12) else { return false }
//
//                    return strDate1 < Date()
                }
                
                self.taskTableView.reloadData()
            }
        }
    }
    
    @objc func refreshData(sender:AnyObject) {
        // Code to refresh table view
        getTasks()
        self.refreshControl.endRefreshing()
    }
    
    
    private func updateNavigationController(){
        guard let navController = navigationController else { return }
        if !navController.hasViewController(ofKind: LoginVC.self){
            if #available(iOS 13.0, *) {
                let loginVC = AppDelegate.getMainStoryboard().instantiateViewController(identifier: "LoginVC")
                navigationController?.viewControllers.insert(loginVC, at: 0)
            } else {
                // Fallback on earlier versions
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let loginVC = storyboard.instantiateViewController(withIdentifier :"LoginVC") as? LoginVC else { return  }
                navigationController?.viewControllers.insert(loginVC, at: 0)
            }
            
        }
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        if let drawerViewcontroller = self.parent as? KYDrawerController{
            drawerViewcontroller.setDrawerState(.opened, animated: true)
        }
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        logout()
    }
    
    @IBAction func moveToInspectionVC(_ sender: UIButton) {
        performSegue(withIdentifier: "mainVCToInspectionVC", sender: nil)
        
    }
    
    func logout(){
        FirebaseAuthentications.signOut()
        UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.isLogin)
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainVCToTaskInfoVC"{
            if let destination = segue.destination as? TaskInfoVC{
                destination.task = selectedTask
            }
        }
        if segue.identifier == "mainVCToJobCompleted"{
            if let destination = segue.destination as? JobCompletedListVC{
                //                destination.task = selectedTask
            }
        }
    }
    
    @objc func locationBtnPressed(sender: UIButton) {
        
        openMapButtonAction(latitude: tasks[sender.tag].jobCoordinates?.lat ?? 0.0, longitude: tasks[sender.tag].jobCoordinates?.lng ?? 0.0, viewcontroller: self)
    }
}

extension MainVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.taskTableView.deselectRow(at: indexPath, animated: true)
        selectedTask = tasks[indexPath.row]
         UserDefaults.standard.set(tasks[indexPath.row].taskId, forKey: Constants.userDefaulsKeys.taskID)
        performSegue(withIdentifier: "mainVCToTaskInfoVC", sender: self)
        
    }
}

extension MainVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tasks.count)
        if tasks.count == 0 {
            taskTableView.setEmptyMessage(tableMsg)
        }else{
            taskTableView.restore()
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellId") as? TaskCell else {return UITableViewCell()}
        cell.task = tasks[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.locationBtn.addTarget(self, action: #selector(locationBtnPressed(sender:)), for: .touchUpInside)
        cell.locationBtn.tag = indexPath.row
        return cell
    }
    
    //Ashok
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
}

extension PictureReportVC : handlesMapBtnCellActions{
    
}

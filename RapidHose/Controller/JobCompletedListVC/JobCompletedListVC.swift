//
//  JobCompletedListVC.swift
//  RapidHose
//
//  Created by Ashok on 21/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedListVC: UIViewController {

    @IBOutlet weak var jobCompletedListTableView: UITableView!
    
    var tasks = [Task_modelClass]()
    var selectedTask : Task_modelClass?
    var refreshControl = UIRefreshControl()
    var tableMsg = "No job assigned to you yet"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        jobCompletedListTableView.delegate = self
        jobCompletedListTableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        jobCompletedListTableView.addSubview(refreshControl)
    }
    

     //Ashok
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
           
           self.view.setViewBackgroundImg(imgName: "backgroundimage")
           getTasks()
       }
       
       func getTasks(){
           FirestoreManager.shared.getJobCompletedTaskInformation { [weak self](status, tasks) in
               guard let self = self else {return}
               if status{
                   self.tasks = tasks
                
                
                
                self.tasks = self.tasks.sorted { string1, string2 in
                    
                    let timeStempDate1 = (string1.jobCompletedTime)?.toDouble() ?? 0.0
                    let timeStempDate2 = (string2.jobCompletedTime)?.toDouble() ?? 0.0
                    return timeStempDate1 > timeStempDate2
//                    let completedTimeStemp = string1.jobCompletedTime
//                    let date1 = Date(timeIntervalSince1970: (string1.jobCompletedTime)?.toDouble() ?? 0.0)
//                    let date2 = Date(timeIntervalSince1970:date2)
//                    guard let strDate1 = formatter.date(from: strDate11) else { return true }
//                    guard let strDate2 = formatter.date(from: strDate12) else { return false }
//                    return strDate1 < Date()
                }
                
                
//                let sortedArray = self.tasks.sort { (obj1, obj2) -> Bool in
// (string2.jobCompletedTime)?.toDouble() ?? 0.0)
                //                    let formatter = DateFormatter()
                //                    formatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
                //                    let strDate11 = formatter.string(from: date1)
                //                    let strDate12 = formatter.string(from:
//                    let obj11 = Double(obj1.jobCompletedTime ?? "") ?? 0
//                    let obj12 = Double(obj2.jobCompletedTime ?? "") ?? 0
//                    let date1 = NSDate(timeIntervalSince1970:obj11)
//                    let date2 = NSDate(timeIntervalSince1970:obj12)
//
//                    return date1 < date2
//
//                }
//                print("dfgvdhsfdfhdjbfdjghf\(sortedArray)")
                   self.jobCompletedListTableView.reloadData()
               }
           }
       }
       
       @objc func refreshData(sender:AnyObject) {
           // Code to refresh table view
           getTasks()
           self.refreshControl.endRefreshing()
       }
    
    @objc func locationBtnPressed(sender: UIButton) {
        
        openMapButtonAction(latitude: tasks[sender.tag].jobCoordinates?.lat ?? 0.0, longitude: tasks[sender.tag].jobCoordinates?.lng ?? 0.0, viewcontroller: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "JobCompletedListVCToJobCompletedDetailVC"{
                if let destination = segue.destination as? JobCompletedDetailVC{
                    destination.task = selectedTask
                }
            }
        }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension JobCompletedListVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.jobCompletedListTableView.deselectRow(at: indexPath, animated: true)
        selectedTask = tasks[indexPath.row]
//        performSegue(withIdentifier: "mainVCToTaskInfoVC", sender: self)
        performSegue(withIdentifier: "JobCompletedListVCToJobCompletedDetailVC", sender: self)
    }
}

extension JobCompletedListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tasks.count)
        if tasks.count == 0 {
            jobCompletedListTableView.setEmptyMessage(tableMsg)
        }else{
            jobCompletedListTableView.restore()
        }
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = jobCompletedListTableView.dequeueReusableCell(withIdentifier: "JobCompletedListTableViewCell") as? JobCompletedListTableViewCell else {return UITableViewCell()}
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
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

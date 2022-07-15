//
//  MenuVC.swift
//  RapidHose
//
//  Created by Ashok on 29/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var employeeIdLbl: UILabel!
    
    
    var menuArr = ["Job history", "Privacy Policy", "About", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)

        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
        
        FirestoreManager.shared.getUserInformation { (error, userData) in
            if error{
                
            }else{
                if userData["firstName"] as? String == "" && userData["lastName"] as? String == ""{
                    self.userNameLbl.text = ""
                }else{
                    self.userNameLbl.text = "\(userData["firstName"] ?? "") \(userData["lastName"] ?? "")"
                    UserDefaults.standard.set(self.userNameLbl.text, forKey: "userName")
                }
                
                if userData["email"] as? String == ""{
                    self.emailLbl.text = ""
                }else{
                    self.emailLbl.text = "\(userData["email"] ?? "")"
                }
                
                if userData["phone"] as? String == ""{
                    self.phoneNumberLbl.text = ""
                }else{
                    self.phoneNumberLbl.text = "\(userData["phone"] ?? "")"
                }
                
                if userData["id"] as? String == ""{
                    self.employeeIdLbl.text = ""
                }else{
                    self.employeeIdLbl.text = "\(userData["id"] ?? "")"
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            if segue.identifier == "mainVCToJobCompleted"{
                if let destination = segue.destination as? JobCompletedListVC{
    //                destination.task = selectedTask
                }
            }
        }
    
}

extension MenuVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuTableViewCell = menuTableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as? MenuTableViewCell
        menuTableViewCell?.nameLbl.text = menuArr[indexPath.row]
        return menuTableViewCell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            let jobCompletedListVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCompletedListVC") as! JobCompletedListVC
            self.navigationController?.pushViewController(jobCompletedListVC, animated: true)
        }
        
        if indexPath.row == 1{
            let privacyPolicyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            self.navigationController?.pushViewController(privacyPolicyVC, animated: true)
        }
        
        if indexPath.row == 2{
            let aboutVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
        
        if indexPath.row == 3{
            // create the alert
            let alert = UIAlertController(title: "RapidHose", message: "Are you sure you want to Logout?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                FirebaseAuthentications.signOut()
                UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.isLogin)
                UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.taskID)
                UserDefaults.standard.set(false, forKey: Constants.userDefaulsKeys.userName)
                self.navigationController?.popToRootViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}

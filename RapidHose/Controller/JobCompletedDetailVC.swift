//
//  JobCompletedDetailVC.swift
//  RapidHose
//
//  Created by Ashok on 26/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

enum TabIndex : Int {
    
    case firstChildTab = 0
    case secondChildTab = 1
    case thiredChildTab = 2
    case fourthChildTab = 3
    case fifthChildTab = 4
}

protocol MoveViewControllerProtocol {
    func moveViewController(index: Int)
}


class JobCompletedDetailVC: UIViewController, MoveViewControllerProtocol {
    
    
    @IBOutlet weak var topTitleLbl: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    
    /* VARIABLES */
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        
        let jobCompletedTaskInfoVCTabVCChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCompletedTaskInfoVC") as? JobCompletedTaskInfoVC
        jobCompletedTaskInfoVCTabVCChildTabVC?.task = task
        jobCompletedTaskInfoVCTabVCChildTabVC?.delegate = self
        return jobCompletedTaskInfoVCTabVCChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        
        let jobCompletedEditTaskInfoVCChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCompletedEditTaskInfoVC") as? JobCompletedEditTaskInfoVC
        jobCompletedEditTaskInfoVCChildTabVC?.task = task
        jobCompletedEditTaskInfoVCChildTabVC?.delegate = self
        return jobCompletedEditTaskInfoVCChildTabVC
    }()
    
    lazy var thirdChildTabVC : UIViewController? = {
        
        let JobCompletedInspectionVCChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCompletedInspectionVC") as? JobCompletedInspectionVC
        JobCompletedInspectionVCChildTabVC?.task = task
        JobCompletedInspectionVCChildTabVC?.delegate = self
        return JobCompletedInspectionVCChildTabVC
    }()
    
    lazy var fourthChildTabVC : UIViewController? = {
        
        let jobCompletedJobPerformedVCChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCompletedJobPerformedVC") as? JobCompletedJobPerformedVC
        jobCompletedJobPerformedVCChildTabVC?.task = task
        jobCompletedJobPerformedVCChildTabVC?.delegate = self
        return jobCompletedJobPerformedVCChildTabVC
    }()
    
    lazy var fifthChildTabVC : UIViewController? = {
        
        let jobCompletedPictureReportVCChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "JobCompletedPictureReportVC") as? JobCompletedPictureReportVC
        jobCompletedPictureReportVCChildTabVC?.task = task
        jobCompletedPictureReportVCChildTabVC?.delegate = self
        return jobCompletedPictureReportVCChildTabVC
    }()
    
    
    var task : Task_modelClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        topTitleLbl.text = "Task Id : \(task?.randomTaskId ?? 0)"
        
        segmentControl.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.containerView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.containerView.addGestureRecognizer(swipeLeft)
        
        let swipeRight1 = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight1.direction = .right
        self.backgroundImg.addGestureRecognizer(swipeRight1)
        
        let swipeLeft1 = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft1.direction = .left
        self.backgroundImg.addGestureRecognizer(swipeLeft1)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            if swipeGesture.direction == .left
                
            {
                if self.segmentControl.selectedSegmentIndex > 0 || self.segmentControl.selectedSegmentIndex == 0
                {
                    if self.segmentControl.selectedSegmentIndex == 4{
                        
                    }else{
                        self.segmentControl.selectedSegmentIndex += 1
                    }
                }
                
            }
            
            if swipeGesture.direction == .right
            {
                if self.segmentControl.selectedSegmentIndex < 4 || self.segmentControl.selectedSegmentIndex == 4
                {
                    if self.segmentControl.selectedSegmentIndex == 0{
                        
                    }else{
                        self.segmentControl.selectedSegmentIndex -= 1
                    }
                }
                
            }
            self.currentViewController!.view.removeFromSuperview()
            self.currentViewController!.removeFromParent()
            
            displayCurrentTab(self.segmentControl.selectedSegmentIndex)
        }
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.view.setViewBackgroundImg(imgName: "backgroundimage")
        containerView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
    }
    
    func moveViewController(index: Int) {
        
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        self.segmentControl.selectedSegmentIndex = index
        displayCurrentTab(self.segmentControl.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        
        if segmentControl.selectedSegmentIndex == 0{
            leftBtn.isHidden = true
        }else{
            leftBtn.isHidden = false
        }
        
        if segmentControl.selectedSegmentIndex == 4{
            rightBtn.isHidden = true
        }else{
            rightBtn.isHidden = false
        }
        
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var selectedVC: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            selectedVC = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            selectedVC = secondChildTabVC
        case TabIndex.thiredChildTab.rawValue :
            selectedVC = thirdChildTabVC
        case TabIndex.fourthChildTab.rawValue :
            selectedVC = fourthChildTabVC
        case TabIndex.fifthChildTab.rawValue :
            selectedVC = fifthChildTabVC
        default:
            return nil
        }
        
        return selectedVC
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab((sender).selectedSegmentIndex)
    }
    
    
    @IBAction func leftBtnAction(_ sender: UIButton) {
        
        if self.segmentControl.selectedSegmentIndex < 4 || self.segmentControl.selectedSegmentIndex == 4
               {
                   if self.segmentControl.selectedSegmentIndex == 0{
                       
                   }else{
                       self.segmentControl.selectedSegmentIndex -= 1
                   }
               }
        
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab(self.segmentControl.selectedSegmentIndex)
        
    }
    
    @IBAction func rightBtnAction(_ sender: UIButton) {
        
       
        if self.segmentControl.selectedSegmentIndex > 0 || self.segmentControl.selectedSegmentIndex == 0
        {
            if self.segmentControl.selectedSegmentIndex == 4{
                
            }else{
                self.segmentControl.selectedSegmentIndex += 1
            }
        }
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab(self.segmentControl.selectedSegmentIndex)
    }
}

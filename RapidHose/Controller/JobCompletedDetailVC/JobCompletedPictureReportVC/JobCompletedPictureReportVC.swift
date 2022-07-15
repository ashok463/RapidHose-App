//
//  JobCompletedPictureReportVC.swift
//  RapidHose
//
//  Created by Ashok on 26/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedPictureReportVC: UIViewController {

    @IBOutlet weak var backgroundTxtView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var pictureReportCollectionView: UICollectionView!
    @IBOutlet weak var statusBtn1: UIButton!
    @IBOutlet weak var statusBtn2: UIButton!
    @IBOutlet weak var statusBtn3: UIButton!
    @IBOutlet weak var statusBtn4: UIButton!
    @IBOutlet weak var statusBtn5: UIButton!
    
    var photoTasks = [PictureTask]()
    var task : Task_modelClass?
    
    let tasksImages = ["dummyImgGallery", "unitnoIc", "serialnumberIc", "hourmeterIc", "siteoverviewIc", "failureareaIc", "faultypartIc", "removedIc", "newassemblyIc", "completerepairIc", "tanklevelc", "otherIc"]
    let tasks = ["Subject", "Unit Number", "Serial Number", "Hour Meter", "Site Overview", "Failure Area", "Faulty Part", "Removed", "New Assembly/Part", "Complete Repair", "Tank Level", "Other"]
    
    var startingFrame : CGRect?
    var blackBackgroundView : UIView?
    var startingImageView : UIImageView?
    
    var delegate: MoveViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        statusBtn1.btnCornerRadius(radius: statusBtn1.frame.width/2)
        statusBtn2.btnCornerRadius(radius: statusBtn2.frame.width/2)
        statusBtn3.btnCornerRadius(radius: statusBtn3.frame.width/2)
        statusBtn4.btnCornerRadius(radius: statusBtn4.frame.width/2)
        statusBtn5.btnCornerRadius(radius: statusBtn5.frame.width/2)
        
        pictureReportCollectionView.delegate = self
        pictureReportCollectionView.dataSource = self
        
        setFlowLayoutOfCollectionView()
        setDataForCollectionView()
        
    }
    
    //Ashok
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        self.view.setViewBackgroundImg(imgName: "backgroundimage")
//        backgroundImg.applyshadowWithCorner(containerView: backgroundTxtView, cornerRadious: 5)
        backgroundTxtView.applyShadowWithCornerRadius(color: .darkGray, opacity: 1.0, radius: 5.0, cornerRadius: 10.0, edge: .All, shadowSpace: 20)
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

   @IBAction func btn1Action(_ sender: UIButton) {
    delegate?.moveViewController(index: 0)
    }
    
    @IBAction func btn2Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 1)
    }
    
    @IBAction func btn3Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 2)
    }
    
    @IBAction func btn4Action(_ sender: UIButton) {
        delegate?.moveViewController(index: 3)
    }
    
    @IBAction func btn5Action(_ sender: UIButton) {
//        delegate?.moveViewController(index: 4)
    }

}

extension JobCompletedPictureReportVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pictureReportCollectionView.dequeueReusableCell(withReuseIdentifier: "JobCompletedPictureTaskCell", for: indexPath) as? JobCompletedPictureTaskCell else {return UICollectionViewCell()}
        cell.pictureTask = photoTasks[indexPath.item]
        cell.delegate = self
        return cell
    }
}

extension JobCompletedPictureReportVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {return CGSize(width: 40, height: 40)}
        let minimumLineSpacing = flowLayout.minimumInteritemSpacing
        let insets = flowLayout.sectionInset
        let numberOfColumns = 3
        let padding: CGFloat =  insets.left + insets.right + CGFloat((numberOfColumns - 1))*minimumLineSpacing
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: Int(collectionViewSize)/numberOfColumns, height: Int(collectionViewSize)/numberOfColumns + 30)
    }

}

extension JobCompletedPictureReportVC : jobCompletedHandlesCellActions{
    
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

//
//  JobCompletedPictureTaskCell.swift
//  RapidHose
//
//  Created by Ashok on 27/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

@objc protocol jobCompletedHandlesCellActions{
    @objc optional func takePictureBtnPressed(indexPath : IndexPath)
    @objc optional func zoomPictureBtnPressed(indexPath : IndexPath, imageView : UIImageView)
}


class JobCompletedPictureTaskCell: UICollectionViewCell {
    
    @IBOutlet weak var taskPictureImageView: UIImageView!
       @IBOutlet weak var taskNameLbl: UILabel!
       @IBOutlet weak var zoomInBtn: UIButton!
       @IBOutlet weak var dummyImgView: UIImageView!
       @IBOutlet weak var dummyTxtLbl: UILabel!
    
    weak var delegate : jobCompletedHandlesCellActions?
    
    //Ashok
    var task : Task_modelClass?
    
    var pictureTask : PictureTask?{
        didSet{
            
            if pictureTask?.taskImage == "" || pictureTask?.taskImage == nil{
                dummyImgView.isHidden = false
                dummyTxtLbl.isHidden = false
                taskNameLbl.isHidden = true
                taskPictureImageView.isHidden = true
                zoomInBtn.isHidden = true
                dummyTxtLbl.text = pictureTask?.taskName
                dummyImgView.image = UIImage.init(named: pictureTask?.taskdummyImage ?? "")
            }else{
                dummyImgView.isHidden = true
                dummyTxtLbl.isHidden = true
                taskNameLbl.isHidden = false
                taskPictureImageView.isHidden = false
                zoomInBtn.isHidden = false
                taskNameLbl.text = pictureTask?.taskName
                taskPictureImageView.loadImageUsingCacheWithUrlString(urlString: pictureTask?.taskImage ?? "")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func awakeFromNib() {
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.darkGray.cgColor
        self.contentView.layer.masksToBounds = true
    }
    
    private func settingCellProperties(){
        zoomInBtn.isHidden = true
    }
    
    @IBAction func zoomBtnPressed(_ sender: UIButton) {
        guard let collectionView = self.superview as? UICollectionView , let delegate = delegate else {return}
        if let indexPath = collectionView.indexPath(for: self){
            delegate.zoomPictureBtnPressed?(indexPath: indexPath, imageView : taskPictureImageView)
        }
    }
}

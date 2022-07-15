//
//  PictureTaskCell.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 08/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

@objc protocol handlesCellActions{
    @objc optional func takePictureBtnPressed(indexPath : IndexPath)
    @objc optional func zoomPictureBtnPressed(indexPath : IndexPath, imageView : UIImageView)
}

class PictureTaskCell: UICollectionViewCell {
    
    @IBOutlet weak var taskPictureImageView: UIImageView!
    @IBOutlet weak var taskNameLbl: UILabel!
    @IBOutlet weak var addImageBtn: UIButton!
    @IBOutlet weak var zoomInBtn: UIButton!
    @IBOutlet weak var dummyImgView: UIImageView!
    @IBOutlet weak var dummyTxtLbl: UILabel!
    
    weak var delegate : handlesCellActions?
    
    //Ashok
    var task : Task_modelClass?
    
    var pictureTask : PictureTask?{
        didSet{
            
            if pictureTask?.taskImage == "" || pictureTask?.taskImage == nil{
                dummyImgView.isHidden = false
                dummyTxtLbl.isHidden = false
                taskNameLbl.isHidden = true
                taskPictureImageView.isHidden = true
                dummyTxtLbl.text = pictureTask?.taskName
                dummyImgView.image = UIImage.init(named: pictureTask?.taskdummyImage ?? "")
            }else{
                dummyImgView.isHidden = true
                dummyTxtLbl.isHidden = true
                taskNameLbl.isHidden = false
                taskPictureImageView.isHidden = false
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
        settingCellProperties()
    }
    
    private func settingCellProperties(){
        zoomInBtn.isHidden = true
    }
    
    @IBAction func addImageBtnPressed(_ sender: UIButton) {
        guard let delegate = delegate else {return}
        guard let collectionView = self.superview as? UICollectionView else {return}
        if let indexPath = collectionView.indexPath(for: self){
            delegate.takePictureBtnPressed?(indexPath: indexPath)
        }
        
    }
    
    @IBAction func zoomBtnPressed(_ sender: UIButton) {
        guard let collectionView = self.superview as? UICollectionView , let delegate = delegate else {return}
        if let indexPath = collectionView.indexPath(for: self){
            delegate.zoomPictureBtnPressed?(indexPath: indexPath, imageView : taskPictureImageView)
        }
    }
    
}

//
//  InspectionPropertyCell.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 05/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

@objc protocol CheckboxActions{
    @objc optional func correctBtnPressed(indexPath : IndexPath)
    @objc optional func wrongBtnPressed(indexPath : IndexPath)
    @objc optional func addMultiHoseserialNumber(indexPath : IndexPath)
}

class InspectionPropertyCell: UITableViewCell {
    
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var correctBtn: UIButton!
    @IBOutlet weak var wrongBtn: UIButton!
    
    weak var delegate : CheckboxActions?
    
    var parameterInfo : ParameterInfo?{
        didSet{
            propertyName.text = parameterInfo?.propertyName
            updateButtonsStatus(parameter: parameterInfo!)
        }
    }
    
    func updateButtonsStatus(parameter : ParameterInfo){
        guard let propertyStatus = parameter.status else{
            correctBtn.isSelected = false
            correctBtn.setImage(#imageLiteral(resourceName: "reloadmark"), for: .normal)
            wrongBtn.isSelected = false
            wrongBtn.setImage(#imageLiteral(resourceName: "reloadmark"), for: .normal)
            return
        }
        
        if propertyStatus{
            correctBtn.isSelected = true
            correctBtn.setImage(#imageLiteral(resourceName: "tickmark"), for:.normal)
            wrongBtn.isSelected = false
            wrongBtn.setImage(#imageLiteral(resourceName: "reloadmark"), for: .normal)
        }else{
            correctBtn.isSelected = false
            correctBtn.setImage(#imageLiteral(resourceName: "reloadmark"), for: .normal)
            wrongBtn.isSelected = true
            wrongBtn.setImage(#imageLiteral(resourceName: "untickmark"), for: .normal)
        }
    }
    
    func setImagesForBtn(){
        correctBtn.setImage(#imageLiteral(resourceName: "reloadmark"), for: .normal)
        correctBtn.setImage(#imageLiteral(resourceName: "tickmark"), for: .selected)
        wrongBtn.setImage(#imageLiteral(resourceName: "reloadmark"), for: .normal)
        wrongBtn.setImage(#imageLiteral(resourceName: "untickmark"), for: .selected)
    }
    
    @IBAction func correctBtnPressed(_ sender: UIButton) {
        
        correctBtn.isSelected.toggle()
        if correctBtn.isSelected{
            parameterInfo?.status = true
        }else{
            parameterInfo?.status = nil
        }
        if let tableView = self.superview as? UITableView, let delegate = delegate{
            let indexpath = tableView.indexPath(for: self)
            delegate.correctBtnPressed?(indexPath: indexpath!)
        }
    }
    
    @IBAction func wrongBtnPressed(_ sender: UIButton) {
        wrongBtn.isSelected.toggle()
        if wrongBtn.isSelected{
            parameterInfo?.status = false
        }else{
            parameterInfo?.status = nil
        }
        
        if let tableView = self.superview as? UITableView, let delegate = delegate{
            let indexpath = tableView.indexPath(for: self)
            delegate.wrongBtnPressed?(indexPath: indexpath!)
        }
    }
    
}

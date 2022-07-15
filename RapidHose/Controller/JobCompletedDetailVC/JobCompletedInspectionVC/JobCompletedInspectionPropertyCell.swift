//
//  JobCompletedInspectionPropertyCell.swift
//  RapidHose
//
//  Created by Ashok on 28/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit

class JobCompletedInspectionPropertyCell: UITableViewCell {

    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

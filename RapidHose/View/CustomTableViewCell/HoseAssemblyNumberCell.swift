//
//  HoseAssemblyNumberCell.swift
//  RapidHose
//
//  Created by Kirti Ahlawat on 10/06/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import DropDown

class HoseAssemblyNumberCell: UITableViewCell {
    
    @IBOutlet weak var hoseAssemblyNumberTextField: UITextField!
    
    @IBOutlet weak var btnHoseSerialnumber: UIButton!
    @IBOutlet weak var heightConstraintbtnHoseSerialnumber: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField1: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField1: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField2: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField2: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField3: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField3: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField4: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField4: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField5: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField5: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField6: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField6: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField7: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField7: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField8: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField8: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField9: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField9: NSLayoutConstraint!
    
    @IBOutlet weak var hoseSerialNumberTxtField10: UITextField!
    @IBOutlet weak var heightSerialNumberTxtField10: NSLayoutConstraint!
    
    @IBOutlet weak var topLayoutSerialTxtField1: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField2: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField3: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField4: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField5: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField6: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField7: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField8: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField9: NSLayoutConstraint!
    @IBOutlet weak var topLayoutSerialTxtField10: NSLayoutConstraint!
    
    var parameterInfo : ParameterInfo?{
        didSet{
            
            if parameterInfo?.subPropertyValue == "" || parameterInfo?.subPropertyValue == nil{

            }else{
                let values = parameterInfo?.subPropertyValue?.components(separatedBy: ",")
                for i in 0..<values!.count {
                    if i == 0{
                        hoseAssemblyNumberTextField.text = values?[0]
                    }

                    if i == 1{
                        hoseSerialNumberTxtField2.text = values?[1]
                    }

                    if i == 2{
                        hoseSerialNumberTxtField3.text = values?[2]
                    }

                    if i == 3{
                        hoseSerialNumberTxtField4.text = values?[3]
                    }

                    if i == 4{
                        hoseSerialNumberTxtField5.text = values?[4]
                    }

                    if i == 5{
                        hoseSerialNumberTxtField6.text = values?[5]
                    }

                    if i == 6{
                        hoseSerialNumberTxtField7.text = values?[6]
                    }

                    if i == 7{
                        hoseSerialNumberTxtField8.text = values?[7]
                    }

                    if i == 8{
                        hoseSerialNumberTxtField9.text = values?[8]
                    }


                    if i == 9{
                        hoseSerialNumberTxtField10.text = values?[9]
                    }
                }
            }
        }
    }
    
    var subPropertyValue = String()
    weak var delegate : CheckboxActions?
    
    @IBAction func btnHoseSerialnumberAction(_ sender: UIButton) {
        
        //        btnHoseSerialnumber.isSelected.toggle()
        //        if btnHoseSerialnumber.isSelected{
        //            btnHoseSerialnumber.setTitle("Done", for: .normal)
        //             hoseSerialNumberTxtField2.isHidden = false
        //                       hoseSerialNumberTxtField3.isHidden = false
        //                       hoseSerialNumberTxtField4.isHidden = false
        //                       hoseSerialNumberTxtField5.isHidden = false
        //                       hoseSerialNumberTxtField6.isHidden = false
        //                       hoseSerialNumberTxtField7.isHidden = false
        //                       hoseSerialNumberTxtField8.isHidden = false
        //                       hoseSerialNumberTxtField9.isHidden = false
        //                       hoseSerialNumberTxtField10.isHidden = false
        //        }else{
        //            btnHoseSerialnumber.setTitle("Add  more fields", for: .normal)
        //            hoseSerialNumberTxtField2.isHidden = true
        //            hoseSerialNumberTxtField3.isHidden = true
        //            hoseSerialNumberTxtField4.isHidden = true
        //            hoseSerialNumberTxtField5.isHidden = true
        //            hoseSerialNumberTxtField6.isHidden = true
        //            hoseSerialNumberTxtField7.isHidden = true
        //            hoseSerialNumberTxtField8.isHidden = true
        //            hoseSerialNumberTxtField9.isHidden = true
        //            hoseSerialNumberTxtField10.isHidden = true
        //        }
        //        if sender.currentTitle == "Add  more fields" && sender.isSelected{
        //            sender.isSelected = false
        //            sender.setTitle("Done", for: .normal)
        ////            topLayoutSerialTxtField2.constant = 10
        ////            topLayoutSerialTxtField3.constant = 10
        ////            topLayoutSerialTxtField4.constant = 10
        ////            topLayoutSerialTxtField5.constant = 10
        ////            topLayoutSerialTxtField6.constant = 10
        ////            topLayoutSerialTxtField7.constant = 10
        ////            topLayoutSerialTxtField8.constant = 10
        ////            topLayoutSerialTxtField9.constant = 10
        ////            topLayoutSerialTxtField10.constant = 10
        ////
        ////
        ////            heightSerialNumberTxtField2.constant = 40
        ////            heightSerialNumberTxtField3.constant = 40
        ////            heightSerialNumberTxtField4.constant = 40
        ////            heightSerialNumberTxtField5.constant = 40
        ////            heightSerialNumberTxtField6.constant = 40
        ////            heightSerialNumberTxtField7.constant = 40
        ////            heightSerialNumberTxtField8.constant = 40
        ////            heightSerialNumberTxtField9.constant = 40
        ////            heightSerialNumberTxtField10.constant = 40
        //
        //            hoseSerialNumberTxtField2.isHidden = false
        //            hoseSerialNumberTxtField3.isHidden = false
        //            hoseSerialNumberTxtField4.isHidden = false
        //            hoseSerialNumberTxtField5.isHidden = false
        //            hoseSerialNumberTxtField6.isHidden = false
        //            hoseSerialNumberTxtField7.isHidden = false
        //            hoseSerialNumberTxtField8.isHidden = false
        //            hoseSerialNumberTxtField9.isHidden = false
        //            hoseSerialNumberTxtField10.isHidden = false
        //
        //        }else{
        //            sender.isSelected = true
        //            sender.setTitle("Add  more fields", for: .normal)
        ////            topLayoutSerialTxtField2.constant = 0
        ////            topLayoutSerialTxtField3.constant = 0
        ////            topLayoutSerialTxtField4.constant = 0
        ////            topLayoutSerialTxtField5.constant = 0
        ////            topLayoutSerialTxtField6.constant = 0
        ////            topLayoutSerialTxtField7.constant = 0
        ////            topLayoutSerialTxtField8.constant = 0
        ////            topLayoutSerialTxtField9.constant = 0
        ////            topLayoutSerialTxtField10.constant = 0
        ////
        ////
        ////            heightSerialNumberTxtField2.constant = 0
        ////            heightSerialNumberTxtField3.constant = 0
        ////            heightSerialNumberTxtField4.constant = 0
        ////            heightSerialNumberTxtField5.constant = 0
        ////            heightSerialNumberTxtField6.constant = 0
        ////            heightSerialNumberTxtField7.constant = 0
        ////            heightSerialNumberTxtField8.constant = 0
        ////            heightSerialNumberTxtField9.constant = 0
        ////            heightSerialNumberTxtField10.constant = 0
        //
        //            hoseSerialNumberTxtField2.isHidden = true
        //            hoseSerialNumberTxtField3.isHidden = true
        //            hoseSerialNumberTxtField4.isHidden = true
        //            hoseSerialNumberTxtField5.isHidden = true
        //            hoseSerialNumberTxtField6.isHidden = true
        //            hoseSerialNumberTxtField7.isHidden = true
        //            hoseSerialNumberTxtField8.isHidden = true
        //            hoseSerialNumberTxtField9.isHidden = true
        //            hoseSerialNumberTxtField10.isHidden = true
        //        }
        
        //        if let tableView = self.superview as? UITableView, let delegate = delegate{
        //                   let indexpath = tableView.indexPath(for: self)
        //                  delegate.addMultiHoseserialNumber?(indexPath: indexpath!)
        //               }
        
        var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
        
        print(hoseSerialvalues)
        hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
        print(hoseSerialvalues)
        hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
        print(hoseSerialvalues)
        let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
        
        if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
            hoseSerialvalues = String(hoseSerialvalues.dropFirst())
        }
        
        if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
            hoseSerialvalues = String(hoseSerialvalues.dropLast())
        }
        parameterInfo?.subPropertyValue = hoseSerialvalues
    } 
    
    
    override func awakeFromNib() {
        hoseAssemblyNumberTextField.delegate = self
        hoseSerialNumberTxtField2.delegate = self
        hoseSerialNumberTxtField3.delegate = self
        hoseSerialNumberTxtField4.delegate = self
        hoseSerialNumberTxtField5.delegate = self
        hoseSerialNumberTxtField6.delegate = self
        hoseSerialNumberTxtField7.delegate = self
        hoseSerialNumberTxtField8.delegate = self
        hoseSerialNumberTxtField9.delegate = self
        hoseSerialNumberTxtField10.delegate = self
        
        btnHoseSerialnumber.btnCornerRadius(radius: 10)
        
        //        topLayoutSerialTxtField2.constant = 0
        //        topLayoutSerialTxtField3.constant = 0
        //        topLayoutSerialTxtField4.constant = 0
        //        topLayoutSerialTxtField5.constant = 0
        //        topLayoutSerialTxtField6.constant = 0
        //        topLayoutSerialTxtField7.constant = 0
        //        topLayoutSerialTxtField8.constant = 0
        //        topLayoutSerialTxtField9.constant = 0
        //        topLayoutSerialTxtField10.constant = 0
        //
        //
        //        heightSerialNumberTxtField2.constant = 0
        //        heightSerialNumberTxtField3.constant = 0
        //        heightSerialNumberTxtField4.constant = 0
        //        heightSerialNumberTxtField5.constant = 0
        //        heightSerialNumberTxtField6.constant = 0
        //        heightSerialNumberTxtField7.constant = 0
        //        heightSerialNumberTxtField8.constant = 0
        //        heightSerialNumberTxtField9.constant = 0
        //        heightSerialNumberTxtField10.constant = 0
        
        
        //        hoseSerialNumberTxtField2.isHidden = true
        //        hoseSerialNumberTxtField3.isHidden = true
        //        hoseSerialNumberTxtField4.isHidden = true
        //        hoseSerialNumberTxtField5.isHidden = true
        //        hoseSerialNumberTxtField6.isHidden = true
        //        hoseSerialNumberTxtField7.isHidden = true
        //        hoseSerialNumberTxtField8.isHidden = true
        //        hoseSerialNumberTxtField9.isHidden = true
        //        hoseSerialNumberTxtField10.isHidden = true
        
    }
    
}

extension HoseAssemblyNumberCell : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField == hoseAssemblyNumberTextField{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField2{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField3{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField3{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField4{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField5{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField6{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField7{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField8{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField9{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        
        if textField == hoseSerialNumberTxtField10{
            
            var hoseSerialvalues = "\(hoseAssemblyNumberTextField.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
            
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: ",", with: " ", options: NSString.CompareOptions.literal, range: nil)
            print(hoseSerialvalues)
            hoseSerialvalues = hoseSerialvalues.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: ",", options: .regularExpression)
            print(hoseSerialvalues)
            let startIndex = hoseSerialvalues.index(hoseSerialvalues.startIndex, offsetBy: 1)
            
            if String(hoseSerialvalues[..<startIndex]).contains(",") || String(hoseSerialvalues[..<startIndex]).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropFirst())
            }
            
            if String(hoseSerialvalues.last!).contains(",") || String(hoseSerialvalues.last!).contains(" "){
                hoseSerialvalues = String(hoseSerialvalues.dropLast())
            }
            parameterInfo?.subPropertyValue = hoseSerialvalues
        }
        //        if hoseAssemblyNumberTextField.text != Constants.empty{
        //            if hoseAssemblyNumberTextField.text == "1"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text!)"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "2"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "3"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "4"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "5"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "6"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "7"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "8"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "9"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8, hoseSerialNumberTxtField9){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? "")"
        //                }
        //            }
        //
        //            if hoseAssemblyNumberTextField.text == "10"{
        //                if Utility.checkIfAnyTextFieldIsEmpty(hoseSerialNumberTxtField1, hoseSerialNumberTxtField2, hoseSerialNumberTxtField3, hoseSerialNumberTxtField4, hoseSerialNumberTxtField5, hoseSerialNumberTxtField6, hoseSerialNumberTxtField7, hoseSerialNumberTxtField8, hoseSerialNumberTxtField9, hoseSerialNumberTxtField10){
        //                    parameterInfo?.subPropertyValue = "\(hoseSerialNumberTxtField1.text ?? ""), \(hoseSerialNumberTxtField2.text ?? ""), \(hoseSerialNumberTxtField3.text ?? ""), \(hoseSerialNumberTxtField4.text ?? ""), \(hoseSerialNumberTxtField5.text ?? ""), \(hoseSerialNumberTxtField6.text ?? ""), \(hoseSerialNumberTxtField7.text ?? ""), \(hoseSerialNumberTxtField8.text ?? ""), \(hoseSerialNumberTxtField9.text ?? ""), \(hoseSerialNumberTxtField10.text ?? "")"
        //                }
        //            }
        //            parameterInfo?.subPropertyValue = Int(textField.text!)
        //        }
    }
    
}

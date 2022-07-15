//
//  SwipeVC.swift
//  RapidHose
//
//  Created by Ashok on 25/08/20.
//  Copyright © 2020 Kayosys. All rights reserved.
//

import UIKit
import SwipeViewController

class SwipeVC: SwipeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(push))
        barButtonItem.tintColor = .black
        leftBarButtonItem = barButtonItem
    }
    

    @objc func push(sender _: UIBarButtonItem) {
        let VC4 = UIViewController()
        VC4.view.backgroundColor = UIColor.purple
        VC4.title = "Cool"
        pushViewController(VC4, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

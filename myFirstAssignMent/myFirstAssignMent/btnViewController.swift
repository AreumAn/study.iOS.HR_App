//
//  btnViewController.swift
//  myFirstAssignMent
//
//  Created by Areum on 2016-11-26.
//  Copyright © 2016 Areum. All rights reserved.
//

import UIKit

class btnViewController: UIViewController {
    
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var txtSearchEmp: UITextField!
    
    var ViewController: ViewController
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnAdd(_ sender: AnyObject) {
        guard let name = ViewController.txtEmpName.text, !name.isEmpty else {
            ViewController.txtEmpName.becomeFirstResponder()
            print("Test")
            
            return
        }
    }
    

}

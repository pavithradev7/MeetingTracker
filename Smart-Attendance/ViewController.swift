//
//  ViewController.swift
//  Smart-Attendance
//
//  Created by Modali,Naga Sravanthi on 2/16/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var roleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var SidTextView: UITextField!
    
    @IBOutlet weak var pwdTextView: UITextField!
    
    
    @IBAction func signupBtn(_ sender: UIButton) {
        
        if !((SidTextView.text?.isEmpty)! || (pwdTextView.text?.isEmpty)!){
            
            let userId = SidTextView.text
            let password = pwdTextView.text
            print("signing up  \(userId) with pwd \(password)" )
        }
    }
}


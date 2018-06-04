//
//  SignupViewController.swift
//  Smart-Attendance
//
//  Created by Modali,Naga Sravanthi on 4/2/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.studentOrFacultyPV.delegate = self
        self.studentOrFacultyPV.dataSource = self
        // Do any additional setup after loading the view.
        
        pickerData = ["Student", "Faculty"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBOutlet weak var SidTextView: UITextField!
    @IBOutlet weak var pwdTextView: UITextField!
    @IBOutlet weak var emailTextView: UITextField!
    
    @IBOutlet weak var studentOrFacultyPV: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    @IBAction func register(sender: AnyObject) {
        // Defining the user object
        let user = PFUser()
        user.username = SidTextView.text! //usernameTF.text!
        user.password = pwdTextView.text!
        user.email = emailTextView.text!
        user["role"] = "Student"
        let row = [studentOrFacultyPV .selectedRow(inComponent: 0)]
        // user["role"] = pickerData[row]
        
        
        
        
        
        print("signing up  \(user.username) with pwd \(user.password)" )
        
        user.signUpInBackground(block: {
            (success, error) -> Void in
            if let error = error as Error? {
                let errorString = error.localizedDescription
                // In case something went wrong, use errorString to get the error
                self.displayOKAlert(title: "Something has gone wrong", message:"\(errorString)")
            } else {
                // Everything went okay
                self.displayOKAlert(title: "Success!", message:"Registration was successful")
                let emailVerified = user["emailVerified"]
                if emailVerified != nil && (emailVerified as! Bool) == true {
                    // Everything is fine
                } else {
                    // The email has not been verified, so logout the user
                    PFUser.logOut()
                }
            } })
    }
    
    
    func displayOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    
    
    
    
    
}

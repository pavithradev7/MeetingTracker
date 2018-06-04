//
//  LoginViewController.swift
//  Smart-Attendance
//
//  Created by Yandapalli,Uma on 2/16/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import Parse

//The view is responsiblefor logging in of faculty and student
class LoginViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    var role = ["Faculty","Student"]
    var selectedRole = "Faculty"
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //This funcion is responsible for picker view of the row
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return role.count
    }
    
    //This funcion is responsible for picker view of selecting row

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRole = role[row]
    }
    //This funcion is responsible for picker view of title of  row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return role[row]
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is responsible for sid textfield
    @IBOutlet weak var sidTF: UITextField!
    
    //This is responsible for password textfield
    @IBOutlet weak var passwordTF: UITextField!
    var userID : String = ""
    
    //This isresponsible for performing segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "submitId"{
            
            if(sidTF.text==""||passwordTF.text==""){
                let alert = UIAlertController(title: title, message: "Please enter all Fields",preferredStyle: .alert) // actions, displayed as Buttons in the alert, specify both the title of the button                 // and what to do -- in the handler -- when the button is tapped)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated:true,completion:nil)
                    
                }))
                self.present(alert,animated: true,completion:nil)
            }
        }
        return true
    }
    
    
    
    //The user can login using this function
    @IBAction func login(sender: AnyObject) {
        PFUser.logInWithUsername(inBackground: sidTF.text!, password: passwordTF.text!,
                                 block:{(user, error) -> Void in
                                    if error != nil{
                                        print(error)
                                        self.displayNotOKAlert(title: "Login failed!", message:"Invalid credentials")
                                    }
                                    else {
                                        self.userID = self.sidTF.text!
                                        // Everything went alright here
                                        self.displayOKAlert(title: "Success!", message:"Login successful")
                                        
                                        
                                    } })
        AppDelegate.s_id = sidTF.text!
    }
    
    //This is responsible for displaying OkAlert
    func displayOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)       
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        print("sid is",userID)
        if selectedRole == "Faculty" {
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "facultyIdentifier") as! FacultyTableViewController
            
            viewController.facultyID = userID
            appDelegate.window?.rootViewController = viewController
            
        }
        else {
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "QRCodeStoryBoard") as! QRCodeGeneratorViewController
            viewController.inputSID = userID
            appDelegate.window?.rootViewController = viewController
            
            //   let viewController = mainStoryboard.instantiateViewController(withIdentifier: "roleTVC") as! RoleTableViewController
            //viewController.inputSID = userID
            // appDelegate.window?.rootViewController = viewController
            
        }
        //        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "QRCodeStoryBoard") as! QRCodeGeneratorViewController
        //        viewController.inputSID = userID
        //        appDelegate.window?.rootViewController = viewController
        
        
    }
    
    
    //This is responsible for displaying NotOkAlert
    func displayNotOKAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
    }
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  QRCodeGeneratorViewController.swift
//  Smart-Attendance
//
//  Created by Devdas,Pavithra on 2/16/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import LocalAuthentication

class QRCodeGeneratorViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("value of sid",inputSID)
        sidLBL.text = inputSID
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var inputLBL: UIView!
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    var inputSID:String = ""
    
    @IBOutlet weak var sidLBL: UILabel!
    
    @IBAction func convert(_ sender: Any) {
        
        if let stringVal=sidLBL.text{
            let data = stringVal.data(using: .ascii, allowLossyConversion: false)
            let output=CIFilter(name: "CIQRCodeGenerator")
            output?.setValue(data, forKey: "inputMessage")
            let img=UIImage(ciImage: (output?.outputImage)!)
            firstImageView.image=img
        }
    }
    
    
    @IBAction func touchValidationBTN(_ sender: UIButton) {
        
        let authenticationContext = LAContext()
        //        var error: NSError
        print("in validation")
        
        if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            authenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your touch id", reply: { (wasSuccesful, error) in
                if wasSuccesful {
                    print("success")
                    DispatchQueue.main.async {
                    if let stringVal=self.sidLBL.text{
                        
                        let data = stringVal.data(using: .ascii, allowLossyConversion: false)
                        let output=CIFilter(name: "CIQRCodeGenerator")
                        output?.setValue(data, forKey: "inputMessage")
                        let img=UIImage(ciImage: (output?.outputImage)!)
                        
                        self.firstImageView.image=img
                        }
                    }
                    
                    
                    
                }
                else{
                    print("touch id not authenticated")
                }
                
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ inputSIDTF: UITextField)->Bool{
        inputSIDTF.resignFirstResponder()
        return (true)
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

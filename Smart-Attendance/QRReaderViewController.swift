//
//  QRReaderViewController.swift
//  Smart-Attendance
//
//  Created by Devdas,Pavithra on 3/9/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class QRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    static var courseName : String = ""
    static var facID : String = ""
    
    var video=AVCaptureVideoPreviewLayer()
    let session=AVCaptureSession()
    @IBOutlet weak var square: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Detetcting the OR Codes
        
        //Creating a session
        
        
        //Define to capture video
        let captureDevice=AVCaptureDevice.default(for: AVMediaType.video)
        
        
        //Add capture device into session
        
        do{
            //input for session
            let input=try AVCaptureDeviceInput(device: captureDevice!)
            
            print("input: ",input)
            session.addInput(input)
        }
        catch{
            print("ERROR")
        }
        //output comes out of the session
        let output=AVCaptureMetadataOutput()
        print("output: ",output)
        session.addOutput(output)
        
        //define main queue where output is being processed
        //process this on main thread
        
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes=[AVMetadataObject.ObjectType.qr]
        
        //define what type results you want
        video=AVCaptureVideoPreviewLayer(session:session)
        video.frame=view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: square)
        
        session.startRunning()
        
        
        // let captureDevice=AVCaptureDevice.default(for: AVMediaType)
        
        // Do any additional setup after loading the view.
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0{
            //to process furthur
            if let object=metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type==AVMetadataObject.ObjectType.qr{
                    
                    print("scanned code is: ",object.stringValue as Any)
                    
                    //let attendance = PFObject(className: "Attendance")
                    let attendance = Attendance()
                    
                    //                    attendance["Id"] = object.stringValue
                    //                    attendance["starttime"] = NSDate()
                    //                    attendance["course"] = QRReaderViewController.courseName
                    attendance.sID = object.stringValue!
                    AppDelegate.s_id = attendance.sID
                    attendance.date = String(describing: NSDate())
                    attendance.course = QRReaderViewController.courseName
                    attendance.faculty = QRReaderViewController.facID
                    if object.stringValue != nil {
                        
                        session.stopRunning()
                    }
                    
                    attendance.saveInBackground(block: { (success, error) -> Void in
                        if success {
                            
                            self.displayOKAlert(title: "Success!", message:"record saved.")
                            
                        } else {
                            print(error)
                        }
                    })
                    
                    print("before alert")
                    
                    let alert=UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    //   alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Continue Scanning", style: .default, handler: {(nil) in
                        UIPasteboard.general.string=object.stringValue
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Done!Exit Scanner", style: .default) { (action) -> Void in
                        let viewControllerYouWantToPresent =
                            self.storyboard?.instantiateViewController(withIdentifier: "FacultySummaryViewController")
                        
                        self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                        //  self.presentViewController(viewControllerYouWantToPresent!, animated: true, completion: nil)
                    })
                    // alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {(nil) in
                    //    UIPasteboard.general.string=object.stringValue
                    //  }))
                    session.startRunning()
                    present(alert,animated: true,completion: nil)
                    
                    
                }
            }
        }
    }
    
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        self.present(alert, animated: true)
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
    
}

//
//  FacultySummaryViewController.swift
//  Smart-Attendance
//
//  Created by student on 4/21/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import Parse

class FacultySummaryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    var attendance:[Attendance] = []
  
    
  
    
    @IBOutlet weak var sidLBL: UILabel!
   
    @IBOutlet weak var courseLBL: UILabel!
    @IBOutlet weak var dateLBL: UILabel!
    
    @IBOutlet weak var facultyLBL: UILabel!
    @IBOutlet weak var facSummaryTV: UITableView!
    
    //    class FacultySummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.attendance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendance" ,for:indexPath)
        if self.attendance.count > 0{
//            cell.textLabel?.text = "\(self.attendance[indexPath.row].sID)   \(self.attendance[indexPath.row].faculty)"
//            cell.detailTextLabel?.text = "\(self.attendance[indexPath.row].course)   \(self.attendance[indexPath.row].date)"
//            cell.textLabel?.text = self.attendance[indexPath.row].sID
//            cell.detailTextLabel?.text = self.attendance[indexPath.row].course
            (cell.contentView.viewWithTag(100) as! UILabel).text = self.attendance[indexPath.row].sID
            (cell.contentView.viewWithTag(200) as! UILabel).text = self.attendance[indexPath.row].course
            (cell.contentView.viewWithTag(300) as! UILabel).text = self.attendance[indexPath.row].faculty
            (cell.contentView.viewWithTag(500) as! UILabel).text = self.attendance[indexPath.row].date
           
            
            print("course",self.attendance[indexPath.row].sID,self.attendance[indexPath.row].course,self.attendance[indexPath.row].date)

            
            
        }
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func fetch(sender:AnyObject) {
        sidLBL.text = "SID"
        courseLBL.text = "Course"
        facultyLBL.text = "Faculty"
        dateLBL.text = "Date"
        
        let query = PFQuery(className:"Attendance")     // Fetches all the Movie objects
       
        query.findObjectsInBackground {   // what happened to the ( ) ?
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                //                // The find succeeded.
                //                self.displayOKAlert(title: "Success!",
                //                                    message:"Retrieved \(objects!.count) objects.")
                //                self.movies = objects as! [Movie]
                //                // Do something with the found objects
                //                // Like display them in a table view.
                //                self.moviesTV.reloadData()
                for object in objects!{
                    let record = object as! Attendance
                    self.attendance.append(record)
                }
                print(self.attendance.count)
                self.facSummaryTV.reloadData()
                
            } else {
                // Log details of the failure
                // self.displayOKAlert(title: "Oops", message: "\(error!)")
                print(error!)
            }
            
        }
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

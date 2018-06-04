//
//  MapLocationViewLocaion.swift
//  Smart-Attendance
//
//  Created by Student on 3/31/18.
//  Copyright © 2018 Modali,Naga Sravanthi. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class MapLocationViewLocaion: UIViewController,CLLocationManagerDelegate {
    var timeIntervalInSec :Double = 2.0
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    var location1 : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    // var time=180
    
    
    
    func callTimer()
    {
        Timer.scheduledTimer(timeInterval: timeIntervalInSec, target: self, selector:#selector(scheduledMethod) , userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        callTimer()
        
        
        
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.02)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        location1.latitude = location.coordinate.latitude
        location1.longitude = location.coordinate.longitude
        
        
    }
    @objc func scheduledMethod(){
        print("The latitude is : \(location1.latitude)")
        print("The longitude is : \(location1.longitude)")
        
        // print(manager.startMonitoringSignificantLocationChanges())
        
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

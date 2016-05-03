//
//  ViewController.swift
//  Where
//
//  Created by 季勤强 on 16/5/3.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationLabel: UILabel!
    
    var locationMananger: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    @IBAction func MyLocationButtonDidTouch(sender: AnyObject) {
        locationMananger = CLLocationManager()
        locationMananger.delegate = self;
        locationMananger.desiredAccuracy = kCLLocationAccuracyBest
        locationMananger.requestAlwaysAuthorization()
        locationMananger.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.locationLabel.text = "Error while updating location " + error.localizedDescription
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placeMarks, error)-> Void in
            if (error != nil){
                self.locationLabel.text = "Reverse geocoder failed with error " + error!.localizedDescription
                return
            }
            
            if placeMarks!.count > 0 {
                let pm = placeMarks![0]
                self.displayLocationInfo(pm)
            }else{
                self.locationLabel.text = "Problem with the data received from geocoder"
            }
        })
    }
    
    func displayLocationInfo(placeMark: CLPlacemark?) {
        if let containsPlaceMark = placeMark {
            locationMananger.stopUpdatingLocation()
            let locality = containsPlaceMark.locality != nil ? containsPlaceMark.locality : ""
            let postalCode = containsPlaceMark.postalCode != nil ? containsPlaceMark.postalCode : ""
            let administrativeArea = containsPlaceMark.administrativeArea != nil ? containsPlaceMark.administrativeArea : ""
            let country = containsPlaceMark.country != nil ? containsPlaceMark.country : ""
            self.locationLabel.text = locality! + "," + postalCode! + "," + administrativeArea! + "," + country!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


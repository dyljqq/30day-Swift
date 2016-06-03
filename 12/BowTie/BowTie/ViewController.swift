//
//  ViewController.swift
//  BowTie
//
//  Created by 季勤强 on 16/6/1.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favorateLabel: UILabel!
    
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        insertSampleData()
        
        let request = NSFetchRequest(entityName: "Bowtie")
        let firstTitle = segmentControl.titleForSegmentAtIndex(0)
        
        request.predicate = NSPredicate(format: "searchKey == %@", firstTitle!)
        
        var results = [Bowtie]()
        do {
            results = try managedContext.executeFetchRequest(request) as! [Bowtie]
        }catch let error as NSError {
            print("fetch error: \(error.userInfo)")
        }
        if (results.count > 0){
            populate(results[0])
        }
    }
    
    //MARK: - Action
    
    @IBAction func segmentedControl(sender: AnyObject) {
    }
    
    @IBAction func wear(sender: AnyObject) {
    }
    
    @IBAction func rate(sender: AnyObject) {
    }
    
    //MARK: - private method
    
    func insertSampleData() {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate(format: "searchKey != nil")
        let count = try! managedContext.countForFetchRequest(fetchRequest, error: nil)
        if count > 0 { return }
        
//        let path = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist")
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last?.stringByAppendingString("Info.plist")
        if(!NSFileManager.defaultManager().fileExistsAtPath(path!)){
            print("not exist...")
            return
        }
        
        let dataArray = NSArray(contentsOfFile: path!)
        let entity = NSEntityDescription.entityForName("Bowtie", inManagedObjectContext: managedContext)
        for dict : AnyObject in dataArray! {
            let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext)
            let btDict = dict as! NSDictionary
            
            bowtie.name = btDict["name"] as? String
            bowtie.searchKey = btDict["searchKey"] as? String
            bowtie.rating = btDict["rating"] as? NSNumber
            let tintColor = btDict["tintColor"] as! NSDictionary
            bowtie.tintColor = colorFromDict(tintColor)
            let imageName = btDict["imageName"] as? String
            let image = UIImage(named: imageName!)
            let photoData = UIImagePNGRepresentation(image!)
            bowtie.photoData = photoData!
            
            bowtie.lastWorn = btDict["lastWorn"] as? NSDate
            bowtie.timesWorn = btDict["timesWorn"] as? NSNumber
            bowtie.isFavorate = btDict["isFavorite"] as? NSNumber
            
        }
        
        guard let _ = try? managedContext.save() else {
            print("save error")
            return
        }
        
    }
    
    func colorFromDict(dict: NSDictionary) -> UIColor {
        let red = dict["red"] as! NSNumber
        let green = dict["green"] as! NSNumber
        let blue = dict["blue"] as! NSNumber
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0,
        blue: CGFloat(blue)/255,
        alpha: 1)
        return color;
    }
    
    func populate(bowtie: Bowtie) {
        imageView.image = UIImage(data: bowtie.photoData!)
        nameLabel.text = bowtie.name
        ratingLabel.text = "Rating: \(bowtie.rating!.doubleValue)/5"
        timesWornLabel.text = "# times worn: \(bowtie.timesWorn!.integerValue)"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        lastWornLabel.text = "Last Worn: " + dateFormatter.stringFromDate(bowtie.lastWorn!)
        favorateLabel.hidden = !bowtie.isFavorate!.boolValue
        view.tintColor = bowtie.tintColor as! UIColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


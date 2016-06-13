//
//  ViewController.swift
//  SwipeableCell
//
//  Created by 季勤强 on 16/6/13.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [
        pattern(image: "1", name: "Pattern Building"),
        pattern(image: "2", name: "Joe Beez"),
        pattern(image: "3", name: "Car It's car"),
        pattern(image: "4", name: "Floral Kaleidoscopic"),
        pattern(image: "5", name: "Sprinkle Pattern"),
        pattern(image: "6", name: "Palitos de queso"),
        pattern(image: "7", name: "Ready to Go? Pattern"),
        pattern(image: "8", name: "Sets Seamless"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Delegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PatternCell", forIndexPath: indexPath) as! PatternCell
        let pattern = self.data[indexPath.row]
        cell.patternImageView?.image = UIImage(named: pattern.image)
        cell.patternNameLabel.text = pattern.name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Normal, title: "delete") { (action, indexPath) in
            print("Delete button tapped")
        }
        delete.backgroundColor = UIColor.grayColor()
        
        let share = UITableViewRowAction(style: .Normal, title: "share") { (action, indexPath) in
            
            let item = self.data[indexPath.row]
            let activityController = UIActivityViewController(activityItems: [item.image as NSString], applicationActivities: nil)
            self.presentViewController(activityController, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor.redColor()
        
        let download = UITableViewRowAction(style: .Normal, title: "download") { action, indexPath in
            print("Download button tapped")
        }
        download.backgroundColor = UIColor.blueColor()
        
        return [delete, share, download]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


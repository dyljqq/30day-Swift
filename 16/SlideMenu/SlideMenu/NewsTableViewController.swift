//
//  ViewController.swift
//  SlideMenu
//
//  Created by 季勤强 on 16/6/6.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, MenuTransitionManagerDelegate {

    let menuTransitionManager = MenuTransitionManager()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Everyday Moments"
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.backgroundColor = UIColor(red:0.062, green:0.062, blue:0.07, alpha:1)
    }
    
    //MARK: - Delegate
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
        
        cell.backgroundColor = UIColor.clearColor()
        
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "1")
            cell.titleLabel.text = "Love mountain."
            cell.authorLabel.text = "Allen Wang"
            cell.authorImageView.image = UIImage(named: "a")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "2")
            cell.titleLabel.text = "New graphic design - LIVE FREE"
            cell.authorLabel.text = "Cole"
            cell.authorImageView.image = UIImage(named: "b")
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "3")
            cell.titleLabel.text = "Summer sand"
            cell.authorLabel.text = "Daniel Hooper"
            cell.authorImageView.image = UIImage(named: "c")
            
        } else {
            cell.postImageView.image = UIImage(named: "4")
            cell.titleLabel.text = "Seeking for signal"
            cell.authorLabel.text = "Noby-Wan Kenobi"
            cell.authorImageView.image = UIImage(named: "d")
            
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuTableViewController = segue.destinationViewController as! MenuTableViewController
        menuTableViewController.currentItem = self.title!
        menuTableViewController.transitioningDelegate = menuTransitionManager
        menuTransitionManager.delegate = self
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.sourceViewController as! MenuTableViewController
        self.title = sourceController.currentItem
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


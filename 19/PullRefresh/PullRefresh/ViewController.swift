//
//  ViewController.swift
//  PullRefresh
//
//  Created by 季勤强 on 16/6/7.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: Array<String> = ["😂", "🤗", "😳", "😌", "😊"]
    var customView: RefreshView!
    var refreshControl: UIRefreshControl!
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = UIColor.clearColor()
        tableView.addSubview(refreshControl)
        
        loadRefreshContent()
        
    }
    
    //MARK: - Delegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing && !self.customView.isAnimating{
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "endRefresh", userInfo: nil, repeats: false)
            self.customView.isRefreshing = true
            self.customView.animateRefresh()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 40)
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MARK: - Private Method
    
    func loadRefreshContent() {
        customView = RefreshView(frame: self.refreshControl.bounds)
        customView.initWithString("#30DAYSWIFT")
        refreshControl.addSubview(customView)
    }
    
    func endRefresh() {
        refreshControl.endRefreshing()
        self.customView.isRefreshing = false
        self.customView.endRefresh()
        timer.invalidate()
        timer = nil
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


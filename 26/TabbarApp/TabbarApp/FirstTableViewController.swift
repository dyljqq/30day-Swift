//
//  FirstTableViewController.swift
//  TabbarApp
//
//  Created by 季勤强 on 16/6/16.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    var data = [
        article(avatarImage: "allen", sharedName: "Allen Wang", actionType: "Read Later", articleTitle: "Giphy Cam Lets You Create And Share Homemade Gifs", articleCoverImage: "giphy", articleSouce: "TheNextWeb", articleTime: "5min  •  13:20"),
        article(avatarImage: "Daniel Hooper", sharedName: "Daniel Hooper", actionType: "Shared on Twitter", articleTitle: "Principle. The Sketch of Prototyping Tools", articleCoverImage: "my workflow flow", articleSouce: "SketchTalk", articleTime: "3min  •  12:57"),
        article(avatarImage: "davidbeckham", sharedName: "David Beckham", actionType: "Shared on Facebook", articleTitle: "Ohlala, An Uber For Escorts, Launches Its ‘Paid Dating’ Service In NYC", articleCoverImage: "Ohlala", articleSouce: "TechCrunch", articleTime: "1min  •  12:59"),
        article(avatarImage: "bruce", sharedName: "Bruce Fan", actionType: "Shared on Weibo", articleTitle: "Lonely Planet’s new mobile app helps you explore major cities like a pro", articleCoverImage: "Lonely Planet", articleSouce: "36Kr", articleTime: "5min  •  11:21")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        animate()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: - Delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticalTableViewCell
        let article = data[indexPath.row]
        cell.avatarImageView.image = UIImage(named: article.avatarImage)
        cell.avatarName.text = article.sharedName
        cell.actionTypeLabel.text = article.sharedName
        cell.articalCoverImageView.image = UIImage(named: article.articleCoverImage)
        cell.articalContentLabel.text = article.articleTitle
        cell.articalSourceLabel.text = article.articleSouce
        cell.articalTimeLabel.text = article.articleTime
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 165
    }
    
    //MARK: Private Method
    
    func animate() {
        self.tableView.reloadData()
        
        let cells = self.tableView.visibleCells
        let height = self.tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransformMakeTranslation(0, height)
        }
        
        var index = 0
        for cell in cells {
            UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformIdentity
                }, completion: nil)
            index++
        }
    }
    
}
